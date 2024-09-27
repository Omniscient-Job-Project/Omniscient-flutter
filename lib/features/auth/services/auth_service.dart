import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;

class AuthService {
  static String? _lastErrorMessage;
  static const String TOKEN_KEY = 'auth_token';

  static String get baseUrl {
    const String serverUrl = 'http://localhost:8080';

    if (kIsWeb) {
      return serverUrl; // 웹 환경
    } else {
      if (Platform.isAndroid) {
        return serverUrl.replaceAll('localhost', '10.0.2.2'); // Android 에뮬레이터
      } else {
        return serverUrl; // iOS 시뮬레이터 및 기타 플랫폼
      }
    }
  }
  static Future<bool> login(String userId, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/v1/login/post'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'userId': userId,
          'password': password,
        }),
      );

      print('Login response status: ${response.statusCode}');
      print('Login response body: ${response.body}');

      final responseData = json.decode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200 && responseData['accessToken'] != null) {
        final token = responseData['accessToken'];
        await saveToken(token);
        _lastErrorMessage = null;
        return true;
      } else {
        _lastErrorMessage = responseData['errorMessage'] ?? '알 수 없는 오류가 발생했습니다.';
        print('Login failed: $_lastErrorMessage');
        return false;
      }
    } catch (e) {
      _lastErrorMessage = '네트워크 오류: $e';
      print('Login error: $e');
      return false;
    }
  }

  // 수정된 회원가입 메서드
  static Future<bool> register(String userId, String password, String username, String phoneNumber, String birthDate, String email) async {
    try {
      final Map<String, String> requestBody = {
        'userId': userId,
        'password': password,
        'username': username,
        'phoneNumber': phoneNumber,
        'birthDate': birthDate,
        'email': email,
      };

      print('Sending registration request with body: $requestBody');

      final response = await http.post(
        Uri.parse('$baseUrl/api/v1/signup/post'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestBody),
      );


      print('Registration response status: ${response.statusCode}');
      print('Registration response body: ${response.body}');

      if (response.statusCode == 200) {
        _lastErrorMessage = null;
        print('Registration successful');
        return true;
      } else {
        _lastErrorMessage = response.body.trim();
        print('Registration failed: $_lastErrorMessage');
        return false;
      }
    } catch (e) {
      _lastErrorMessage = '네트워크 오류: $e';
      print('Registration error: $e');
      return false;
    }
  }

  // 마지막 에러 메시지 가져오기
  static String getLastErrorMessage() {
    return _lastErrorMessage ?? '알 수 없는 오류가 발생했습니다.';
  }

  // 토큰 저장 메서드
  static Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(TOKEN_KEY, token);
  }

  // 토큰 가져오기 메서드
  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(TOKEN_KEY);
  }

  // 토큰 삭제 메서드 (로그아웃 시 필요)
  static Future<void> removeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(TOKEN_KEY);
  }
}