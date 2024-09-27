import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';  // dotenv 패키지 임포트
import 'core/widgets/header.dart';  // Header 파일 가져오기
import 'core/widgets/footer.dart';  // Footer 파일 가져오기
import 'package:get/get.dart';  // GetX를 사용한 라우팅 처리
import 'features/employment/screens/job_main_page.dart';
import 'features/certificate/screens/certificateInfoPage.dart';  // 자격증 정보 페이지 임포트
import 'features/certificate/screens/test_jobs_screen.dart';  // 시험 일정 페이지 임포트
import 'features/auth/screens/login_screen.dart';
import 'features/auth/screens/register_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: 'assets/.env');
  var apiUrl = dotenv.env['API_URL'] ?? 'http://localhost:8080';
  print('API URL: $apiUrl'); // API URL 로그 출력
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      defaultTransition: Transition.fade,  // 페이지 전환 애니메이션 추가
      getPages: [
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/register', page: () => RegisterScreen()),
        GetPage(name: '/', page: () => MainPage()),
        GetPage(name: '/curation', page: () => const JobMainPage()),
        GetPage(name: '/certificateInfoPage', page: () => CertificateInfoPage()),  // 자격증 정보 페이지 등록
        GetPage(name: '/test_jobs_screen', page: () => TestJobsScreen()),  // 시험 일정 페이지 등록
        GetPage(name: '/notice', page: () => MainPage()),  // 시험 일정 페이지 등록
        GetPage(name: '/faq', page: () => MainPage()),  // 시험 일정 페이지 등록
        GetPage(name: '/terms', page: () => MainPage()),  // 시험 일정 페이지 등록
      ],
    );
  }
}
// MenuPage 클래스 수정 (각 버튼이 하나의 페이지로 이동하도록)
class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Menu Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Get.toNamed('/certificateInfoPage');  // 자격증 정보 페이지로 이동
              },
              child: const Text('자격증 정보로 이동'),
            ),
            ElevatedButton(
              onPressed: () {
                Get.toNamed('/test_jobs_screen');  // 시험 일정 페이지로 이동
              },
              child: const Text('시험 일정으로 이동'),
            ),
          ],
        ),
      ),
    );
  }
}

// MainPage 클래스 수정
class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> _categories = const ['IT', '마케팅', '디자인', '영업', '금융', '교육'];
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
        preferredSize: const Size.fromHeight(80.0),  // Header 높이 설정
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
                    const Text(
                      '당신의 내일이 더 빛날 수 있도록, 오늘부터 시작하세요',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      '수천 개의 채용 정보 중 당신에게 딱 맞는 직업을 함께 찾아드리겠습니다.',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintText: '직무, 회사, 키워드 검색',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(color: Colors.blue),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.search, color: Colors.blue),
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
                    const Text(
                      '주요 카테고리',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    const SizedBox(height: 10),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                            side: const BorderSide(color: Colors.blue),
                          ),
                          child: Center(
                            child: Text(
                              _categories[index],
                              style: const TextStyle(fontSize: 16, color: Colors.blue),
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
                    const Text(
                      '최신 채용 정보',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    const SizedBox(height: 10),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _jobs.length,
                      itemBuilder: (context, index) {
                        final job = _jobs[index];
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: const BorderSide(color: Colors.blue),
                          ),
                          child: ListTile(
                            onTap: () => _goToDetail(job['id']),
                            title: Text(job['title'], style: const TextStyle(color: Colors.blue)),
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
                      icon: const Icon(Icons.chevron_left, color: Colors.black),
                      onPressed: _currentPage > 1 ? () => _goToPage(_currentPage - 1) : null,
                    ),
                    Text('$_currentPage / $_totalPages', style: const TextStyle(color: Colors.black)),
                    IconButton(
                      icon: const Icon(Icons.chevron_right, color: Colors.blue),
                      onPressed: _currentPage < _totalPages ? () => _goToPage(_currentPage + 1) : null,
                    ),
                  ],
                ),
              ),]
        ),
      ),
      bottomNavigationBar: Footer(),  // Footer 추가
    );
  }
}
