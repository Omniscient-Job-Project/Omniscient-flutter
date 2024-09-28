import 'dart:convert';

import '../../../core/services/api_employ_service.dart';
import '../models/employment.dart';

class EmployRepository {
  final ApiEmployService apiService;

  // 생성자에서 ApiEmployService를 주입받음
  EmployRepository(this.apiService);

  // 채용 정보를 모두 가져오는 메서드
  Future<List<Employment>> getEmployments({int numOfRows = 100}) async {
    try {
      final response = await apiService.getRequest('/api/v1/employment?numOfRows=$numOfRows');

      // 받아온 원본 데이터를 출력해봅니다.
      print('Response data: ${response.data}');

      // 받아온 데이터를 JSON으로 변환
      final Map<String, dynamic> jsonData = jsonDecode(response.data);

      // 'GGEMPLTSP' 필드가 존재하고 그 안에 'row' 리스트가 있을 경우 처리
      if (jsonData.containsKey('GGEMPLTSP') && jsonData['GGEMPLTSP']['row'] is List) {
        final List<dynamic> employmentData = jsonData['GGEMPLTSP']['row']; // 'row' 리스트 추출
        return employmentData.map((employmentJson) => Employment.fromJson(employmentJson)).toList();
      } else {
        throw Exception('Invalid employment data format');
      }
    } catch (e) {
      throw Exception('Failed to load employment data: $e');
    }
  }

  // 검색으로 채용 정보 찾기
  Future<List<Employment>> searchJobs(String query) async {
    try {
      final response = await apiService.getRequest('/api/v1/employment/search?query=$query');

      // 받아온 원본 데이터를 출력해봅니다.
      print('Search response data: ${response.data}');

      final Map<String, dynamic> jsonData = jsonDecode(response.data);

      if (jsonData.containsKey('data') && jsonData['data'] is List) {
        final List<dynamic> employmentList = jsonData['data']; // 'data' 리스트 추출
        return employmentList.map((employmentJson) => Employment.fromJson(employmentJson)).toList();
      } else {
        throw Exception('Invalid search data format');
      }
    } catch (e) {
      throw Exception('Error searching employment data: $e');
    }
  }
}
