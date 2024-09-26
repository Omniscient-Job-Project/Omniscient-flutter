import 'dart:convert';
import 'package:dio/dio.dart';
import '../models/certificateInfo.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // dotenv 패키지 임포트

class CertificateInfoRepository {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: dotenv.env['API_URL'] ?? 'http://default.url',
    responseType: ResponseType.plain,
  ));

  Future<List<CertificateInfo>> fetchCertificates(String grdCd) async {
    try {
      final response = await _dio.get('/api/v1/gradejob?grdCd=$grdCd');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.data);

        List<dynamic> items = data['response']['body']['items']['item'];

        return items
            .map((item) => CertificateInfo.fromJson(item))
            .toList();
      } else {
        throw Exception('Failed to load certificates');
      }
    } catch (e) {
      print('Error fetching certificates: $e');
      throw Exception('Error fetching certificates: $e');
    }
  }
}
