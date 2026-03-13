import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../ui/screens/splash_screen.dart';
import '../ui/screens/onboarding_screen.dart';
import '../ui/screens/main_scaffold.dart';
import '../ui/screens/home_screen.dart';
import '../ui/screens/analyze_screen.dart';
import '../ui/screens/result_screen.dart';
import '../ui/screens/history_screen.dart';
import '../ui/screens/history_detail_screen.dart';
import '../ui/screens/settings_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(path: '/splash', builder: (context, state) => const SplashScreen()),
      GoRoute(path: '/onboarding', builder: (context, state) => const OnboardingScreen()),
      ShellRoute(
        builder: (context, state, child) => MainScaffold(child: child),
        routes: [
          GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
          GoRoute(path: '/history', builder: (context, state) => const HistoryScreen()),
          GoRoute(path: '/settings', builder: (context, state) => const SettingsScreen()),
        ],
      ),
      GoRoute(path: '/analyze', builder: (context, state) => const AnalyzeScreen()),
      GoRoute(path: '/result', builder: (context, state) => const ResultScreen()),
      GoRoute(
        path: '/history/detail/:id',
        builder: (context, state) => HistoryDetailScreen(id: state.pathParameters['id']!),
      ),
    ],
  );
});
