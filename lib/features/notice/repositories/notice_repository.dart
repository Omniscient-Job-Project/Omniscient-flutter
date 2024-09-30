import 'dart:convert';
import 'package:dio/dio.dart';
import '../models/notice.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class NoticeRepository {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: dotenv.env['API_URL'] ?? 'http://default.url',
    responseType: ResponseType.plain,
  ));

  // 공지사항 목록 조회
  Future<List<Notice>> fetchNotices() async {
    try {
      final response = await _dio.get('/api/v1/notice');

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.data);

        // noticeStatus가 false가 아닌 항목들만 필터링하고, 순차적으로 번호 부여
        List<Notice> notices = data
            .where((notice) => notice['noticeStatus'] != false)
            .toList()
            .asMap()
            .entries
            .map((entry) => Notice.fromJson(entry.value, entry.key + 1))
            .toList();

        return notices;
      } else {
        throw Exception('Failed to load notices');
      }
    } catch (e) {
      print('Error fetching notices: $e');
      throw Exception('Error fetching notices: $e');
    }
  }

  // 공지사항 상세 조회
  Future<Notice> fetchNoticeById(int noticeId) async {
    try {
      final response = await _dio.get('/api/v1/notice/$noticeId');

      if (response.statusCode == 200) {
        return Notice.fromJson(jsonDecode(response.data), 1); // displayId는 1로 설정
      } else {
        throw Exception('Failed to load notice detail');
      }
    } catch (e) {
      print('Error fetching notice detail: $e');
      throw Exception('Error fetching notice detail: $e');
    }
  }

  // 조회수 증가
  Future<void> incrementViewCount(int noticeId) async {
    try {
      await _dio.put('/api/v1/notice/views/$noticeId');
    } catch (e) {
      print('Error incrementing view count: $e');
      throw Exception('Error incrementing view count: $e');
    }
  }
}
