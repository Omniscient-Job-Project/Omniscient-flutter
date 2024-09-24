import 'package:flutter/material.dart';
import '/widgets/header.dart';  // Header 파일 가져오기
import '/widgets/footer.dart';  // Footer 파일 가져오기
import 'package:get/get.dart';  // GetX를 사용한 라우팅 처리

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(  // GetMaterialApp을 사용하여 GetX 라우팅을 지원
      debugShowCheckedModeBanner: false,  // 여기서 디버그 태그를 숨김
      home: MainPage(),  // 메인 페이지로 이동
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),  // Header 높이 설정
        child: Header(),  // Header 추가
      ),
      body: Center(
        child: Text('메인 콘텐츠 영역입니다.'),  // 본문 내용
      ),
      bottomNavigationBar: Footer(),  // Footer 추가
    );
  }
}
