// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:test/main.dart';

void main() {
  // 로그인 화면 테스트
  testWidgets('Login screen test', (WidgetTester tester) async {
    // 앱 실행
    await tester.pumpWidget(const ProviderScope(child: MyApp()));

    // 로그인 화면의 주요 요소들이 존재하는지 확인
    expect(find.text('환영합니다'), findsOneWidget);
    expect(find.text('계정에 로그인하세요'), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(2)); // 이메일과 비밀번호 입력 필드
    expect(find.text('로그인'), findsOneWidget);
    expect(find.text('Google로 계속하기'), findsOneWidget);
  });

  // 회원가입 화면으로 이동 테스트
  testWidgets('Navigate to signup screen', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: MyApp()));

    // 회원가입 버튼 찾기 및 클릭
    await tester.tap(find.text('회원가입'));
    await tester.pumpAndSettle(); // 애니메이션 완료 대기

    // 회원가입 화면의 주요 요소들이 존재하는지 확인
    expect(find.text('새로운 계정을 만들어보세요'), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(4)); // 이름, 이메일, 비밀번호, 비밀번호 확인
    expect(find.byType(Checkbox), findsOneWidget); // 이용약관 동의 체크박스
  });

  // 프로필 화면으로 이동 테스트
  testWidgets('Navigate to profile screen', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: MyApp()));

    // 로그인 버튼 찾기 및 클릭
    final loginButton = find.widgetWithText(ElevatedButton, '로그인');
    await tester.tap(loginButton);
    await tester.pumpAndSettle();

    // 프로필 화면의 주요 요소들이 존재하는지 확인
    expect(find.text('프로필'), findsOneWidget);
    expect(find.text('김민지'), findsOneWidget);
    expect(find.text('@minji_kim'), findsOneWidget);
    expect(find.byType(GridView), findsOneWidget);
    expect(find.byType(BottomNavigationBar), findsOneWidget);
  });

  // 뒤로가기 네비게이션 테스트
  testWidgets('Back navigation test', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: MyApp()));

    // 회원가입 화면으로 이동
    await tester.tap(find.text('회원가입'));
    await tester.pumpAndSettle();

    // 뒤로가기 버튼 찾기 및 클릭
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    // 다시 로그인 화면으로 돌아왔는지 확인
    expect(find.text('환영합니다'), findsOneWidget);
    expect(find.text('계정에 로그인하세요'), findsOneWidget);
  });
}
