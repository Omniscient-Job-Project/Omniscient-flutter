import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class UserRepository {
  final String apiUrl;

  UserRepository(this.apiUrl);

  Future<User?> fetchUser(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$apiUrl/api/v1/user/me'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      // 응답이 성공적일 때만 JSON 파싱 시도
      if (response.statusCode == 200) {
        final contentType = response.headers['content-type'];
        if (contentType != null && contentType.contains('application/json')) {
          return User.fromJson(json.decode(response.body));
        } else {
          throw FormatException('Invalid content type: $contentType');
        }
      } else {
        // 상태 코드 및 응답 내용을 출력하여 오류를 확인
        print('Failed to load user. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to load user');
      }
    } catch (error) {
      print('Error fetching user: $error');
      return null;
    }
  }
}
