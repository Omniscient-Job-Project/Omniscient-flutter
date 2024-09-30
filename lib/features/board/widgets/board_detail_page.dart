import 'package:flutter/material.dart';
import '../models/board.dart';
import '../services/board_service.dart';


class BoardDetailPage extends StatelessWidget {
  final int boardId;

  const BoardDetailPage({Key? key, required this.boardId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BoardService boardService = BoardService();

    return Scaffold(
      appBar: AppBar(title: Text('게시글 상세보기')),
      body: FutureBuilder<Board>(
        future: boardService.getBoard(boardId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Board? board = snapshot.data;
            return Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(board!.title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  SizedBox(height: 16),
                  Text(board.content),
                  SizedBox(height: 16),
                  Text("카테고리: ${board.category}"),
                  SizedBox(height: 16),
                  Text("작성일: ${board.createdAt}"),
                  if (board.updatedAt != null) Text("수정일: ${board.updatedAt}"),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
