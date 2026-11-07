import 'package:alerto_dev/core/providers/providers.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../features/auth/presentation/screens/login_screen.dart';
import '../features/map/presentation/screens/map_screen.dart';
import '../features/reports/presentation/screens/report_screen.dart';
import '../features/profile/presentation/screens/profile_tab.dart';

// for now
// if gagawa na tayo frfr we use shellroute apparently for the switching between tabs and shi

// TEMPORARY BYPASS: Force true for development
const bool bypassAuth = true;

final routerProvider = Provider<GoRouter>((ref) {
  final refreshNotifier = _RouterRefreshNotifier();

  ref.listen(authStateStreamProvider, (previous, next) {
    refreshNotifier.triggerRefresh();
  });

  final router = GoRouter(
    initialLocation: '/login',
    refreshListenable: refreshNotifier,

    redirect: (context, state) {
      // Temporarily bypass authentication for dev
      if (bypassAuth) {
        return null;
      }

      final authState = ref.read(authStateStreamProvider);

      final isLoggingIn = state.matchedLocation == '/login';

      // Wait for the auth checking to complete
      if (authState.isLoading) {
        return '/loading';
      }

      // error handle auth errors
      if (authState.hasError) {
        return isLoggingIn ? null : '/login';
      }

      final session = authState.value?.session;
      final isLoggedIn = session != null;

      if (!isLoggedIn && !isLoggingIn) {
        return '/login';
      }

      if (isLoggedIn && isLoggingIn) {
        return '/profile';
      }

      return null;
    },

    routes: [
      GoRoute(
        path: '/loading',
        builder: (context, state) => const _LoadingScreen(),
      ),
      GoRoute(
        path: '/login',
        name: 'Login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/map',
        name: 'Map',
        builder: (context, state) => const MapScreen(),
      ),
      GoRoute(
        path: '/report',
        name: 'Report',
        builder: (context, state) => const ReportScreen(),
      ),
      GoRoute(
        path: '/profile',
        name: 'Profile',
        builder: (context, state) => const ProfileTab(),
      ),
    ],
  );

  ref.onDispose(() {
    router.dispose();
    refreshNotifier.dispose();
  });

  return router;
});

class _RouterRefreshNotifier extends ChangeNotifier {
  void triggerRefresh() {
    notifyListeners();
  }
}

class _LoadingScreen extends StatelessWidget {
  const _LoadingScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
