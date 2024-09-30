import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/employment.dart';

class EmploymentCard extends StatelessWidget {
  final Employment employment;
  final VoidCallback onFavorite; // 즐겨찾기 콜백

  const EmploymentCard({Key? key, required this.employment, required this.onFavorite}) : super(key: key);

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
                icon: Icon(Icons.favorite_border),
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
              InkWell(
                onTap: () {
                  print('Open URL: ${employment.hmpgNm}'); // URL 열기 로직
                },
                child: Row(
                  children: [
                    const Icon(FontAwesomeIcons.link, color: Color(0xFF007BFF), size: 16),
                    const SizedBox(width: 8),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
