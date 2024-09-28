import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import '../repositories/user_repository.dart';
import '../widgets/action_buttons.dart';
import '../widgets/summerny_grid.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<User?>? _userFuture;

  final List<Map<String, dynamic>> _summaryItems = [
    {'label': '지원한 회사', 'value': 5, 'icon': Icons.business},
    {'label': '열람된 이력서', 'value': 3, 'icon': Icons.visibility},
    {'label': '보유 자격증', 'value': 2, 'icon': Icons.card_membership},
  ];

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    // SharedPreferences에서 토큰을 가져오기
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token'); // 저장된 토큰 불러오기

    if (token != null) {
      // 토큰이 존재할 경우 API 호출
      setState(() {
        _userFuture = UserRepository('http://localhost:8080').fetchUser(token);
      });
    } else {
      // 토큰이 없을 경우 기본 UI만 표시
      setState(() {
        _userFuture = Future.error('No token found. Please login first.');
      });
    }
  }

  void _showRecommendations() {
    print('추천 채용공고 표시');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: FutureBuilder<User?>(
                future: _userFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError || !snapshot.hasData) {
                    // 에러가 있거나 데이터가 없으면 기본 메시지 표시
                    return Text('사용자 정보를 불러올 수 없습니다.');
                  } else {
                    // 정상적으로 사용자 정보를 불러온 경우
                    return Text(
                      '${snapshot.data!.userName}님 환영합니다!',
                      style: TextStyle(fontSize: 28),
                    );
                  }
                },
              ),
            ),
            ActionButtons(onRecommendationsClicked: _showRecommendations),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text('활동 요약', style: TextStyle(fontSize: 24)),
            ),
            SummaryGrid(summaryItems: _summaryItems),
          ],
        ),
      ),
    );
  }
}
