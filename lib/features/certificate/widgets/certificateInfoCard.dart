import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/certificateInfo.dart';
import 'package:intl/intl.dart';  // intl 패키지 임포트

class CertificateInfoCard extends StatelessWidget {
  final CertificateInfo certificate;
  final bool isFavorited;
  final VoidCallback onFavoriteToggle;  // 즐겨찾기 토글 기능 추가

  const CertificateInfoCard({
    Key? key,
    required this.certificate,
    required this.isFavorited,  // 즐겨찾기 상태
    required this.onFavoriteToggle,  // 즐겨찾기 토글 기능
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final numberFormat = NumberFormat('#,###');  // NumberFormat 인스턴스 생성
    final titleStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
    final contentStyle = TextStyle(fontSize: 16);

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 제목 부분: 자격증 이름 + 즐겨찾기 아이콘
            Row(
              children: [
                FaIcon(FontAwesomeIcons.certificate, color: Colors.green),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    certificate.jmNm,
                    style: titleStyle,
                  ),
                ),
                // 즐겨찾기 아이콘
                IconButton(
                  icon: Icon(
                    isFavorited ? Icons.star : Icons.star_border, // 즐겨찾기 여부에 따른 아이콘 변경
                    color: isFavorited ? Colors.yellow : Colors.grey,
                  ),
                  onPressed: onFavoriteToggle,  // 즐겨찾기 버튼 클릭 시 실행
                ),
              ],
            ),
            SizedBox(height: 8),

            // 기관 이름 표시
            if (certificate.instiNm != null)
              _buildInfoRow(FontAwesomeIcons.building, '기관: ${certificate.instiNm}', Colors.blue, contentStyle),

            // 등급 표시
            if (certificate.grdNm != null)
              _buildInfoRow(FontAwesomeIcons.trophy, '등급: ${certificate.grdNm}', Colors.orange, contentStyle),

            // 자격증 취득률 표시
            if (certificate.preyyAcquQualIncRate != null)
              _buildInfoRow(FontAwesomeIcons.chartLine, '자격증 취득률: ${certificate.preyyAcquQualIncRate!.toStringAsFixed(2)}%', Colors.purple, contentStyle),

            // 전년도 자격증 취득 수 표시
            if (certificate.preyyQualAcquCnt != null)
              _buildInfoRow(FontAwesomeIcons.chartBar, '전년도 자격증 취득 수: ${numberFormat.format(certificate.preyyQualAcquCnt)}', Colors.indigo, contentStyle),

            // 총 자격증 취득 수 표시
            if (certificate.qualAcquCnt != null)
              _buildInfoRow(FontAwesomeIcons.chartPie, '총 자격증 취득 수: ${numberFormat.format(certificate.qualAcquCnt)}', Colors.red, contentStyle),

            // 통계 연도 표시
            if (certificate.statisYy != null)
              _buildInfoRow(FontAwesomeIcons.calendarAlt, '통계 연도: ${certificate.statisYy}', Colors.teal, contentStyle),

            // 합계 연도 표시
            if (certificate.sumYy != null)
              _buildInfoRow(FontAwesomeIcons.calendarCheck, '합계 연도: ${certificate.sumYy}', Colors.lightGreen, contentStyle),
          ],
        ),
      ),
    );
  }

  // 정보 행을 생성하는 헬퍼 함수
  Widget _buildInfoRow(IconData icon, String text, Color color, TextStyle style) {
    return Row(
      children: [
        FaIcon(icon, color: color),
        SizedBox(width: 8),
        Expanded(
          child: Text(text, style: style),
        ),
      ],
    );
  }
}
