import 'package:flutter/material.dart';
import '../models/board.dart';
import '../services/board_service.dart';

class CreateBoardPage extends StatefulWidget {
  final String category; // 카테고리를 받는 변수 추가

  CreateBoardPage({required this.category}); // 생성자에 category 추가

  @override
  _CreateBoardPageState createState() => _CreateBoardPageState();
}

class _CreateBoardPageState extends State<CreateBoardPage> {
  final _formKey = GlobalKey<FormState>(); // 폼 키 추가
  final BoardService boardService = BoardService(); // BoardService 객체 생성
  String title = ''; // 제목 필드
  String content = ''; // 내용 필드
  late String category; // 카테고리 변수

  @override
  void initState() {
    super.initState();
    category = widget.category; // 전달된 category를 사용
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('게시글 작성')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: '제목'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '제목을 입력하세요';
                  }
                  return null;
                },
                onSaved: (value) {
                  title = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: '내용'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '내용을 입력하세요';
                  }
                  return null;
                },
                onSaved: (value) {
                  content = value!;
                },
              ),
              // 카테고리 필드는 전달받은 값으로 초기화
              DropdownButtonFormField<String>(
                value: category,
                decoration: InputDecoration(labelText: '카테고리'),
                onChanged: (newValue) {
                  setState(() {
                    category = newValue!;
                  });
                },
                items: [
                  DropdownMenuItem(child: Text('채용'), value: 'RECRUITMENT'),
                  DropdownMenuItem(child: Text('자격증'), value: 'CERTIFICATION'),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Board newBoard = Board(
                      boardId: 0, // 서버에서 자동 생성
                      title: title,
                      content: content,
                      category: category,
                      createdAt: DateTime.now().toString(),
                      updatedAt: null,
                      status: true,
                    );
                    boardService.createBoard(newBoard).then((_) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('게시글이 등록되었습니다.')));
                      Navigator.pop(context);
                    }).catchError((error) {
                      // 에러 처리
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('게시글 등록에 실패했습니다.')));
                    });
                  }
                },
                child: Text('등록하기'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
