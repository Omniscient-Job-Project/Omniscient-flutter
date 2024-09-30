import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80.0, // 원하는 높이 설정
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Color(0xFFF8F9FA), // 배경색 설정
        border: Border(
          top: BorderSide(
            color: Colors.grey, // 상단 테두리 색상
            width: 1.0,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 균등하게 요소 배치
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/certificateInfoPage'); // 자격증 페이지로 이동
            },
            child: Text(
              '자격증',
              style: footerLinkStyle(),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/'); // 홈 페이지로 이동
            },
            child: Text(
              '홈',
              style: footerLinkStyle(),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/curation'); // 채용 페이지로 이동
            },
            child: Text(
              '채용',
              style: footerLinkStyle(),
            ),
          ),
        ],
      ),
    );
  }

  // 링크 스타일을 지정하는 함수
  TextStyle footerLinkStyle() {
    return const TextStyle(
      decoration: TextDecoration.none, // 기본 밑줄 없음
      color: Colors.black, // 기본 글자 색상
    );
  }
}
