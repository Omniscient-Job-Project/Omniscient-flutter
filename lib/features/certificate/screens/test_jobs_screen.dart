import 'package:flutter/material.dart';
import '../../../core/services/api_service.dart';
import '../../mypage/repositories/scrap_repository.dart';
import '../models/test_job.dart';
import '../widgets/test_job_list.dart';
import '/core/widgets/header.dart';
import '/core/widgets/footer.dart';

class TestJobsScreen extends StatefulWidget {
  @override
  _TestJobsScreenState createState() => _TestJobsScreenState();
}

class _TestJobsScreenState extends State<TestJobsScreen> {
  final ApiService _apiService = ApiService(); // ApiService 인스턴스 생성
  final ScrapRepository _scrapRepository = ScrapRepository();  // ScrapRepository 인스턴스 생성
  List<TestJob> _allTestJobs = []; // 전체 시험 일정 데이터
  List<TestJob> _displayedTestJobs = []; // 현재 페이지에 표시할 시험 일정 데이터
  List<TestJob> _filteredTestJobs = []; // 검색 필터링된 데이터
  List<TestJob> _favoriteTestJobs = []; // 즐겨찾기된 시험 일정

  String _searchKeyword = ''; // 검색어
  int _currentPage = 1;
  final int _itemsPerPage = 5;  // 한 페이지에 표시할 아이템 수

  @override
  void initState() {
    super.initState();
    _fetchTestJobs();  // 페이지 로드 시 데이터를 가져옴
    _loadFavoriteTestJobs(); // 즐겨찾기된 시험 일정 로드
  }

  // 모든 시험 일정을 가져오고 페이지네이션을 초기화
  void _fetchTestJobs() async {
    try {
      List<TestJob> testJobs = await _apiService.fetchTestJobs();
      setState(() {
        _allTestJobs = testJobs;  // 모든 데이터를 가져옴
        _applyFilterAndPagination();  // 필터링 및 페이지네이션 적용
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('시험 일정 데이터를 불러오는 중 오류 발생: $e')),
      );
    }
  }

  // 스크랩에서 즐겨찾기된 시험 일정을 로드
  Future<void> _loadFavoriteTestJobs() async {
    List<TestJob> savedFavorites = await _scrapRepository.loadFavoriteTestJobs();  // ScrapRepository에서 즐겨찾기 로드
    setState(() {
      _favoriteTestJobs = savedFavorites;
    });
  }

  // 즐겨찾기 추가/삭제 및 스크랩 저장
  void _toggleFavorite(TestJob job) async {
    setState(() {
      if (_favoriteTestJobs.contains(job)) {
        _favoriteTestJobs.remove(job); // 즐겨찾기에서 삭제
      } else {
        _favoriteTestJobs.add(job); // 즐겨찾기에 추가
      }
    });
    // 스크랩 리스트에 저장
    await _scrapRepository.saveFavoriteTestJobs(_favoriteTestJobs);
  }

  // 검색어에 따라 데이터를 필터링하고, 페이지네이션을 적용
  void _applyFilterAndPagination() {
    // 검색어에 따라 필터링
    if (_searchKeyword.isNotEmpty) {
      _filteredTestJobs = _allTestJobs.where((job) {
        return job.qualgbNm.toLowerCase().contains(_searchKeyword.toLowerCase()) ||
            job.description.toLowerCase().contains(_searchKeyword.toLowerCase());
      }).toList();
    } else {
      _filteredTestJobs = List.from(_allTestJobs); // 검색어가 없으면 모든 데이터를 표시
    }

    // 페이지네이션 적용
    _applyPagination();
  }

  // 페이지네이션 적용
  void _applyPagination() {
    int startIndex = (_currentPage - 1) * _itemsPerPage;
    int endIndex = startIndex + _itemsPerPage;

    if (startIndex > _filteredTestJobs.length) {
      startIndex = 0;
      _currentPage = 1;
    }
    if (endIndex > _filteredTestJobs.length) {
      endIndex = _filteredTestJobs.length;
    }

    setState(() {
      _displayedTestJobs = _filteredTestJobs.sublist(startIndex, endIndex);
    });
  }

  // 페이지를 변경할 때마다 표시되는 데이터를 업데이트
  void _changePage(int page) {
    setState(() {
      _currentPage = page;
      _applyPagination();
    });
  }

  // 검색어가 변경될 때마다 필터링 및 페이지네이션 적용
  void _onSearchChanged(String keyword) {
    setState(() {
      _searchKeyword = keyword;
      _currentPage = 1; // 검색 시 페이지를 1로 초기화
      _applyFilterAndPagination();
    });
  }

  @override
  Widget build(BuildContext context) {
    // 전체 페이지 수 계산
    int totalItems = _filteredTestJobs.length;
    int totalPages = (totalItems / _itemsPerPage).ceil();

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
            // 검색창 추가
            TextField(
              decoration: InputDecoration(
                hintText: '검색어를 입력하세요...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: _onSearchChanged,  // 검색어가 변경될 때 호출
            ),
            SizedBox(height: 16),
            Text(
              '시험 일정',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            // 시험 일정 리스트와 페이지네이션
            Expanded(
              child: _displayedTestJobs.isEmpty
                  ? Center(child: Text('시험 일정 데이터가 없습니다.'))
                  : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: _displayedTestJobs.length,
                      itemBuilder: (context, index) {
                        return TestJobList(
                          testJobs: [_displayedTestJobs[index]],
                          onFavoritePressed: _toggleFavorite, // 즐겨찾기 토글 버튼
                          isFavorite: _favoriteTestJobs.contains(_displayedTestJobs[index]),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 16),
                  _buildPagination(totalPages),  // 페이지네이션 표시
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Footer(),  // Footer 추가
    );
  }

  // 페이지네이션 UI 생성
  Widget _buildPagination(int totalPages) {
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
