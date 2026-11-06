import 'package:flutter/material.dart';
import 'package:alerto_dev/app/router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AlertoApp extends ConsumerWidget {
  const AlertoApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      title: 'ALERTO',
      debugShowCheckedModeBanner: false,
      routerConfig: router,

      theme: ThemeData(useMaterial3: true, fontFamily: 'GoogleSansFlex'),
    );
  }
}
