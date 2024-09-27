import 'package:flutter/material.dart';
import '../models/user.dart';
import '../repositories/user_repository.dart';
import '../widgets/action_buttons.dart';
import '../widgets/summerny_grid.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<User?> _userFuture;
  final List<Map<String, dynamic>> _summaryItems = [
    {'label': '지원한 회사', 'value': 5, 'icon': Icons.business},
    {'label': '열람된 이력서', 'value': 3, 'icon': Icons.visibility},
    {'label': '보유 자격증', 'value': 2, 'icon': Icons.card_membership},
  ];

  @override
  void initState() {
    super.initState();
    _userFuture = UserRepository('YOUR_API_URL').fetchUser('YOUR_TOKEN');
  }

  void _showRecommendations() {
    print('추천 채용공고 표시');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
      future: _userFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('사용자 정보를 불러오는 데 실패했습니다.'));
        } else {
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    snapshot.hasData
                        ? '${snapshot.data!.userName}님 환영합니다!'
                        : '환영합니다!',
                    style: TextStyle(fontSize: 28),
                  ),
                ),
                ActionButtons(onRecommendationsClicked: _showRecommendations),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('활동 요약', style: TextStyle(fontSize: 24)),
                ),
                SummaryGrid(summaryItems: _summaryItems),
              ],
            ),
          );
        }
      },
    );
  }
}
