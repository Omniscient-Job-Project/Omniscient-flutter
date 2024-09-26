import 'package:flutter/material.dart';
import '/core/widgets/header.dart';  // Header 파일 가져오기
import '/core/widgets/footer.dart';  // Footer 파일 가져오기
import '../widgets/certificateInfoCard.dart';  // CertificateInfoCard 임포트
import '../models/certificateInfo.dart';  // CertificateInfo 모델 임포트
import '../repositories/certificateInfoRepository.dart';  // Repository 임포트

class CertificateInfoPage extends StatefulWidget {
  @override
  _CertificateInfoPageState createState() => _CertificateInfoPageState();
}

class _CertificateInfoPageState extends State<CertificateInfoPage> {
  final CertificateInfoRepository _repository = CertificateInfoRepository();
  late Future<List<CertificateInfo>> _certificateInfo;

  // grdCd 값을 실제 값으로 설정 (필요한 값으로 교체)
  final String grdCd = '10';  // 실제 자격증 등급 코드로 설정

  @override
  void initState() {
    super.initState();
    _fetchCertificateInfo();
  }

  void _fetchCertificateInfo() {
    setState(() {
      _certificateInfo = _repository.fetchCertificates(grdCd);  // grdCd 전달
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),  // Header 높이 설정
        child: Header(),  // Header 추가
      ),
      body: FutureBuilder<List<CertificateInfo>>(
        future: _certificateInfo,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('오류 발생: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('자격증 정보를 찾을 수 없습니다.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final certificate = snapshot.data![index];
              return CertificateInfoCard(certificate: certificate);
            },
          );
        },
      ),
      bottomNavigationBar: Footer(),  // Footer 추가
    );
  }
}
