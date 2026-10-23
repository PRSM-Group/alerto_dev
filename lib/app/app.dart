import 'package:flutter/material.dart';

import '../features/map/presentation/screens/map_screen.dart';

class AlertoApp extends StatelessWidget {
  const AlertoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ALERTO',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.red,
        ),
        useMaterial3: true,
      ),

      home: const MapScreen(),
    );
  }
}