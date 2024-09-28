import 'dart:convert';

import '../../../core/services/api_employ_service.dart';
import '../../../core/services/api_job_service.dart';
import '../models/job.dart';

class JobRepository {
  final ApiJobService apiService;

  // 생성자에서 ApiService를 주입받음
  JobRepository(this.apiService);

  // 채용 정보를 모두 가져오는 메서드
  Future<List<Job>> getJobs({int numOfRows = 100}) async {
    try {
      // API 서비스에서 데이터를 가져옴
      final response = await apiService.getRequest('/api/v1/seoul/jobinfo?numOfRows=$numOfRows');

      // 받아온 원본 데이터를 출력해봅니다.
      print('Response data: ${response.data}');

      // 받아온 데이터를 JSON으로 변환
      final Map<String, dynamic> jsonData = jsonDecode(response.data);

      // 'GetJobInfo' 필드가 존재하고 그 안에 'row' 리스트가 있을 경우 처리
      if (jsonData.containsKey('GetJobInfo') && jsonData['GetJobInfo']['row'] is List) {
        final List<dynamic> jobsData = jsonData['GetJobInfo']['row']; // 'row' 리스트 추출
        return jobsData.map((jobData) => Job.fromJson(jobData)).toList();
      } else {
        throw Exception('Invalid job data format');
      }
    } catch (e) {
      throw Exception('Failed to load jobs: $e');
    }
  }

  // 특정 ID에 해당하는 채용 정보를 가져오는 메서드
  Future<Job?> getJobById(String jobId) async {
    try {
      // API 서비스에서 데이터를 가져옴
      final response = await apiService.getRequest('/api/v1/seoul/jobinfo/$jobId');

      // 받아온 데이터를 JSON으로 변환
      final Map<String, dynamic> jsonData = jsonDecode(response.data);

      // 'GetJobInfo' 필드 내에 있는 데이터를 Job 모델로 변환하여 반환
      if (jsonData.containsKey('GetJobInfo')) {
        return Job.fromJson(jsonData['GetJobInfo']);
      } else {
        throw Exception('Invalid job data format');
      }
    } catch (e) {
      throw Exception('Failed to load job with ID $jobId: $e');
    }
  }
}
