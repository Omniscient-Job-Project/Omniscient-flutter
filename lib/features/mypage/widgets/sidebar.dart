import 'package:flutter/material.dart';
import 'package:get/get.dart'; // GetX 라우팅 사용

class Sidebar extends StatelessWidget {
  final Function(String) onItemSelected;

  Sidebar({required this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    // Set the width to 1/4 of the screen width
    double sidebarWidth = MediaQuery.of(context).size.width * 0.25;

    return Drawer(
      child: Container(
        width: sidebarWidth, // Set the width of the sidebar
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.home, size: 24), // You can adjust the icon size as needed
              title: Text(
                'My Home',
                style: TextStyle(fontSize: 14), // Adjust the font size
                overflow: TextOverflow.ellipsis, // Ensure text does not wrap
                maxLines: 1, // Limit to one line
              ),
              onTap: () {
                onItemSelected('/home_screen'); // 홈 페이지 선택 시 상태 업데이트
              },
            ),
            ListTile(
              leading: Icon(Icons.person, size: 24),
              title: Text(
                '프로필',
                style: TextStyle(fontSize: 14),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              onTap: () {
                onItemSelected('/profile_page'); // 프로필 페이지 라우팅
              },
            ),
            ListTile(
              leading: Icon(Icons.file_copy, size: 24),
              title: Text(
                '이력서 관리',
                style: TextStyle(fontSize: 14),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              onTap: () {
                onItemSelected('/resume_page'); // 이력서 관리 페이지 라우팅
              },
            ),
            ListTile(
              leading: Icon(Icons.work, size: 24),
              title: Text(
                '지원 현황',
                style: TextStyle(fontSize: 14),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              onTap: () {
                onItemSelected('/applications_page'); // 지원 현황 페이지 라우팅
              },
            ),
            ListTile(
              leading: Icon(Icons.bookmark, size: 24),
              title: Text(
                '스크랩',
                style: TextStyle(fontSize: 14),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              onTap: () {
                onItemSelected('/scrap_page'); // 스크랩 페이지 라우팅
              },
            ),
            ListTile(
              leading: Icon(Icons.card_membership, size: 24),
              title: Text(
                '자격증 관리',
                style: TextStyle(fontSize: 14),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              onTap: () {
                onItemSelected('/certificates_page'); // 자격증 관리 페이지 라우팅
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app, size: 24),
              title: Text(
                '회원 탈퇴',
                style: TextStyle(fontSize: 14),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              onTap: () {
                onItemSelected('/withdrawal_page'); // 회원 탈퇴 페이지 라우팅
              },
            ),
          ],
        ),
      ),
    );
  }
}
