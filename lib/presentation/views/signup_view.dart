import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignupView extends StatefulWidget {
  const SignupView({Key? key}) : super(key: key);

  @override
  _SignupViewState createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  bool _isPasswordObscured = true; // 비밀번호 가시성 상태
  bool _isConfirmPasswordObscured = true; // 비밀번호 확인 가시성 상태
  bool _agreeToTerms = false; // 이용약관 동의 체크박스 상태

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _nameController =
      TextEditingController(); // 이름 입력 컨트롤러 추가
  final TextEditingController _phoneController = TextEditingController();

  String? _emailError;
  String? _passwordError;
  String? _confirmPasswordError;
  String? _nameError; // 이름 오류 메시지
  String? _termsError;
  String? _phoneError;

  // void _togglePasswordVisibility() {
  //   setState(() {
  //     _isPasswordObscured = !_isPasswordObscured; // 비밀번호 가시성 토글
  //   });
  // }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _isConfirmPasswordObscured =
          !_isConfirmPasswordObscured; // 비밀번호 확인 가시성 토글
    });
  }

  void _validateInputs() {
    setState(() {
      _emailError = null;
      _passwordError = null;
      _confirmPasswordError = null;
      _nameError = null; // 이름 오류 초기화
      _termsError = null;
      _phoneError = null;

      // 1. 이름 입력 확인
      if (_nameController.text.isEmpty) {
        _nameError = '이름을 입력하세요.'; // 이름 입력 오류 메시지
      }

      // 2. 이메일 형식 확인
      final emailRegex =
          RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
      if (!emailRegex.hasMatch(_emailController.text)) {
        _emailError = '유효한 이메일 주소를 입력하세요.';
      }

      // 3. 비밀번호 입력 확인
      if (_passwordController.text.isEmpty) {
        _passwordError = '비밀번호를 입력하세요.';
      } else if (_passwordController.text != _confirmPasswordController.text) {
        _confirmPasswordError = '비밀번호가 일치하지 않습니다.';
      }

      // 4. 이용약관 동의 체크 여부 확인
      if (!_agreeToTerms) {
        _termsError = '이용약관 및 개인정보처리방침에 동의해야 합니다.';
      }

      // 전화번호 입력 확인 (선택사항)
      if (_phoneController.text.isNotEmpty) {
        // 입력된 경우에만 검증
        final phoneRegex = RegExp(r'^010-?([0-9]{4})-?([0-9]{4})$');
        if (!phoneRegex.hasMatch(_phoneController.text)) {
          _phoneError = '올바른 전화번호 형식이 아닙니다.';
        }
      }

      // 모든 검증이 통과하면 프로필 화면으로 이동
      if (_emailError == null &&
          _passwordError == null &&
          _confirmPasswordError == null &&
          _nameError == null &&
          _termsError == null) {
        // _phoneError 제거
        context.go('/profile');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.go('/login'),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              SvgPicture.asset('assets/logo.svg', height: 80),
              const Text(
                '회원가입',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const Text(
                '새로운 계정을 만들어보세요',
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: '홍길동',
                  errorText: _nameError,
                  label: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('이름'),
                      const Text('*', style: TextStyle(color: Colors.red)),
                    ],
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'name@company.com',
                  errorText: _emailError,
                  label: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('이메일 주소'),
                      const Text('*', style: TextStyle(color: Colors.red)),
                    ],
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: _isPasswordObscured,
                decoration: InputDecoration(
                  hintText: '최소 8자 이상',
                  helperText: '영문, 숫자, 특수문자 포함 8자 이상',
                  errorText: _passwordError,
                  label: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('비밀번호'),
                      const Text('*', style: TextStyle(color: Colors.red)),
                    ],
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _confirmPasswordController,
                obscureText:
                    _isConfirmPasswordObscured, // 비밀번호 확인 가시성 상태에 따라 설정
                decoration: InputDecoration(
                  hintText: '비밀번호 재입력',
                  errorText: _confirmPasswordError, // 비밀번호 확인 오류 메시지
                  label: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('비밀번호 확인'),
                      const Text('*', style: TextStyle(color: Colors.red)),
                    ],
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isConfirmPasswordObscured
                          ? Icons.visibility_off
                          : Icons.visibility_rounded,
                    ),
                    onPressed: _toggleConfirmPasswordVisibility, // 클릭 시 가시성 토글
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _phoneController,
                decoration: InputDecoration(
                  hintText: '010-0000-0000',
                  labelText: '전화번호',
                  errorText: _phoneError,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Checkbox(
                    value: _agreeToTerms,
                    onChanged: (value) {
                      setState(() {
                        _agreeToTerms = value!;
                      });
                    },
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {}, // 약관 상세 보기 동작
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        alignment: Alignment.centerLeft,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Row(
                        children: [
                          Text(
                            '이용약관 및 개인정보처리방침에 동의합니다',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.black,
                            ),
                          ),
                          Text(' *', style: TextStyle(color: Colors.red)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              if (_termsError != null) // 이용약관 오류 메시지
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    _termsError!,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ElevatedButton(
                onPressed: _validateInputs, // 입력 검증 후 프로필 화면으로 이동
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  '회원가입',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('이미 계정이 있으신가요?'),
                  TextButton(
                    onPressed: () => context.go('/login'),
                    child: const Text('로그인'),
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
