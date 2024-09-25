import 'package:dio/dio.dart';
import '../models/certificateInfo.dart';

class CertificateInfoRepository {
  final Dio dio = Dio();
  final String apiUrl = 'https://api.yourbackend.com/certificates'; // 실제 API URL로 변경

  Future<List<CertificateInfo>> fetchCertificates() async {
    try {
      // API 요청 보내기
      final response = await dio.get(apiUrl);

      // 요청 성공 시 데이터 확인
      if (response.statusCode == 200 && response.data != null) {
        print('API 응답: ${response.data}'); // 응답 확인

        // 응답 데이터가 예상대로 'certificateInfo'에 포함되어 있는지 확인
        if (response.data['certificateInfo'] != null) {
          List certificatesInfoJson = response.data['certificateInfo'];
          return certificatesInfoJson
              .map((json) => CertificateInfo.fromJson(json))
              .toList();
        } else {
          // 예상된 키가 응답에 없을 경우
          throw Exception('certificateInfo 필드가 응답에 없습니다.');
        }
      } else {
        throw Exception('서버 응답이 실패했습니다. 상태 코드: ${response.statusCode}');
      }
    } catch (e) {
      // 모든 오류 처리
      print('Error fetching certificates: $e');
      throw Exception('Error fetching certificates');
    }
  }
}
