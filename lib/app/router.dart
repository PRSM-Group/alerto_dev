import 'package:go_router/go_router.dart';

import '../features/map/presentation/screens/map_screen.dart';

// for now
// if gagawa na tayo frfr we use shellroute apparently for the switching between tabs and shi

final GoRouter router = GoRouter(
  initialLocation: '/map', //eto muna
  routes: [
    GoRoute(
      path: '/map',
      name: 'Map',
      builder: (context, state) => const MapScreen(),
    ),
  ],
);
