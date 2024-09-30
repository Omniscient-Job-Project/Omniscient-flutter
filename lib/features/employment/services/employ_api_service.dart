import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // 환경변수 사용
import '../models/employment.dart';

class EmploymentService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: dotenv.env['API_URL'] ?? 'http://default.url',
    responseType: ResponseType.plain,
  ));

  Future<List<Employment>> fetchEmploymentList({int numOfRows = 100}) async {
    try {
      final response = await _dio.get('/api/v1/employment', queryParameters: {
        'numOfRows': numOfRows,
      });
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.data);
        final List<dynamic> employmentList = data['GGEMPLTSP']['row']; // JSON 구조에 맞게 수정
        return employmentList.map((json) => Employment.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load employment data');
      }
    } catch (e) {
      throw Exception('Error fetching employment data: $e');
    }
  }

  // 검색으로 채용 정보 찾기
  Future<List<Employment>> searchJobs(String query) async {
    try {
      final response = await _dio.get('/api/v1/employment/search', queryParameters: {
        'query': query,
      });
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.data);
        final List<dynamic> employmentList = data['data']; // JSON 구조에 맞게 수정
        return employmentList.map((json) => Employment.fromJson(json)).toList();
      } else {
        throw Exception('Failed to search employment data');
      }
    } catch (e) {
      throw Exception('Error searching employment data: $e');
    }
  }
}
