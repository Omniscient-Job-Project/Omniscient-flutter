import 'package:flutter/material.dart';
import '../../certificate/models/test_job.dart';
import '../../certificate/widgets/test_job_list.dart';
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
  List<TestJob> favoriteTestJobs = []; // 즐겨찾기한 시험 일정 리스트
  late ScrapRepository scrapRepository;
  late ApiService _apiService; // 시험 일정 API 호출을 위한 서비스 인스턴스

  @override
  void initState() {
    super.initState();
    scrapRepository = ScrapRepository();
    _apiService = ApiService(); // ApiService 인스턴스 생성
    loadScrapItems();
    loadFavoriteTestJobs(); // 즐겨찾기 시험 일정 로드
  }

  Future<void> loadScrapItems() async {
    List<ScrapItem> items = await scrapRepository.loadScrapItems();
    setState(() {
      scrapItems = items;
    });
  }

  Future<void> loadFavoriteTestJobs() async {
    // 스크랩된 즐겨찾기된 시험 일정 로드
    List<TestJob> favoriteJobs = await scrapRepository.loadFavoriteTestJobs();
    setState(() {
      favoriteTestJobs = favoriteJobs;
    });
  }

  // 즐겨찾기에서 시험 일정 삭제
  void removeFavoriteJob(TestJob job) {
    setState(() {
      favoriteTestJobs.remove(job); // 즐겨찾기에서 삭제
    });
    // 스크랩 저장소에 저장
    scrapRepository.saveFavoriteTestJobs(favoriteTestJobs);
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
            if (scrapItems.isEmpty && favoriteTestJobs.isEmpty)
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
                    // 자격증 정보
                    buildCategorySection('자격증 정보', getCertificateItems(), 'cert'),
                    // 즐겨찾기한 시험 일정
                    buildFavoriteExamJobsSection('시험 일정', favoriteTestJobs),
                    // 채용 정보
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

  // 카테고리 섹션 빌드
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

  // 즐겨찾기한 시험 일정 섹션 빌드 (삭제 버튼 추가)
  Widget buildFavoriteExamJobsSection(String title, List<TestJob> favoriteTestJobs) {
    if (favoriteTestJobs.isEmpty) {
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
          itemCount: favoriteTestJobs.length,
          itemBuilder: (context, index) {
            final job = favoriteTestJobs[index];
            return Card(
              elevation: 5,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                title: Text(job.qualgbNm),
                subtitle: Text(job.description),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () => removeFavoriteJob(job),
                ),
              ),
            );
          },
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
