import 'package:flutter/material.dart';
import 'package:get/get.dart'; // 네비게이션 및 상태 관리를 위한 패키지

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 로고 이미지
          GestureDetector(
            onTap: () {
              Get.toNamed('/'); // 라우팅 처리
            },
            child: Image.asset(
              'assets/images/omniscientLogo.png', // 로고 이미지 경로
              width: 120,
              height: 60,
              fit: BoxFit.contain,
            ),
          ),
          // 메뉴 항목
          Row(
            children: [
              _buildMenuLink('자격증', '/certificate'),
              _buildMenuLink('채용', '/curation'),
              _buildMenuLink('자유게시판', '/board'),
              _buildMenuLink('마이페이지', '/mypage'),
              GestureDetector(
                onTap: () => _handleAuth(context),
                child: Text(
                  '로그인', // 로그인/로그아웃 버튼
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 메뉴 링크를 위한 헬퍼 함수
  Widget _buildMenuLink(String title, String route) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(route);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            decoration: TextDecoration.none,
          ),
        ),
      ),
    );
  }

  // 인증 처리 함수
  void _handleAuth(BuildContext context) {
    // 여기에 로그인/로그아웃 처리 로직을 넣으세요
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('로그아웃 확인'),
          content: Text('정말 로그아웃 하시겠습니까?'),
          actions: <Widget>[
            TextButton(
              child: Text('취소'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('확인'),
              onPressed: () {
                // 로그아웃 처리 로직
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
