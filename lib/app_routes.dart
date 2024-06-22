import 'package:go_router/go_router.dart';
import 'package:schedule_qu/pages/home/home_page.dart';
import 'package:schedule_qu/pages/schedule/schedule_page.dart';
import 'package:schedule_qu/pages/splash/splash_page.dart';
import 'package:schedule_qu/pages/user/user_page.dart';

// GoRouter configuration
final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: '/user',
      builder: (context, state) => UserPage(),
    ),
    GoRoute(
        path: '/home',
        builder: (context, state) => const HomePage(),
        routes: [
          GoRoute(
            path: 'schedule',
            name: 'schedule',
            builder: (context, state) => SchedulePage(),
          )
        ]),
  ],
  initialLocation: '/',
  debugLogDiagnostics: true,
);
