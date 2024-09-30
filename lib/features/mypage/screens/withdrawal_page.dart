import 'package:flutter/material.dart';
import '../repositories/withdrawal_repository.dart';

class WithdrawalPage extends StatelessWidget {
  final WithdrawalRepository _withdrawalRepository = WithdrawalRepository();

  Future<void> confirmWithdrawal(BuildContext context) async {
    try {
      await _withdrawalRepository.withdrawUser();
      // 탈퇴 성공 시 홈으로 리다이렉트
      Navigator.pushReplacementNamed(context, '/myHome');
    } catch (e) {
      print('Withdrawal failed: $e');
      // 탈퇴 실패 시 에러 메시지 표시
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('회원 탈퇴에 실패했습니다.'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('회원 탈퇴'),
      ),
      body: Center( // Center 위젯으로 감싸기
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Column의 최소 크기 사용
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '정말로 회원 탈퇴를 하시겠습니까?',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => confirmWithdrawal(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                ),
                child: Text('탈퇴하기'),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/myHome');
                },
                child: Text('취소'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
