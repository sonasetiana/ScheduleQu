import 'package:go_router/go_router.dart';
import 'package:schedule_qu/pages/home/home_page.dart';
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
      builder: (context, state) => const UserPage(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage(),
    ),
  ],
  initialLocation: '/',
  debugLogDiagnostics: true,
);
