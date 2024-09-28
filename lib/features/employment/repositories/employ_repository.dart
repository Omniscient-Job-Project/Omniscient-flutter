import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // 환경변수 사용
import '../models/employment.dart';

class EmployRepository {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: dotenv.env['API_URL'] ?? 'http://default.url', // 환경변수에서 API_URL 로드
    responseType: ResponseType.plain,
  ));

  // 채용 정보 가져오기
  Future<List<Employment>> fetchEmployment(String category) async {
    try {
      final response = await _dio.get(
        '/employment',
        queryParameters: {
          'category': category, // 카테고리로 필터링
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.data); // response.data는 String이므로 jsonDecode
        final List<dynamic> employmentList = data['data']; // 'data' 키에서 리스트 추출
        return employmentList.map((json) => Employment.fromJson(json)).toList(); // Employment 모델로 변환
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
      final response = await _dio.get(
        '/employment/search',
        queryParameters: {
          'query': query, // 검색어로 필터링
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.data);
        final List<dynamic> employmentList = data['data'];
        return employmentList.map((json) => Employment.fromJson(json)).toList();
      } else {
        throw Exception('Failed to search employment data');
      }
    } catch (e) {
      throw Exception('Error searching employment data: $e');
    }
  }
}
