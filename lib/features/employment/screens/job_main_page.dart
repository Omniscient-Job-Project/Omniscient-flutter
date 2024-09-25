import 'package:flutter/material.dart' hide SearchBar;
import 'package:omniscient/features/employment/models/job.dart';
import 'package:omniscient/features/employment/repositories/job_repository.dart';
import 'package:omniscient/features/employment/widgets/curation_index.dart';
import 'package:omniscient/features/employment/widgets/job_card.dart';
import 'package:omniscient/features/employment/widgets/search_bar.dart' as custom;
import '../widgets/search_bar.dart';
import 'package:omniscient/core/widgets/header.dart';
import 'package:omniscient/features/employment/services/job_api_service.dart';


class JobMainPage extends StatefulWidget {
  const JobMainPage({Key? key}) : super(key: key);

  @override
  _JobMainPageState createState() => _JobMainPageState();
}

class _JobMainPageState extends State<JobMainPage> {
  final JobApiService _jobApiService = JobApiService();
  final JobRepository _jobRepository = JobRepository();
  String selectedCategory = 'home';
  List<Job> jobs = [];
  int currentPage = 1;
  int itemsPerPage = 16;

  @override
  void initState() {
    super.initState();
    loadJobs();
  }

  Future<void> loadJobs() async {
    try {
      final fetchedJobs = await _jobApiService.fetchJobs();
      setState(() {
        jobs = fetchedJobs;
      });
    } catch (e) {
      print('Error loading jobs: $e');
      // 여기에 사용자에게 오류를 표시하는 로직을 추가할 수 있습니다.
    }
  }

  void selectCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
    loadJobs(); // 카테고리 변경 시 데이터 다시 로드
  }


  Future<void> searchJobs(String query) async {
    final searchResults = await _jobRepository.searchJobs(query);
    setState(() {
      jobs = searchResults;
      currentPage = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
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
                    onCategorySelected: selectCategory,
                  ),
                  const SizedBox(height: 20),
                  buildHeaderContainer(),
                  const SizedBox(height: 20),
                  buildJobGrid(),
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
          child: SearchBar(onSearch: searchJobs),  // 위젯으로 사용
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
        if (jobIndex >= jobs.length) return null;
        return JobCard(job: jobs[jobIndex]);
      },
    );
  }

  int calculateItemCount() {
    int remainingItems = jobs.length - (currentPage - 1) * itemsPerPage;
    return remainingItems > itemsPerPage ? itemsPerPage : remainingItems;
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
      case 'employment':
        return '고용센터';
      default:
        return '채용 정보';
    }
  }
}

