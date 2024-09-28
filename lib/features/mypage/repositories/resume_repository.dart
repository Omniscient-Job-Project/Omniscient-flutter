import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/resume.dart';

class ResumeRepository {
  final String apiUrl;

  ResumeRepository(this.apiUrl);

  Future<Resume> fetchResume() async {
    final response = await http.get(Uri.parse('$apiUrl/api/v1/mypage/resumes'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Resume.fromJson(data);
    } else {
      throw Exception('Failed to load resume');
    }
  }
}
