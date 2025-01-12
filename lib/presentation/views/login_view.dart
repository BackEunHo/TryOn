import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool _isObscured = true; // 비밀번호 가시성 상태
  bool _rememberMe = false; // 로그인 상태 유지 체크박스 상태

  void _togglePasswordVisibility() {
    setState(() {
      _isObscured = !_isObscured; // 가시성 토글
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              const SizedBox(height: 60),
              SvgPicture.asset('assets/logo.svg', height: 80),
              const Text(
                '환영합니다',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const Text(
                '계정에 로그인하세요',
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              TextField(
                decoration: InputDecoration(
                  hintText: 'name@company.com',
                  labelText: '이메일 주소',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                obscureText: _isObscured, // 비밀번호 가시성 상태에 따라 설정
                decoration: InputDecoration(
                  hintText: '••••••••',
                  labelText: '비밀번호',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isObscured
                          ? Icons.visibility_off
                          : Icons.visibility_rounded,
                    ),
                    onPressed: _togglePasswordVisibility, // 클릭 시 가시성 토글
                  ),
                ),
              ),
              Row(
                children: [
                  Checkbox(
                    value: _rememberMe, // 체크박스 상태
                    activeColor: Colors.blue, // 체크박스 색상 설정
                    onChanged: (value) {
                      setState(() {
                        _rememberMe = value!; // 체크박스 상태 업데이트
                      });
                    },
                  ),
                  const Text('로그인 상태 유지'),
                  const Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: const Text('비밀번호 찾기'),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () => context.go('/profile'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  '로그인',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              const Row(
                children: [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text('또는'),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              OutlinedButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/google.svg', height: 24),
                    const SizedBox(width: 8),
                    const Text('Google로 계속하기'),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('계정이 없으신가요?'),
                  TextButton(
                    onPressed: () => context.go('/signup'),
                    child: const Text('회원가입'),
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
