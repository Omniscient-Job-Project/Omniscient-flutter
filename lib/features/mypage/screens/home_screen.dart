import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import '../repositories/user_repository.dart';
import '../widgets/action_buttons.dart';
import '../widgets/summery_grid.dart'; // typo 수정: 'summerny_grid' -> 'summary_grid'

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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    if (token != null) {
      setState(() {
        _userFuture = UserRepository('http://localhost:8080').fetchUser(token);
      });
    } else {
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
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder<User?>(
                future: _userFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError || !snapshot.hasData) {
                    return Text('사용자 정보를 불러올 수 없습니다.');
                  } else {
                    return Text(
                      '${snapshot.data!.userName}님 환영합니다!',
                      style: TextStyle(fontSize: 28),
                    );
                  }
                },
              ),
              SizedBox(height: 20), // 여백 추가
              ActionButtons(onRecommendationsClicked: _showRecommendations),
              SizedBox(height: 20),
              Text('활동 요약', style: TextStyle(fontSize: 24)),
              SizedBox(height: 10), // 여백 추가
              SummaryGrid(summaryItems: _summaryItems),
              SizedBox(height: 20), // 여백 추가
            ],
          ),
        ),
      ),
    );
  }
}
