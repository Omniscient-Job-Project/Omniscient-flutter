import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController userIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome to 전직시',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                '당신의 꿈을 응원합니다!',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(height: 32),
              CustomTextField(
                controller: userIdController,
                labelText: '아이디',
              ),
              SizedBox(height: 16),
              CustomTextField(
                controller: passwordController,
                labelText: '패스워드',
                obscureText: true,
              ),
              SizedBox(height: 24),
              CustomButton(
                text: '로그인',
                onPressed: () async {
                  if (userIdController.text.isEmpty || passwordController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('아이디와 비밀번호를 모두 입력해주세요.')),
                    );
                    return;
                  }

                  bool success = await AuthService.login(
                    userIdController.text,
                    passwordController.text,
                  );
                  if (success) {
                    Navigator.of(context).pushReplacementNamed('/home');
                  } else {
                    String errorMessage = AuthService.getLastErrorMessage();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(errorMessage)),
                    );
                  }
                },
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    child: Text('회원가입'),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/register');
                    },
                  ),
                  TextButton(
                    child: Text('아이디/비밀번호 찾기'),
                    onPressed: () {
                      // TODO: 아이디/비밀번호 찾기 기능 구현
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}