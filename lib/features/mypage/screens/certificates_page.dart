import 'package:flutter/material.dart';
import '../models/certificate.dart';
import '../repositories/certificate_repository.dart';

class CertificatesPage extends StatefulWidget {
  @override
  _CertificatesPageState createState() => _CertificatesPageState();
}

class _CertificatesPageState extends State<CertificatesPage> {
  late Future<List<Certificate>> _certificatesFuture;
  final CertificateRepository _certificateRepository = CertificateRepository();
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _certificatesFuture = _fetchCertificates();
  }

  Future<List<Certificate>> _fetchCertificates() async {
    try {
      return await _certificateRepository.fetchCertificates();
    } catch (e) {
      setState(() {
        _hasError = true;
      });
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('자격증 관리'),
      ),
      body: FutureBuilder<List<Certificate>>(
        future: _certificatesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildLoadingUI();
          } else if (_hasError || snapshot.data == null || snapshot.data!.isEmpty) {
            return _buildPlaceholderForm();
          } else {
            return _buildCertificatesList(snapshot.data!);
          }
        },
      ),
    );
  }

  // Loading UI while waiting for API response
  Widget _buildLoadingUI() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  // Placeholder UI if API fails or no data is available
  Widget _buildPlaceholderForm() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            _buildPlaceholderCertificate('자격증 1', '발급기관 1', '0000000001', '미정'),
            _buildPlaceholderCertificate('자격증 2', '발급기관 2', '0000000002', '미정'),
            _buildPlaceholderCertificate('자격증 3', '발급기관 3', '0000000003', '미정'),
            SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _hasError = false;
                    _certificatesFuture = _fetchCertificates();
                  });
                },
                child: Text('다시 시도'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Placeholder certificate UI
  Widget _buildPlaceholderCertificate(String name, String issuer, String number, String date) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 4,
      child: ListTile(
        title: Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('발급기관: $issuer'),
            Text('자격증 번호: $number'),
            Text('취득일: $date'),
          ],
        ),
      ),
    );
  }

  // Builds the UI for displaying certificates list when data is loaded
  Widget _buildCertificatesList(List<Certificate> certificates) {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: certificates.length,
      itemBuilder: (context, index) {
        Certificate cert = certificates[index];
        return Card(
          margin: EdgeInsets.symmetric(vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 4,
          child: ExpansionTile(
            title: Text(cert.name, style: TextStyle(fontWeight: FontWeight.bold)),
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('취득일: ${cert.date}'),
                    Text('발급기관: ${cert.issuer}'),
                    Text('자격증 번호: ${cert.number}'),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
