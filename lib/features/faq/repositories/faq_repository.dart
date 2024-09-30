import 'package:dio/dio.dart';
import '../models/faq.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class FaqRepository {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: dotenv.env['API_URL'] ?? 'http://default.url',
    responseType: ResponseType.json,
  ));

  Future<List<Faq>> fetchFaqs() async {
    try {
      final response = await _dio.get('/api/v1/faqs');
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((faqJson) => Faq.fromJson(faqJson)).toList();
      } else {
        throw Exception('Failed to load FAQs');
      }
    } catch (e) {
      throw Exception('Error fetching FAQs: $e');
    }
  }

  Future<void> incrementFaqViews(int faqId) async {
    try {
      await _dio.put('/api/v1/faqs/views/$faqId');
    } catch (e) {
      throw Exception('Error incrementing FAQ views: $e');
    }
  }
}
