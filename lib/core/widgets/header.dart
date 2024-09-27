import 'package:flutter/material.dart';
import 'package:get/get.dart'; // 네비게이션 및 상태 관리를 위한 패키지

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 50.0, left: 10.0, right: 10.0, bottom: 10.0), // 헤더 높이 설정
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,  // 좌우로 분리
        children: [
          // 메뉴 아이콘 (왼쪽)
          GestureDetector(
            onTap: () {
              _showCustomDialog(context); // 사용자 정의 다이얼로그 호출
            },
            child: Icon(Icons.menu, size: 30), // 메뉴 아이콘 크기 설정
          ),

          // 로고 (가운데)
          GestureDetector(
            onTap: () {
              Get.offNamed('/'); // 라우팅 처리
            },
            child: Image.asset(
              'assets/images/omniscientLogo.png', // 로고 이미지 경로
              width: 100,  // 로고 크기
              height: 50,
              fit: BoxFit.contain,
            ),
          ),

          // 로그인 버튼 (오른쪽)
          GestureDetector(
            onTap: () => _handleAuth(context),
            child: Text(
              '로그인', // 로그인/로그아웃 버튼
              style: TextStyle(
                fontSize: 16,  // 폰트 크기
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 사용자 정의 다이얼로그 함수
  void _showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.only(left: 0, right: MediaQuery.of(context).size.width * 0.5), // 왼쪽에 붙여서 가로는 반만 차지
          backgroundColor: Colors.white.withOpacity(0.95), // 반투명 배경
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // 박스 둥글게 처리
          ),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9, // 세로 전체 차지
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 메뉴 타이틀과 밑줄
                Text(
                  'Menu',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Divider(color: Colors.black), // 밑줄

                // 각 메뉴 항목들
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 간격을 두며 정렬
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildMenuItem(context, '자격증', '/certificate'),
                      _buildSubMenuItem(context, '자격증 정보', '/certificateInfoPage'),  // 자격증 정보 페이지로 이동
                      _buildSubMenuItem(context, '시험 일정', '/test_jobs_screen'),
                      _buildMenuItem(context, '채용', '/curation'),
                      _buildMenuItem(context, '자유게시판', '/board'),
                      _buildMenuItem(context, '마이페이지', '/home_screen'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // 메뉴 항목 빌드 함수
  Widget _buildMenuItem(BuildContext context, String title, String route) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();  // 다이얼로그 닫기 먼저 호출
        Get.toNamed(route);  // 페이지로 이동
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Widget _buildSubMenuItem(BuildContext context, String title, String route) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();  // 다이얼로그 닫기 먼저 호출
        Get.toNamed(route);  // 자격증 정보 페이지로 이동
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 30.0, top: 5.0, bottom: 5.0),
        child: Text(
          title,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
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
