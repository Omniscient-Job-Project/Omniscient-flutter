import 'package:flutter/material.dart';
import '../models/certificateInfo.dart';  // CertificateInfo 모델 임포트

class CertificateInfoCard extends StatelessWidget {
  final CertificateInfo certificate;  // CertificateInfo 모델 사용

  const CertificateInfoCard({Key? key, required this.certificate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              certificate.jmNm,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('기관: ${certificate.instiNm}'),
            Text('등급: ${certificate.grdNm}'),
            Text('자격증 취득률: ${certificate.preyyAcquQualIncRate}%'),
            Text('전년도 자격증 취득 수: ${certificate.preyyQualAcquCnt}'),
            Text('총 자격증 취득 수: ${certificate.qualAcquCnt}'),
            Text('통계 연도: ${certificate.statisYy}'),
            Text('합계 연도: ${certificate.sumYy}'),
          ],
        ),
      ),
    );
  }
}
