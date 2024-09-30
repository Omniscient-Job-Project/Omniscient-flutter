import 'package:flutter/material.dart';
import '../models/term_section.dart';

class TermSectionWidget extends StatelessWidget {
  final TermSection section; // section 변수를 받기 위해 필드를 추가

  const TermSectionWidget({Key? key, required this.section}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16), // 섹션 간 간격
      padding: const EdgeInsets.all(16), // 섹션 내부 패딩
      decoration: BoxDecoration(
        color: Colors.white, // 배경 색상
        borderRadius: BorderRadius.circular(10), // 모서리 둥글게
        boxShadow: [
          BoxShadow(
            color: Colors.black12, // 그림자 색상
            blurRadius: 6, // 그림자 퍼짐 정도
            offset: Offset(0, 3), // 그림자 위치
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(
              minHeight: 50, // 최소 높이
              maxHeight: 50, // 최대 높이
            ),
            child: Container(
              width: double.infinity, // 가로로 꽉 차도록 설정
              padding: const EdgeInsets.symmetric(vertical: 10), // 텍스트와 배경 박스 사이의 여백
              color: Colors.grey[200], // 배경 색상
              child: Text(
                section.title, // section.title을 제대로 사용
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2C3E50),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8), // 텍스트 간 간격
          Text(
            section.content, // section.content 사용
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF7F8C8D),
            ),
          ),
        ],
      ),
    );
  }
}
