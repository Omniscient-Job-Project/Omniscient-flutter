import 'package:omniscient/features/employment/models/job.dart';

class JobRepository {
  Future<List<Job>> fetchJobs() async {
    // TODO: Implement actual API call
    await Future.delayed(Duration(seconds: 1)); // Simulating network delay
    return List.generate(50, (index) => Job(
      id: 'job$index',
      title: '채용 공고 ${index + 1}',
      company: '회사 ${index + 1}',
      location: '위치 ${index + 1}',
      career: '경력 ${index % 3 + 1}년',
      salary: '연봉 ${3000 + (index * 100)}만원',
      employmentType: '정규직', // 추가된 필수 매개변수
      webInfoUrl: 'https://example.com/job$index', // 추가된 필수 매개변수
    ));
  }

  Future<List<Job>> searchJobs(String query) async {
    // TODO: Implement actual search API call
    await Future.delayed(Duration(seconds: 1)); // Simulating network delay
    return List.generate(10, (index) => Job(
      id: 'searchJob$index',
      title: '$query 관련 채용 공고 ${index + 1}',
      company: '회사 ${index + 1}',
      location: '위치 ${index + 1}',
      career: '경력 ${index % 3 + 1}년',
      salary: '연봉 ${3000 + (index * 100)}만원',
      employmentType: '계약직', // 추가된 필수 매개변수
      webInfoUrl: 'https://example.com/search$index', // 추가된 필수 매개변수
    ));
  }
}