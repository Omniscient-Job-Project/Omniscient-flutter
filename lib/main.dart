import 'package:flutter/material.dart';
import 'core/widgets/header.dart';  // Header 파일 가져오기
import 'core/widgets/footer.dart';  // Footer 파일 가져오기
import 'package:get/get.dart';  // GetX를 사용한 라우팅 처리
import 'features/employment/screens/job_main_page.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      defaultTransition: Transition.fade, // 페이지 전환 애니메이션 추가
      getPages: [
        GetPage(name: '/', page: () => MainPage()),
        GetPage(name: '/curation', page: () => const JobMainPage()),
      ],
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> _categories = ['IT', '마케팅', '디자인', '영업', '금융', '교육'];
  final List<Map<String, dynamic>> _jobs = [
    {
      'id': 1,
      'title': '프론트엔드 개발자',
      'company': 'ABC Tech',
      'location': '서울',
      'career': '경력 2년',
      'bookmarked': false,
    },
    {
      'id': 2,
      'title': '백엔드 개발자',
      'company': 'XYZ Inc.',
      'location': '부산',
      'career': '신입',
      'bookmarked': false,
    },
  ];
  int _currentPage = 1;
  int _totalPages = 5;

  void _searchJobs() {
    print("Searching jobs for: ${_searchController.text}");
  }

  void _goToDetail(int jobId) {
    // Job detail 페이지로 이동
    print("Navigating to job detail: $jobId");
  }

  void _toggleBookmark(int jobId) {
    setState(() {
      _jobs.firstWhere((job) => job['id'] == jobId)['bookmarked'] =
      !(_jobs.firstWhere((job) => job['id'] == jobId)['bookmarked'] ?? false);
    });
  }

  void _goToPage(int page) {
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 히어로 섹션
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '당신의 내일이 더 빛날 수 있도록, 오늘부터 시작하세요',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    '수천 개의 채용 정보 중 당신에게 딱 맞는 직업을 함께 찾아드리겠습니다.',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: '직무, 회사, 키워드 검색',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.search, color: Colors.blue),
                        onPressed: _searchJobs,
                      )
                    ],
                  ),
                ],
              ),
            ),

            // 카테고리 섹션
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '주요 카테고리',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  SizedBox(height: 10),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemCount: _categories.length,
                    itemBuilder: (context, index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: BorderSide(color: Colors.blue),
                        ),
                        child: Center(
                          child: Text(
                            _categories[index],
                            style: TextStyle(fontSize: 16, color: Colors.blue),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            // 채용 정보 리스팅
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '최신 채용 정보',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _jobs.length,
                    itemBuilder: (context, index) {
                      final job = _jobs[index];
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: BorderSide(color: Colors.blue),
                        ),
                        child: ListTile(
                          onTap: () => _goToDetail(job['id']),
                          title: Text(job['title'], style: TextStyle(color: Colors.blue)),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('회사: ${job['company']}'),
                              Text('위치: ${job['location']}'),
                              Text('경력: ${job['career']}'),
                            ],
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              job['bookmarked'] ?? false
                                  ? Icons.bookmark
                                  : Icons.bookmark_border,
                              color: Colors.blue,
                            ),
                            onPressed: () => _toggleBookmark(job['id']),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            // 페이지네이션
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.chevron_left, color: Colors.black),
                    onPressed: _currentPage > 1
                        ? () => _goToPage(_currentPage - 1)
                        : null,
                  ),
                  Text('$_currentPage / $_totalPages', style: TextStyle(color: Colors.black)),
                  IconButton(
                    icon: Icon(Icons.chevron_right, color: Colors.blue),
                    onPressed: _currentPage < _totalPages
                        ? () => _goToPage(_currentPage + 1)
                        : null,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Footer(),  // Footer 추가
    );
  }
}