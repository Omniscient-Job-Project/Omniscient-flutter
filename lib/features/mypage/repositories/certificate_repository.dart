import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/certificate.dart';

class CertificateRepository {
  final String _baseUrl = 'https://192.168.0.150:8090/api/v1/certificates';

  Future<List<Certificate>> fetchCertificates() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Certificate.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load certificates');
      }
    } catch (e) {
      // If an error occurs, return an empty list or use placeholders
      return [];
    }
  }
}
