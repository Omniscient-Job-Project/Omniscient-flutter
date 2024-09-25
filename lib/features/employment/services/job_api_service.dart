import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:omniscient/features/employment/models/job.dart';

class JobApiService {
  static const String baseUrl = 'http://10.0.2.2:8080'; // 로컬 개발 서버 URL
  static const int timeoutSeconds = 30;

  // 전체 일자리 정보 조회
  Future<List<Job>> fetchJobs() async {
    // 수정된 API 엔드포인트
    return _getAndParseJobs('$baseUrl/api/v1/seoul/jobinfo');
  }

  // 특정 ID의 일자리 정보 조회
  Future<Job> fetchJobById(String jobId) async {
    // 수정된 API 엔드포인트
    return _getAndParseJob('$baseUrl/api/v1/seoul/jobinfo/$jobId');
  }

  // 일자리 검색 기능 (백엔드에서 제공하지 않는 경우 주석 처리 또는 삭제)
  // Future<List<Job>> searchJobs(String query) async {
  //   final encodedQuery = Uri.encodeComponent(query);
  //   return _getAndParseJobs('$baseUrl/api/v1/seoul/jobinfo?param=$encodedQuery');
  // }

  Future<List<Job>> _getAndParseJobs(String url) async {
    try {
      final response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: timeoutSeconds));

      if (response.statusCode == 200) {
        // 백엔드 응답 구조에 맞게 파싱 로직 수정
        final jsonData = json.decode(response.body) as Map<String, dynamic>;
        print('API Response: $jsonData');

        if (jsonData.containsKey('GetJobInfo')) {
          // 서울시 API 응답 구조
          final jobsData = jsonData['GetJobInfo']['row'] as List;
          return jobsData.map((jobJson) => Job.fromJson(jobJson as Map<String, dynamic>)).toList();
        } else if (jsonData.containsKey('GGJOBABARECRUSTM')) {
          // 경기도 API 응답 구조
          final jobsData = jsonData['GGJOBABARECRUSTM']['row'] as List;
          return jobsData.map((jobJson) => Job.fromJson(jobJson as Map<String, dynamic>)).toList();
        } else {
          throw FormatException('Unexpected JSON structure: ${response.body}');
        }
      } else {
        throw HttpException('Failed to load jobs: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching jobs: $e');
      rethrow;
    }
  }

  Future<Job> _getAndParseJob(String url) async {
    try {
      final response = await http.get(Uri.parse(url)).timeout(Duration(seconds: timeoutSeconds));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as Map<String, dynamic>;
        print('API Response: $jsonData');

        // 백엔드 응답 구조에 따라 파싱 로직 수정
        if (jsonData.containsKey('GetJobInfo')) {
          // 서울시 API 응답 구조
          final jobData = jsonData['GetJobInfo']['row'][0] as Map<String, dynamic>;
          return Job.fromJson(jobData);
        } else if (jsonData.containsKey('GGJOBABARECRUSTM')) {
          // 경기도 API 응답 구조
          final jobData = jsonData['GGJOBABARECRUSTM']['row'][0] as Map<String, dynamic>;
          return Job.fromJson(jobData);
        } else {
          // 단일 job 객체가 직접 반환되는 경우
          return Job.fromJson(jsonData);
        }
      } else {
        throw HttpException('Failed to load job details: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching job details: $e');
      rethrow;
    }
  }
}

class HttpException implements Exception {
  final String message;
  HttpException(this.message);
  @override
  String toString() => message;
}