import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/employment.dart';

class EmploymentCard extends StatelessWidget {
  final Employment employment;
  final VoidCallback onFavorite; // 즐겨찾기 콜백
  final bool isFavorite; // 즐겨찾기 상태 추가

  const EmploymentCard({
    Key? key,
    required this.employment,
    required this.onFavorite,
    required this.isFavorite, // isFavorite 받기
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 즐겨찾기 아이콘 추가
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border, // 즐겨찾기 상태에 따른 아이콘 변경
                  color: isFavorite ? Colors.red : null, // 즐겨찾기 상태일 때 빨간색
                ),
                onPressed: onFavorite, // 콜백 실행
              ),
            ),
            Text(
              employment.instNm,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2C3E50),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              employment.divNm,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(FontAwesomeIcons.mapMarkerAlt, size: 16, color: Color(0xFFE74C3C)),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    employment.regionNm,
                    style: const TextStyle(fontSize: 14),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (employment.hmpgNm != null)
              Flexible( // Flexible로 감싸서 공간을 유연하게 사용하도록 수정
                child: InkWell(
                  onTap: () {
                    print('Open URL: ${employment.hmpgNm}'); // URL 열기 로직
                  },
                  child: const Icon( // 아이콘만 표시되도록 수정
                    FontAwesomeIcons.link,
                    color: Color(0xFF007BFF),
                    size: 16,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
