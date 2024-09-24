import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // 외부 링크를 위한 패키지

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
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/notice'); // 공지사항 페이지로 이동
            },
            child: Text(
              '공지사항',
              style: footerLinkStyle(),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/terms'); // 이용약관 페이지로 이동
            },
            child: Text(
              '이용약관',
              style: footerLinkStyle(),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/noticeFAQ'); // FAQ 페이지로 이동
            },
            child: Text(
              '자주 묻는 질문(FAQ)',
              style: footerLinkStyle(),
            ),
          ),
          GestureDetector(
            onTap: () {
              _launchURL('https://github.com/Omniscient-Job-Project'); // 외부 링크 열기
            },
            child: Text(
              '깃허브',
              style: footerLinkStyle(),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/login'); // 전직시 페이지로 이동
            },
            child: Text(
              '전직시',
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

  // 외부 URL을 열기 위한 함수
  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
