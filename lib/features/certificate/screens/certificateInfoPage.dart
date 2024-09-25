import 'package:flutter/material.dart';
import '/core/widgets/header.dart';  // Header 파일 가져오기
import '/core/widgets/footer.dart';  // Footer 파일 가져오기
import '../widgets/certificateInfoCard.dart';  // CertificateInfoCard 임포트
import '../models/certificateInfo.dart';  // CertificateInfo 모델 임포트

class CertificateInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 샘플 자격증 데이터 생성
    final CertificateInfo certificate = CertificateInfo(
      jmNm: '정보처리기사',
      instiNm: '한국산업인력공단',
      grdNm: '기사',
      preyyAcquQualIncRate: 75.5,
      preyyQualAcquCnt: 1200,
      qualAcquCnt: 15000,
      statisYy: '2023',
      sumYy: '2022',
    );

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),  // Header 높이 설정
        child: Header(),  // Header 추가
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '자격증 정보',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            // CertificateInfoCard를 사용하여 자격증 정보를 표시
            CertificateInfoCard(certificate: certificate),
          ],
        ),
      ),
      bottomNavigationBar: Footer(),  // Footer 추가
    );
  }
}
