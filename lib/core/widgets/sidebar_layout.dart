import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'header.dart';
import 'footer.dart';
import '../../features/mypage/widgets/sidebar.dart';

class SidebarLayout extends StatelessWidget {
  final Widget child;

  const SidebarLayout({required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: Header(), // Header 추가
      ),
      body: Row(
        children: [
          // 사이드바 영역
          Container(
            width: 250,
            child: Sidebar(onItemSelected: (String page) {
              Get.toNamed(page); // 서브 페이지로 이동
            }),
          ),
          // 메인 콘텐츠 영역
          Expanded(child: child),
        ],
      ),
      bottomNavigationBar: Footer(), // Footer 추가
    );
  }
}
