import 'package:flutter/material.dart';
import '../../../core/services/api_service.dart';
import '../models/test_job.dart';
import '../widgets/test_job_list.dart';
import '/core/widgets/header.dart';
import '/core/widgets/footer.dart';

class TestJobsScreen extends StatefulWidget {
  @override
  _TestJobsScreenState createState() => _TestJobsScreenState();
}

class _TestJobsScreenState extends State<TestJobsScreen> {
  late Future<List<TestJob>> _testJobs;
  final ApiService _apiService = ApiService(); // ApiService 인스턴스 생성
  int _currentPage = 1;
  int _itemsPerPage = 10;

  @override
  void initState() {
    super.initState();
    _fetchTestJobs();
  }

  void _fetchTestJobs() {
    _testJobs = _apiService.fetchTestJobs();
  }


  void _changePage(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),  // Header 높이 설정
        child: Header(),  // Header 추가
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '시험 일정',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            // FutureBuilder로 시험 일정 데이터를 불러옴
            Expanded(
              child: FutureBuilder<List<TestJob>>(
                future: _testJobs,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('오류 발생: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('시험 일정 데이터가 없습니다.'));
                  }

                  final testJobs = snapshot.data!;
                  final paginatedTestJobs = testJobs
                      .skip((_currentPage - 1) * _itemsPerPage)
                      .take(_itemsPerPage)
                      .toList();

                  return Column(
                    children: [
                      Expanded(child: TestJobList(testJobs: paginatedTestJobs)),
                      _buildPagination(testJobs.length),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Footer(),  // Footer 추가
    );
  }

  Widget _buildPagination(int totalItems) {
    final totalPages = (totalItems / _itemsPerPage).ceil();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: _currentPage > 1 ? () => _changePage(_currentPage - 1) : null,
        ),
        Text('$_currentPage / $totalPages'),
        IconButton(
          icon: Icon(Icons.chevron_right),
          onPressed: _currentPage < totalPages ? () => _changePage(_currentPage + 1) : null,
        ),
      ],
    );
  }
}
