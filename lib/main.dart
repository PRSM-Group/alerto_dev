import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://lzosxcfevifbeznkxojb.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imx6b3N4Y2ZldmlmYmV6bmt4b2piIiwicm9sZSI6ImFub24iLCJpYXQiOjE3OTMzNTc1NTQsImV4cCI6MjEwODkzMzU1NH0.pwo-vY6dQqZt6DGAjdAsPqyUKFt-M1Iu8qFPlJV_FrE',
  );
  runApp(const ProviderScope(child: AlertoApp()));
}

class AlertoApp extends StatelessWidget {
  const AlertoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'ALERTO',
      debugShowCheckedModeBanner: false,
      // routerConfig: router,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
        useMaterial3: true,
      ),
    );
  }
}
