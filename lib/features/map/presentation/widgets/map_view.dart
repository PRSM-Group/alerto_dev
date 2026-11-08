import 'package:flutter/material.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MapView extends ConsumerStatefulWidget {
  const MapView({super.key});

  @override
  ConsumerState<MapView> createState() => _MapViewState();
}

class _MapViewState extends ConsumerState<MapView> {
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

  final Map<String, dynamic> outsideMask = {
    'type': 'FeatureCollection',
    'features': [
      {
        'type': 'Feature',
        'properties': {},
        'geometry': {
          'type': 'Polygon',
          'coordinates': [
            //beyond kamuning
            [
              [120.9, 14.5],
              [121.2, 14.5],
              [121.2, 14.8],
              [120.9, 14.8],
              [120.9, 14.5],
            ],
            // kamuning
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

    await controller.addGeoJsonSource('outside-mask-source', outsideMask);

    await controller.addFillLayer(
      'outside-mask-source',
      'outside-mask-fill',
      const FillLayerProperties(fillColor: '#737373', fillOpacity: 0.35),
    );
    await controller.addGeoJsonSource('kamuning-boundary-source', {
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
                [121.03644269530835, 14.628553512834465],
              ],
            ],
          },
        },
      ],
    });
    await controller.addLineLayer(
      'kamuning-boundary-source',
      'kamuning-boundary-outline',
      const LineLayerProperties(
        lineColor: '#D4AF37',
        lineWidth: 1.5,
        lineOpacity: 0.95,
        lineDasharray: [2, 2],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _loadMapStyle(),
      builder: (context, snapshot) {
        // 1. Loading State
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // 2. Error State
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Unable to load map style: ${snapshot.error}'),
            ),
          );
        }

        // 3. Success State: Pass the loaded string to your separate file/widget
        return MapLibreMap(
          styleString: snapshot.data!,
          initialCameraPosition: const CameraPosition(
            target: kamuningCenter,
            zoom: 25.0,
          ),

          cameraTargetBounds: CameraTargetBounds(
            LatLngBounds(
              southwest: LatLng(14.621910952709165, 121.03246073405178),
              northeast: LatLng(14.632567270456779, 121.04774269463634),
            ),
          ),

          // Restrict zoom levels
          minMaxZoomPreference: const MinMaxZoomPreference(14, 19),
          onMapCreated: (controller) {
            _mapController = controller;
          },
          onStyleLoadedCallback: _onStyleLoaded,
        );
      },
    );
  }
}
