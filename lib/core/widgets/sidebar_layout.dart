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
    // Set the width to 1/4 of the screen width
    double sidebarWidth = MediaQuery.of(context).size.width * 0.25;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: Header(), // Header 추가
      ),
      body: child,
      // Row(
      //   children: [
      //     // 사이드바 영역
      //     Container(
      //       width: sidebarWidth, // Set sidebar width to 25% of screen width
      //       child: Sidebar(onItemSelected: (String page) {
      //         Get.toNamed(page); // 서브 페이지로 이동
      //       }),
      //     ),
      //     // 메인 콘텐츠 영역
      //     Expanded(child: child),
      //   ],
      // ),
      bottomNavigationBar: Footer(), // Footer 추가
    );
  }
}
