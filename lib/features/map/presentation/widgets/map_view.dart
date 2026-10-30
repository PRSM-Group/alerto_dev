import 'package:flutter/material.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

class MapView extends StatelessWidget {
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    return MapLibreMap(
      initialCameraPosition: const CameraPosition(
        target: LatLng(
          14.627337721715183,
          121.03360957468315,
        ), // Example coordinates (San Francisco)
        zoom: 50.0,
      ),
    );
  }
}
