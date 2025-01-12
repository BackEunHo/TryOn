import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/views/login_view.dart';
import '../../presentation/views/signup_view.dart';
import '../../presentation/views/profile_view.dart';
import '../../presentation/views/settings_view.dart';
import '../../presentation/views/explore_view.dart';
import '../../presentation/views/project_view.dart';

final router = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginView(),
    ),
    GoRoute(
      path: '/signup',
      name: 'signup',
      builder: (context, state) => const SignupView(),
    ),
    GoRoute(
      path: '/settings',
      name: 'settings',
      builder: (context, state) => const SettingsView(),
    ),
    ShellRoute(
      builder: (context, state, child) {
        return ScaffoldWithBottomNav(child: child);
      },
      routes: [
        GoRoute(
          path: '/explore',
          name: 'explore',
          builder: (context, state) => const ExploreView(),
        ),
        GoRoute(
          path: '/project',
          name: 'project',
          builder: (context, state) => const ProjectView(),
        ),
        GoRoute(
          path: '/profile',
          name: 'profile',
          builder: (context, state) => const ProfileView(),
        ),
      ],
    ),
  ],
);

// 하단 네비게이션을 포함한 Scaffold
class ScaffoldWithBottomNav extends StatelessWidget {
  final Widget child;

  const ScaffoldWithBottomNav({Key? key, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _calculateSelectedIndex(context),
        onTap: (int idx) => _onItemTapped(idx, context),
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: '탐색'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: '프로젝트'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '내 정보'),
        ],
      ),
    );
  }

  static int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).matchedLocation;
    if (location.startsWith('/explore')) return 0;
    if (location.startsWith('/project')) return 1;
    if (location.startsWith('/profile')) return 2;
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/explore');
        break;
      case 1:
        context.go('/project');
        break;
      case 2:
        context.go('/profile');
        break;
    }
  }
}
