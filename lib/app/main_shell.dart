import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:alerto_dev/shared/widgets/app_nav_bar.dart';

class MainShell extends StatelessWidget {
  const MainShell({super.key, required this.navShell});
  final StatefulNavigationShell navShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navShell,
      bottomNavigationBar: AppNavBar(
        currentIndex: navShell.currentIndex,
        onTap: (index) {
          navShell.goBranch(
            index,
            initialLocation: index == navShell.currentIndex,
          );
        },
      ),
    );
  }
}
