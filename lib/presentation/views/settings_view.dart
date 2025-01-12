import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  // 토글 상태 변수 추가
  bool isPushEnabled = true;
  bool isEmailEnabled = false;
  bool _isCurrentPasswordVisible = false; // 현재 비밀번호 가시성
  bool _isNewPasswordVisible = false; // 새 비밀번호 가시성

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          '설정',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.go('/profile'),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              // 프로필 섹션
              Center(
                child: Stack(
                  children: [
                    const CircleAvatar(
                      radius: 48,
                      backgroundColor: Color(0xFFE5E7EB),
                      child: Icon(Icons.person, size: 48, color: Colors.blue),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Center(
                child: Text(
                  '김민지',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // 이름 입력
              _buildLabel('이름'),
              _buildTextField('홍길동'),
              const SizedBox(height: 12),

              // 이메일 입력
              _buildLabel('이메일'),
              _buildTextField('name@company.com'),
              const SizedBox(height: 12),

              // 전화번호 입력
              _buildLabel('전화번호'),
              _buildTextField('010-0000-0000'),
              const SizedBox(height: 12),

              // 보안 설정
              _buildSectionTitle('보안 설정'),
              const SizedBox(height: 12),

              // 현재 비밀번호
              _buildPasswordField('현재 비밀번호'),
              const SizedBox(height: 12),

              // 새 비밀번호
              _buildPasswordField('새 비밀번호'),
              const SizedBox(height: 12),

              // 알림 설정
              _buildSectionTitle('알림 설정'),
              const SizedBox(height: 12),
              _buildSwitchRow(
                '푸시 알림',
                isPushEnabled,
                onChanged: (value) {
                  setState(() {
                    isPushEnabled = value;
                  });
                },
              ),
              const SizedBox(height: 8),
              _buildSwitchRow(
                '이메일 알림',
                isEmailEnabled,
                onChanged: (value) {
                  setState(() {
                    isEmailEnabled = value;
                  });
                },
              ),
              const SizedBox(height: 32),

              // 계정 관리
              _buildSectionTitle('계정 관리'),
              const SizedBox(height: 16),
              _buildAccountButton(
                '로그아웃',
                Icons.logout,
                onTap: () => context.go('/login'),
              ),
              _buildAccountButton(
                '계정 삭제',
                Icons.delete_outline,
                isDestructive: true,
                onTap: () {},
              ),
              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    '변경사항 저장',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildTextField(String hint) {
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey[400]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          // borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          // borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.blue),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
    );
  }

  Widget _buildPasswordField(String label) {
    bool isCurrentPassword = label == '현재 비밀번호';
    return TextField(
      obscureText: isCurrentPassword
          ? !_isCurrentPasswordVisible
          : !_isNewPasswordVisible,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            isCurrentPassword
                ? (_isCurrentPasswordVisible
                    ? Icons.visibility
                    : Icons.visibility_off)
                : (_isNewPasswordVisible
                    ? Icons.visibility
                    : Icons.visibility_off),
          ),
          onPressed: () {
            setState(() {
              if (isCurrentPassword) {
                _isCurrentPasswordVisible = !_isCurrentPasswordVisible;
              } else {
                _isNewPasswordVisible = !_isNewPasswordVisible;
              }
            });
          },
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildSwitchRow(String title, bool value,
      {required ValueChanged<bool> onChanged}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: Colors.white, // 활성화 상태의 thumb(동그라미) 색상
          activeTrackColor: Colors.blue, // 활성화 상태의 track(배경) 색상
          inactiveTrackColor: const Color(0xFFE8E8E8), // 비활성화 상태의 track(배경) 색상
          inactiveThumbColor: Colors.white, // 비활성화 상태의 thumb(동그라미) 색상
          trackOutlineColor:
              WidgetStateProperty.all(Colors.transparent), // 트랙 테두리 색상
          splashRadius: 30, // 터치 효과 반경
        ),
      ],
    );
  }

  Widget _buildAccountButton(String title, IconData icon,
      {bool isDestructive = false, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Icon(
              icon,
              color: isDestructive ? Colors.red : Colors.black87,
              size: 20,
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                color: isDestructive ? Colors.red : Colors.black87,
                fontSize: 16,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.chevron_right,
              color: Colors.grey[400],
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
