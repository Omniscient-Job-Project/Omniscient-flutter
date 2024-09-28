import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/employment.dart';

class EmploymentCard extends StatelessWidget {
  final Employment employment;

  const EmploymentCard({Key? key, required this.employment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 기관 이름
              Text(
                employment.instNm,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2C3E50), // 제목 색상
                ),
              ),
              const SizedBox(height: 8),
              // 구분 이름
              Text(
                employment.divNm,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              // 지역 정보
              Row(
                children: [
                  const Icon(FontAwesomeIcons.mapMarkerAlt, size: 16, color: Color(0xFFE74C3C)), // 지역 아이콘 색상
                  const SizedBox(width: 4),
                  Expanded( // 여기에 Expanded 추가
                    child: Text(
                      employment.regionNm,
                      style: const TextStyle(fontSize: 14),
                      overflow: TextOverflow.ellipsis, // 텍스트 오버플로우 처리
                      maxLines: 1, // 최대 한 줄
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // 홈페이지 링크 아이콘 (null 체크 포함)
              if (employment.hmpgNm != null)
                InkWell(
                  onTap: () {
                    print('Open URL: ${employment.hmpgNm}'); // 실제 링크 열기 구현 필요
                  },
                  child: Row(
                    children: [
                      const Icon(FontAwesomeIcons.link, color: Color(0xFF007BFF), size: 16), // 링크 아이콘
                      const SizedBox(width: 8),
                      // URL 글자는 숨김 처리
                      // Text(
                      //   employment.hmpgNm!,
                      //   style: TextStyle(
                      //     color: const Color(0xFF007BFF), // 링크 색상
                      //     fontSize: 14,
                      //     decoration: TextDecoration.underline,
                      //   ),
                      //   overflow: TextOverflow.ellipsis, // 텍스트 오버플로우 처리
                      //   maxLines: 1, // 최대 한 줄
                      // ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
