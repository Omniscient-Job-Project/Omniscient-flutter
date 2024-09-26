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

  Future<Response> getRequest(String endpoint) async {
    try {
      return await _dio.get(endpoint);
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

  Future<Response> postRequest(String endpoint, Map<String, dynamic> data) async {
    try {
      return await _dio.post(endpoint, data: data);
    } catch (e) {
      throw Exception('Failed to post data: $e');
    }
  }

  // fetchTestJobs 메서드를 ApiService 클래스 내부로 이동
  Future<List<TestJob>> fetchTestJobs() async {
    try {
      final response = await _dio.get('/api/v1/testjob');

      if (response.statusCode == 200) {
        // responseType이 ResponseType.plain이므로, response.data는 String 타입입니다.
        final Map<String, dynamic> data = jsonDecode(response.data);

        // API 응답 데이터 구조에 따라 접근 경로 수정
        // 예시 응답 구조:
        // {
        //   "response": {
        //     "body": {
        //       "items": {
        //         "item": [ ... ]
        //       }
        //     }
        //   }
        // }
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
        throw Exception('Failed to load test jobs');
      }
    } catch (e) {
      print('Error fetching test jobs: $e');
      throw Exception('Error fetching test jobs: $e');
    }
  }
}
