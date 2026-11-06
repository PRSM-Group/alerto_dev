import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

import '../widgets/map_bottom_sheet.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapLibreMapController? _mapController;

  // kamuning center
  static const LatLng kamuningCenter = LatLng(
    14.627608835785841,
    121.04075568714347,
  );

  Future<String> _loadMapStyle() async {
    return await rootBundle.loadString(
      'lib/features/map/assets/map_style.json',
    );
  }

  final Map<String, dynamic> kamuningBoundary = {
    'type': 'FeatureCollection',
    'features': [
      {
        'type': 'Feature',
        'properties': {'name': 'Barangay Kamuning'},
        'geometry': {
          'type': 'Polygon',
          'coordinates': [
            [
              [121.03644269530835, 14.628553512834465],
              [121.03380340166547, 14.627857981782416],
              [121.0334278924181, 14.626062048168503],
              [121.03401797837823, 14.625947855361034],
              [121.03485482755806, 14.625293840864966],
              [121.03609937249217, 14.624795542798472],
              [121.03697913701458, 14.624764399131779],
              [121.03736537509756, 14.624712493010797],
              [121.0380091052359, 14.624743636684842],
              [121.03938239619767, 14.62601014235428],
              [121.0429765561367, 14.627650360150366],
              [121.04333060789621, 14.627577692555075],
              [121.04364174412973, 14.627629597998675],
              [121.04425328776114, 14.628397797129065],
              [121.04593771495644, 14.628480845522677],
              [121.04622739351869, 14.627712646682916],
              [121.04693549667086, 14.62799293576026],
              [121.04555147687346, 14.631107234761137],
            ],
          ],
        },
      },
    ],
  };

  Future<void> _onStyleLoaded() async {
    final controller = _mapController;

    if (controller == null) return;

    await controller.addGeoJsonSource(
      'kamuning-boundary-source',
      kamuningBoundary,
    );

    await controller.addFillLayer(
      'kamuning-boundary-source',
      'kamuning-boundary-fill',
      const FillLayerProperties(fillColor: '#D4AF37', fillOpacity: 0.12),
    );

    await controller.addLineLayer(
      'kamuning-boundary-source',
      'kamuning-boundary-outline',
      const LineLayerProperties(
        lineColor: '#D4AF37',
        lineWidth: 3.0,
        lineOpacity: 1.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _loadMapStyle(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Unable to load map style: ${snapshot.error}'),
            ),
          );
        }

        return Stack(
          children: [
            MapLibreMap(
              styleString: snapshot.data!,
              initialCameraPosition: const CameraPosition(
                target: kamuningCenter,
                zoom: 15,
              ),
              onMapCreated: (controller) {
                _mapController = controller;
              },
              onStyleLoadedCallback: _onStyleLoaded,
            ),

            const MapBottomSheet(),
          ],
        );
      },
    );
  }
}
