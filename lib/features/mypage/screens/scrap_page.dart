import 'package:flutter/material.dart';
import '../../certificate/models/test_job.dart';
import '../../certificate/repositories/test_job_repository.dart';
import '../repositories/scrap_repository.dart';
import '../models/scrap_item.dart';
import '../widgets/scrap_item_card.dart';
import '../../../core/services/api_service.dart'; // 시험 일정 불러오기 위한 ApiService

class ScrapPage extends StatefulWidget {
  @override
  _ScrapPageState createState() => _ScrapPageState();
}

class _ScrapPageState extends State<ScrapPage> {
  List<ScrapItem> scrapItems = [];
  List<TestJob> examJobs = []; // 시험 일정 저장 리스트
  late ScrapRepository scrapRepository;
  late ApiService _apiService; // 시험 일정 API 호출을 위한 서비스 인스턴스

  @override
  void initState() {
    super.initState();
    scrapRepository = ScrapRepository();
    _apiService = ApiService(); // ApiService 인스턴스 생성
    loadScrapItems();
    loadExamJobs(); // 시험 일정 로드
  }

  Future<void> loadScrapItems() async {
    List<ScrapItem> items = await scrapRepository.loadScrapItems();
    setState(() {
      scrapItems = items;
    });
  }

  Future<void> loadExamJobs() async {
    try {
      List<TestJob> fetchedExamJobs = await _apiService.fetchTestJobs(); // API에서 시험 일정 가져옴
      setState(() {
        examJobs = fetchedExamJobs;
      });
    } catch (e) {
      print('시험 일정 데이터를 불러오는 중 오류 발생: $e');
    }
  }

  void removeScrap(int index, String type) {
    setState(() {
      scrapRepository.removeScrapItem(scrapItems, index, type);
      scrapRepository.saveScrapItems(scrapItems);
    });
  }

  // 자격증 정보를 필터링하는 함수
  List<ScrapItem> getCertificateItems() {
    return scrapItems.where((item) => item.jmNm != null && item.qualAcquCnt != null).toList();
  }

  // 채용 정보를 필터링하는 함수
  List<ScrapItem> getJobItems() {
    return scrapItems.where((item) => item.jobId != null).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('스크랩'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (scrapItems.isEmpty && examJobs.isEmpty)
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.folder_open, size: 48, color: Colors.blue),
                    SizedBox(height: 20),
                    Text('스크랩한 항목이 없습니다.'),
                  ],
                ),
              ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 순서: 자격증 정보 -> 시험 일정 -> 채용 정보
                    buildCategorySection('자격증 정보', getCertificateItems(), 'cert'),
                    buildExamJobSection('시험 일정', examJobs), // 시험 일정 섹션
                    buildCategorySection('채용 정보', getJobItems(), 'job'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 각 카테고리 섹션을 빌드하는 함수 (자격증 및 채용 정보)
  Widget buildCategorySection(String title, List<ScrapItem> items, String type) {
    if (items.isEmpty) {
      return SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return ScrapItemCard(
              scrapItem: item,
              onRemove: () => removeScrap(index, type),
            );
          },
        ),
        SizedBox(height: 20),
      ],
    );
  }

  // 시험 일정 섹션을 빌드하는 함수
  Widget buildExamJobSection(String title, List<TestJob> examJobs) {
    if (examJobs.isEmpty) {
      return SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        SizedBox(height: 10),
        TestJobList(testJobs: examJobs), // 시험 일정 리스트 출력
        SizedBox(height: 20),
      ],
    );
  }
}
