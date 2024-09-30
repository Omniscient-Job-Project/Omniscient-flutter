import 'dart:convert';
import 'package:http/http.dart' as http; // http 패키지 임포트
import '../models/user.dart';
import '../models/user_profile.dart'; // Assuming you have a UserProfile model

class UserRepository {
  final String apiUrl;

  UserRepository(this.apiUrl);

  // Fetch user info
  Future<User?> fetchUser(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$apiUrl/api/v1/user/me'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return User.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load user. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching user: $error');
      return null;
    }
  }

  // Fetch user profile
  Future<UserProfile?> getUserProfile(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$apiUrl/api/v1/mypage/profile'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return UserProfile.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load user profile. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching user profile: $error');
      return null;
    }
  }
}
