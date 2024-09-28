import 'package:flutter/material.dart';
import '../../../core/services/api_employ_service.dart';
import '../../../core/widgets/header.dart';
import '../models/job.dart';  // Job 모델을 사용
import '../repositories/job_repository.dart';  // JobRepository로 변경
import '../widgets/job_card.dart';  // JobCard 위젯 사용
import '../widgets/search_bar.dart' as custom;
import '../widgets/curation_index.dart';

class JobMainPage extends StatefulWidget {
  const JobMainPage({Key? key}) : super(key: key);

  @override
  _JobMainPageState createState() => _JobMainPageState();
}

class _JobMainPageState extends State<JobMainPage> {
  final JobRepository _jobRepository = JobRepository(ApiService()); // JobRepository를 사용
  String selectedCategory = 'home';  // 초기 카테고리를 'home'으로 설정
  List<Job> jobs = [];  // Employment 대신 Job 리스트로 변경
  int currentPage = 1;
  int itemsPerPage = 16;

  @override
  void initState() {
    super.initState();
    loadJobs();  // loadEmployments 대신 loadJobs로 변경
  }

  Future<void> loadJobs() async {
    try {
      List<Job> fetchedJobs = await _jobRepository.getJobs(numOfRows: 100);  // Job 데이터 불러오기
      setState(() {
        jobs = fetchedJobs;
      });
    } catch (e) {
      print('Error loading job data: $e');
    }
  }

  Future<void> searchJobs(String query) async {
    try {
      final searchResults = await _jobRepository.getJobs(numOfRows: 100); // 검색 기능 (수정 필요)
      setState(() {
        jobs = searchResults;
        currentPage = 1;
      });
    } catch (e) {
      print('Error searching jobs: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: Header(),
      ),
      body: Container(
        color: const Color(0xFFE6F3FF),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CurationIndex(
                    selectedCategory: selectedCategory,
                    onCategorySelected: (category) {
                      setState(() {
                        selectedCategory = category;
                      });
                      loadJobs();  // 카테고리 변경 시 Job 데이터를 로드
                    },
                  ),
                  const SizedBox(height: 20),
                  buildHeaderContainer(),
                  const SizedBox(height: 20),
                  buildJobGrid(),  // Employment 대신 Job 데이터를 표시
                  const SizedBox(height: 20),
                  buildPagination(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildHeaderContainer() {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            getCategoryTitle(),
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF2C3E50)),
          ),
        ),
        Expanded(
          flex: 3,
          child: custom.SearchBar(onSearch: searchJobs), // SearchBar에서 검색 가능
        ),
      ],
    );
  }

  Widget buildJobGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: calculateItemCount(),
      itemBuilder: (context, index) {
        final jobIndex = (currentPage - 1) * itemsPerPage + index;
        if (jobIndex >= jobs.length) return const SizedBox.shrink();
        return JobCard(job: jobs[jobIndex]);  // EmploymentCard 대신 JobCard 사용
      },
    );
  }

  int calculateItemCount() {
    return jobs.length;  // jobs 리스트의 개수
  }

  Widget buildPagination() {
    int totalPages = (jobs.length / itemsPerPage).ceil();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: currentPage > 1 ? () => changePage(currentPage - 1) : null,
        ),
        Text('$currentPage / $totalPages'),
        IconButton(
          icon: const Icon(Icons.chevron_right),
          onPressed: currentPage < totalPages ? () => changePage(currentPage + 1) : null,
        ),
      ],
    );
  }

  void changePage(int page) {
    setState(() {
      currentPage = page;
    });
  }

  String getCategoryTitle() {
    switch (selectedCategory) {
      case 'womenJobs':
        return '여성 일자리';
      case 'studentJobs':
        return '대학생 일자리';
      case 'elderlyJobs':
        return '노인 일자리';
      default:
        return '채용 정보';  // 'home' 카테고리의 기본 제목
    }
  }
}
