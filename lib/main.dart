import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/providers/providers.dart';
import 'features/auth/presentation/screens/login_screen.dart';

import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://lzosxcfevifbeznkxojb.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imx6b3N4Y2ZldmlmYmV6bmt4b2piIiwicm9sZSI6ImFub24iLCJpYXQiOjE3OTMzNTc1NTQsImV4cCI6MjEwODkzMzU1NH0.pwo-vY6dQqZt6DGAjdAsPqyUKFt-M1Iu8qFPlJV_FrE',
  );
  runApp(const ProviderScope(child: AlertoApp()));
}

class AlertoApp extends ConsumerWidget {
  const AlertoApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TEMPORARY BYPASS: Force true for development
    const bool bypassAuth = true;

    if (bypassAuth) {
      return MaterialApp(
        title: 'ALERTO',
        theme: ThemeData(useMaterial3: true),
        // Point directly to your map screen during development
        home: const Scaffold(
          body: Center(child: Text('ALERTO Map (Auth Bypassed)')),
        ),
      );
    }

    final authStateAsync = ref.watch(authStateStreamProvider);

    return MaterialApp(
      title: 'ALERTO',
      theme: ThemeData(useMaterial3: true),
      home: authStateAsync.when(
        data: (authState) {
          final session = authState.session;
          // If session is null, show Login; otherwise show your Map screen
          if (session == null) {
            return const LoginScreen();
          } else {
            return const Scaffold(
              body: Center(child: Text('Welcome to ALERTO Map! (Logged In)')),
            );
          }
        },
        loading: () =>
            const Scaffold(body: Center(child: CircularProgressIndicator())),
        error: (error, stack) =>
            Scaffold(body: Center(child: Text('Auth Error: $error'))),
      ),
    );
  }
}
