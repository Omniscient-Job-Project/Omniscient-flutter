import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart'; // dotenv 패키지 import
import '../models/board.dart';

class BoardService {
  final String apiUrl = dotenv.env['API_URL'] ?? 'http://localhost:8080/api/v1/boards';  // API 엔드포인트를 환경 변수에서 가져옴

// 전체 게시글 가져오기
  Future<List<Board>> getAllBoards() async {
    final response = await http.get(Uri.parse('$apiUrl/boards'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Board.fromJson(data)).toList();
    } else {
      // 에러가 발생했을 때 빈 리스트 반환
      return []; // 예외 대신 빈 리스트를 반환
    }
  }


  // 단일 게시글 상세 보기
  Future<Board> getBoard(int boardId) async {
    final response = await http.get(Uri.parse('$apiUrl/$boardId'));

    if (response.statusCode == 200) {
      return Board.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load board');
    }
  }

  // 게시글 생성
  Future<Board> createBoard(Board board) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        'title': board.title,
        'content': board.content,
        'category': board.category,
        'status': board.status,
      }),
    );

    if (response.statusCode == 201) {
      return Board.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create board');
    }
  }
}
