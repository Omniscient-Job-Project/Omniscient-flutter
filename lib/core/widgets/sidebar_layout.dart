import 'package:flutter/material.dart';
import 'header.dart';
import 'footer.dart';

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
      // Row와 사이드바를 제거하고 child가 전체 화면을 차지하도록 변경
      body: child,
      bottomNavigationBar: Footer(), // Footer 추가
    );
  }
}
