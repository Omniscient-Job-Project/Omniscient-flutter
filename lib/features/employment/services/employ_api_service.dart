import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // 환경변수 사용
import '../models/employment.dart';

class EmploymentService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: dotenv.env['API_URL'] ?? 'http://default.url',
    responseType: ResponseType.plain,
  ));

  Future<List<Employment>> fetchEmploymentList() async {
    try {
      final response = await _dio.get('/employment');
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.data);
        return data.map((json) => Employment.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load employment data');
      }
    } catch (e) {
      throw Exception('Error fetching employment data: $e');
    }
  }
}
