import 'package:flutter/material.dart';
import 'package:get/get.dart'; // GetX 라우팅 사용

class Sidebar extends StatelessWidget {
  final Function(String) onItemSelected;

  Sidebar({required this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          ListTile(
            onTap: () {
              Navigator.pop(context); // Drawer 닫기
              Get.toNamed('/'); // 메인 페이지로 이동
            },
            leading: Icon(Icons.arrow_back, color: Colors.black), // 아이콘 색상 변경
            title: Text(
              '메인으로 돌아가기',
              style: TextStyle(fontSize: 16, color: Colors.black), // 텍스트 스타일 조정
            ),
          ),
          Divider(), // 구분선 추가

          ListTile(
            leading: Icon(Icons.home),
            title: Text('My Home'),
            onTap: () {
              onItemSelected('/home_screen'); // 홈 페이지 선택 시 상태 업데이트
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('프로필'),
            onTap: () {
              onItemSelected('/profile_page'); // 프로필 페이지 라우팅
            },
          ),
          ListTile(
            leading: Icon(Icons.file_copy),
            title: Text('이력서 관리'),
            onTap: () {
              onItemSelected('/resume_page'); // 이력서 관리 페이지 라우팅
            },
          ),
          ListTile(
            leading: Icon(Icons.work),
            title: Text('지원 현황'),
            onTap: () {
              onItemSelected('/applications_page'); // 지원 현황 페이지 라우팅
            },
          ),
          ListTile(
            leading: Icon(Icons.bookmark),
            title: Text('스크랩'),
            onTap: () {
              onItemSelected('/scrap_page'); // 스크랩 페이지 라우팅
            },
          ),
          ListTile(
            leading: Icon(Icons.card_membership),
            title: Text('자격증 관리'),
            onTap: () {
              onItemSelected('/certificates_page'); // 자격증 관리 페이지 라우팅
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('회원 탈퇴'),
            onTap: () {
              onItemSelected('/withdrawal_page'); // 회원 탈퇴 페이지 라우팅
            },
          ),
        ],
      ),
    );
  }
}
