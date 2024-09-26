// features/certificate/repositories/certificate_info_repository.dart
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

        // 응답 데이터 구조에 따라 접근 경로 수정
        var itemsData = data['response']?['body']?['items']?['item'];

        List<CertificateInfo> certificates = [];

        if (itemsData != null) {
          if (itemsData is List) {
            // itemsData가 리스트인 경우
            certificates = itemsData.map((item) => CertificateInfo.fromJson(item)).toList();
          } else if (itemsData is Map<String, dynamic>) {
            // itemsData가 단일 객체인 경우
            certificates = [CertificateInfo.fromJson(itemsData)];
          }
        }

        return certificates;
      } else {
        throw Exception('Failed to load certificates');
      }
    } catch (e) {
      print('Error fetching certificates: $e');
      throw Exception('Error fetching certificates: $e');
    }
  }
}
