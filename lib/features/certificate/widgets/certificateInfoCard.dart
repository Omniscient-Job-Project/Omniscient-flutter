// features/certificate/widgets/certificate_info_card.dart
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/certificateInfo.dart';
import 'package:intl/intl.dart';  // intl 패키지 임포트

class CertificateInfoCard extends StatelessWidget {
  final CertificateInfo certificate;

  const CertificateInfoCard({Key? key, required this.certificate}) : super(key: key);

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
            // 자격증 이름
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
              ],
            ),
            SizedBox(height: 8),

            // 기관 이름
            Row(
              children: [
                FaIcon(FontAwesomeIcons.building, color: Colors.blue),
                SizedBox(width: 8),
                Expanded(
                  child: Text('기관: ${certificate.instiNm}', style: contentStyle),
                ),
              ],
            ),

            // 등급
            Row(
              children: [
                FaIcon(FontAwesomeIcons.trophy, color: Colors.orange),
                SizedBox(width: 8),
                Expanded(
                  child: Text('등급: ${certificate.grdNm}', style: contentStyle),
                ),
              ],
            ),

            // 자격증 취득률
            Row(
              children: [
                FaIcon(FontAwesomeIcons.chartLine, color: Colors.purple),
                SizedBox(width: 8),
                Expanded(
                  child: Text('자격증 취득률: ${certificate.preyyAcquQualIncRate.toStringAsFixed(2)}%', style: contentStyle),
                ),
              ],
            ),

            // 전년도 자격증 취득 수
            Row(
              children: [
                FaIcon(FontAwesomeIcons.chartBar, color: Colors.indigo),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '전년도 자격증 취득 수: ${numberFormat.format(certificate.preyyQualAcquCnt)}',
                    style: contentStyle,
                  ),
                ),
              ],
            ),

            // 총 자격증 취득 수
            Row(
              children: [
                FaIcon(FontAwesomeIcons.chartPie, color: Colors.red),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '총 자격증 취득 수: ${numberFormat.format(certificate.qualAcquCnt)}',
                    style: contentStyle,
                  ),
                ),
              ],
            ),

            // 통계 연도
            Row(
              children: [
                FaIcon(FontAwesomeIcons.calendarAlt, color: Colors.teal),
                SizedBox(width: 8),
                Expanded(
                  child: Text('통계 연도: ${certificate.statisYy}', style: contentStyle),
                ),
              ],
            ),

            // 합계 연도
            Row(
              children: [
                FaIcon(FontAwesomeIcons.calendarCheck, color: Colors.lightGreen),
                SizedBox(width: 8),
                Expanded(
                  child: Text('합계 연도: ${certificate.sumYy}', style: contentStyle),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
