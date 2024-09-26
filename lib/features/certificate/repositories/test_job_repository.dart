// repositories/test_job_repository.dart
import '../models/test_job.dart';
import '/core/services/api_service.dart';

class TestJobRepository {
  final ApiService _apiService = ApiService();

  Future<List<TestJob>> fetchTestJobs() async {
    try {
      return await _apiService.fetchTestJobs();
    } catch (e) {
      throw Exception('시험 일정 데이터를 불러오는 중 오류 발생: $e');
    }
  }
}
