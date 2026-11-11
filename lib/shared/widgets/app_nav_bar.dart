import 'package:flutter/material.dart';
import 'package:alerto_dev/theme/app_colors.dart';

// import 'package:go_router/go_router.dart';

class AppNavBar extends StatelessWidget {
  const AppNavBar({super.key, required this.currentIndex, required this.onTap});

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected: onTap,
      indicatorColor: AppColors.primaryColor,
      backgroundColor: AppColors.background,
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.location_on_rounded),
          label: 'Map',
        ),
        NavigationDestination(icon: Icon(Icons.report), label: 'Reports'),
        NavigationDestination(
          icon: Icon(Icons.location_history_rounded),
          label: 'Contacts',
        ),
        NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }
}
