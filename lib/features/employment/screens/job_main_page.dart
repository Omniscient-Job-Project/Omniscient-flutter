import 'package:flutter/material.dart';
import '../../../core/services/api_employ_service.dart';
import '../../../core/services/api_job_service.dart';
import '../../../core/widgets/header.dart';
import '../../mypage/models/scrap_item.dart';
import '../../mypage/repositories/scrap_repository.dart';
import '../models/job.dart'; // Job 모델 사용
import '../models/employment.dart'; // Employment 모델 추가
import '../repositories/employ_repository.dart';
import '../repositories/job_repository.dart'; // JobRepository로 변경
import '../widgets/employment.dart';
import '../widgets/job_card.dart'; // JobCard 위젯 사용
import '../widgets/search_bar.dart' as custom;
import '../widgets/curation_index.dart';

class JobMainPage extends StatefulWidget {
  const JobMainPage({Key? key}) : super(key: key);

  @override
  _JobMainPageState createState() => _JobMainPageState();
}

class _JobMainPageState extends State<JobMainPage> {
  final JobRepository _jobRepository = JobRepository(ApiJobService());
  final EmployRepository _employmentRepository = EmployRepository(ApiEmployService());
  final ScrapRepository _scrapRepository = ScrapRepository(); // ScrapRepository 추가

  String selectedCategory = 'home'; // 초기 카테고리를 'home'으로 설정
  List<Job> jobs = [];
  List<Employment> employments = []; // Employment 리스트 추가
  List<Employment> filteredEmployments = []; // 필터링된 Employment 리스트 추가
  Set<String> favoriteJobs = {}; // 즐겨찾기 상태 저장을 위한 Set
  int currentPage = 1;
  int itemsPerPage = 16;

  @override
  void initState() {
    super.initState();
    loadJobs(); // 초기 Job 로드
    loadEmployments(); // 초기 Employment 로드
  }

  Future<void> loadJobs() async {
    try {
      List<Job> fetchedJobs = await _jobRepository.getJobs(numOfRows: 100);
      setState(() {
        jobs = fetchedJobs;
      });
    } catch (e) {
      print('Error loading job data: $e');
    }
  }

  Future<void> loadEmployments() async {
    try {
      List<Employment> fetchedEmployments = await _employmentRepository.getEmployments(numOfRows: 100);
      setState(() {
        employments = fetchedEmployments;
        filteredEmployments = employments; // 초기에는 모든 고용 정보를 표시
      });
    } catch (e) {
      print('Error loading employment data: $e');
    }
  }

  // 검색어를 바탕으로 Job 데이터를 필터링
  Future<void> searchJobs(String query) async {
    try {
      List<Job> searchResults = jobs.where((job) {
        return job.infoTitle.toLowerCase().contains(query.toLowerCase());
      }).toList();

      setState(() {
        jobs = searchResults;
        currentPage = 1;
      });
    } catch (e) {
      print('Error searching jobs: $e');
    }
  }

  // 선택된 카테고리에 따라 Employment 필터링
  void filterEmployments(String category) {
    setState(() {
      if (category == 'home') {
        filteredEmployments = employments; // 모든 고용 정보 표시
      } else {
        filteredEmployments = employments.where((employment) {
          switch (category) {
            case 'womenJobs':
              return employment.divNm == '여성 일자리';
            case 'studentJobs':
              return employment.divNm == '대학생 일자리';
            case 'elderlyJobs':
              return employment.divNm == '노인 일자리';
            case 'employment':
              return employment.divNm == '고용센터';
            default:
              return true;
          }
        }).toList();
      }
    });
  }

  // 즐겨찾기 상태 업데이트 및 ScrapRepository에 저장
  void toggleFavorite(dynamic item) {
    String itemId = item is Job ? item.infoTitle : item.instNm;

    setState(() {
      if (favoriteJobs.contains(itemId)) {
        favoriteJobs.remove(itemId);
      } else {
        favoriteJobs.add(itemId);
        ScrapItem scrapItem = ScrapItem(
          jobId: item is Job ? item.infoTitle : null, // job id 대신 title 사용
          jobInfoTitle: item is Job ? item.infoTitle : null,
          jobCompanyName: item is Job ? item.companyName : null,
          jobLocation: item is Job ? item.location : null,
          jmNm: item is Employment ? item.instNm : null,
        );
        _scrapRepository.addScrapItem(scrapItem); // 스크랩 저장
      }
    });
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
                      filterEmployments(category); // 카테고리 변경 시 필터링
                    },
                  ),
                  const SizedBox(height: 20),
                  buildHeaderContainer(),
                  const SizedBox(height: 20),
                  buildJobGrid(), // Job 또는 Employment 데이터 표시
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
        bool isFavorite = favoriteJobs.contains(jobs[jobIndex].infoTitle);
        return JobCard(
          job: jobs[jobIndex],
          onFavorite: () => toggleFavorite(jobs[jobIndex]),
          isFavorite: isFavorite, // 즐겨찾기 상태 전달
        );
      },
    );
  }

  int calculateItemCount() {
    return jobs.length;
  }

  Widget buildPagination() {
    int totalPages = jobs.length ~/ itemsPerPage + 1;
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
