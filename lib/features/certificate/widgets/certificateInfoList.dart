import 'package:flutter/material.dart';
import '../models/certificateInfo.dart';
import 'certificateInfoCard.dart';

class CertificateInfoList extends StatelessWidget {
  final List<CertificateInfo> certificates;
  final List<String> favoriteCertificates; // 즐겨찾기 상태를 전달받기 위한 리스트
  final Function(CertificateInfo) onFavoriteToggle; // 즐겨찾기 토글 콜백 함수

  const CertificateInfoList({
    Key? key,
    required this.certificates,
    required this.favoriteCertificates, // 즐겨찾기 상태 전달
    required this.onFavoriteToggle, // 즐겨찾기 토글 콜백 전달
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: certificates.length,
      itemBuilder: (context, index) {
        final certificate = certificates[index];
        final isFavorited = favoriteCertificates.contains(certificate.jmNm); // 즐겨찾기 여부 확인

        return CertificateInfoCard(
          certificate: certificate,
          isFavorited: isFavorited, // 즐겨찾기 상태 전달
          onFavoriteToggle: () => onFavoriteToggle(certificate), // 콜백 함수 전달
        );
      },
    );
  }
}
