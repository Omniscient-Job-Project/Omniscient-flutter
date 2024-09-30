import 'package:flutter/material.dart';
import '../models/board.dart';
import '../services/board_service.dart';
import 'board_detail_page.dart';
import 'board_post_page.dart';

class BoardListPage extends StatefulWidget {
  @override
  _BoardListPageState createState() => _BoardListPageState();
}

class _BoardListPageState extends State<BoardListPage> {
  late Future<List<Board>> futureBoards;
  final BoardService boardService = BoardService();
  String selectedCategory = '전체글';
  int currentPage = 1;
  final int itemsPerPage = 20;

  @override
  void initState() {
    super.initState();
    futureBoards = boardService.getAllBoards();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('자유게시판')),
      body: Column(
        children: [
          // 공지사항
          Container(
            padding: EdgeInsets.all(15),
            color: Color(0xFFE3F2FD),
            child: Text(
              '📢 공지사항: 이 게시판은 자유롭게 글을 작성할 수 있는 공간입니다. 부적절한 게시글은 사전 경고 없이 삭제될 수 있습니다.',
              style: TextStyle(color: Color(0xFF1565C0), fontSize: 14),
            ),
          ),

          // 카테고리 버튼
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildCategoryButton('전체글'),
                _buildCategoryButton('RECRUITMENT'),
                _buildCategoryButton('CERTIFICATION'),
              ],
            ),
          ),

          // 게시글 목록
          Expanded(
            child: FutureBuilder<List<Board>>(
              future: futureBoards,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("오류가 발생했습니다. 나중에 다시 시도해주세요."));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text("등록된 게시물이 없습니다."));
                }

                List<Board> boards = snapshot.data!;
                // 필터링된 게시글
                List<Board> filteredBoards = boards.where((board) {
                  return selectedCategory == '전체글' || board.category == selectedCategory;
                }).toList();

                // 페이지네이션
                int totalPages = (filteredBoards.length / itemsPerPage).ceil();
                int startIndex = (currentPage - 1) * itemsPerPage;
                int endIndex = startIndex + itemsPerPage;
                List<Board> paginatedBoards = filteredBoards.sublist(
                  startIndex,
                  endIndex < filteredBoards.length ? endIndex : filteredBoards.length,
                );

                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: paginatedBoards.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(paginatedBoards[index].title),
                            subtitle: Text(paginatedBoards[index].createdAt),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BoardDetailPage(boardId: paginatedBoards[index].boardId),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),

                    // 페이지네이션
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.chevron_left),
                          onPressed: currentPage > 1
                              ? () {
                            setState(() {
                              currentPage--;
                            });
                          }
                              : null,
                        ),
                        Text('$currentPage / $totalPages'),
                        IconButton(
                          icon: Icon(Icons.chevron_right),
                          onPressed: currentPage < totalPages
                              ? () {
                            setState(() {
                              currentPage++;
                            });
                          }
                              : null,
                        ),
                      ],
                    ),

                    // 게시글 작성 버튼
                    if (selectedCategory == 'RECRUITMENT' || selectedCategory == 'CERTIFICATION')
                      ElevatedButton(
                        onPressed: () {
                          // 카테고리를 CreateBoardPage로 전달
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CreateBoardPage(category: selectedCategory)),
                          );
                        },
                        child: Text('게시글 작성'),
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryButton(String category) {
    return TextButton(
      onPressed: () {
        setState(() {
          selectedCategory = category;
          currentPage = 1; // 카테고리 변경 시 페이지를 1로 초기화
          futureBoards = boardService.getAllBoards(); // 데이터를 새로 가져오도록 설정
        });
      },
      child: Text(
        category,
        style: TextStyle(
          color: selectedCategory == category ? Colors.blue : Colors.black,
        ),
      ),
    );
  }
}
