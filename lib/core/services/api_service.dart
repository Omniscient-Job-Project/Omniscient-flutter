// core/services/api_service.dart
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // dotenv 패키지 임포트
import 'package:omniscient/features/certificate/models/test_job.dart'; // TestJob 클래스 임포트

class ApiService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: dotenv.env['API_URL'] ?? 'http://default.url',
    responseType: ResponseType.plain,
  ));

  // fetchTestJobs 메서드
  Future<List<TestJob>> fetchTestJobs({String? token, int numOfRows = 100}) async {
    try {
      final response = await _dio.get(
        '/api/v1/testjob',
        queryParameters: {
          'numOfRows': numOfRows,  // 한 번에 불러올 데이터 개수 설정
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token', // 토큰 포함
          },
        ),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.data);

        // API 응답 데이터 구조에 따라 접근 경로 수정
        var itemsData = data['response']?['body']?['items']?['item'];

        List<TestJob> testJobs = [];

        if (itemsData != null) {
          if (itemsData is List) {
            // itemsData가 리스트인 경우
            testJobs = itemsData.map((item) => TestJob.fromJson(item)).toList();
          } else if (itemsData is Map<String, dynamic>) {
            // itemsData가 단일 객체인 경우
            testJobs = [TestJob.fromJson(itemsData)];
          }
        }

        return testJobs;
      } else {
        throw Exception('Failed to load test jobs: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching test jobs: $e');
      throw Exception('Error fetching test jobs: $e');
    }
  }
}
