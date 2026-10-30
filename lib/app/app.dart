import 'package:flutter/material.dart';
import 'package:alerto_dev/app/router.dart';

class AlertoApp extends StatelessWidget {
  const AlertoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'ALERTO',
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
    );
  }
}
