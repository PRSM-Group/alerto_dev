import 'package:flutter/material.dart';

import '../widgets/map_view.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          // Add your map widget here
          MapView(),
        ],
      ),
    );
  }
}
