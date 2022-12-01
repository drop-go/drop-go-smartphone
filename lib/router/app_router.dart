import 'package:drop_go_smartphone/view/home_screen.dart';
import 'package:drop_go_smartphone/view/info_screen.dart';
import 'package:drop_go_smartphone/view/map_screen.dart';
import 'package:drop_go_smartphone/view/splash_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider(
  (ref) => GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: "/info",
        builder: (context, state) => const InfoScreen(),
      ),
      GoRoute(
        path: "/home",
        // path: "/",
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/map',
        builder: (context, state) => const MapScreen(),
      ),
    ],
  ),
);
