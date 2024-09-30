import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/auth_service.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController _userIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('회원가입')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20),
            Text(
              '전직시에 오신 것을 환영합니다!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            CustomTextField(
              controller: _userIdController,
              labelText: '아이디',
              hintText: '4-20자리 / 영문, 숫자, 특수문자 \'_\' 사용가능',
            ),
            SizedBox(height: 16),
            CustomTextField(
              controller: _passwordController,
              labelText: '비밀번호',
              hintText: '8-16자리/영문 대소문자, 숫자, 특수문자 조합',
              obscureText: true,
            ),
            SizedBox(height: 16),
            CustomTextField(
              controller: _usernameController,
              labelText: '이름',
              hintText: '실명을 입력해주세요',
            ),
            SizedBox(height: 16),
            CustomTextField(
              controller: _phoneNumberController,
              labelText: '휴대폰',
              hintText: '"-" 빼고 숫자만 입력',
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 16),
            CustomTextField(
              controller: _birthDateController,
              labelText: '생년월일',
              hintText: 'YYYYMMDD',
              keyboardType: TextInputType.datetime,
            ),
            SizedBox(height: 16),
            CustomTextField(
              controller: _emailController,
              labelText: '이메일',
              hintText: 'example@example.com',
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 24),
            CustomButton(
              text: '회원가입',
              onPressed: () async {
                if (!validateInputs()) {
                  return;
                }
                bool success = await AuthService.register(
                  _userIdController.text,
                  _passwordController.text,
                  _usernameController.text,
                  _phoneNumberController.text,
                  _birthDateController.text,
                  _emailController.text,
                );
                if (success) {
                  Get.snackbar('성공', '회원가입이 완료되었습니다.');
                  Get.offAllNamed('/login');
                } else {
                  final errorMessage = AuthService.getLastErrorMessage();
                  Get.snackbar('오류', '회원가입에 실패했습니다: $errorMessage');
                  print('Registration failed with error: $errorMessage');
                }
              },
            ),
            SizedBox(height: 16),
            TextButton(
              child: Text('이미 계정이 있으신가요? 로그인하기'),
              onPressed: () => Get.offAllNamed('/login'),
            ),
          ],
        ),
      ),
    );
  }

  bool validateInputs() {
    if (_userIdController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _usernameController.text.isEmpty ||
        _phoneNumberController.text.isEmpty ||
        _birthDateController.text.isEmpty ||
        _emailController.text.isEmpty) {
      Get.snackbar('오류', '모든 필드를 입력해주세요.');
      return false;
    }
    // 여기에 추가적인 유효성 검사 로직을 구현할 수 있습니다.
    return true;
  }
}