import 'dart:convert';
import 'package:http/http.dart' as http;

class WithdrawalRepository {
  final String baseUrl = 'https://your-api-url.com/api/v1/user/withdrawal';

  Future<void> withdrawUser() async {
    final response = await http.post(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      print('Withdrawal successful');
    } else {
      throw Exception('Failed to process withdrawal');
    }
  }
}
