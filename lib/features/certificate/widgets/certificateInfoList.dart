// features/certificate/widgets/certificate_info_list.dart
import 'package:flutter/material.dart';
import '../models/certificateInfo.dart';
import 'certificateInfoCard.dart';

class CertificateInfoList extends StatelessWidget {
  final List<CertificateInfo> certificates;

  const CertificateInfoList({Key? key, required this.certificates}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: certificates.length,
      itemBuilder: (context, index) {
        final certificate = certificates[index];
        return CertificateInfoCard(certificate: certificate);
      },
    );
  }
}
