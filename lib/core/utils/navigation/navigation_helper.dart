import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../main/splash_screen.dart';
import '../../../test.dart';
import '../../../stack_viewer/features/questions/presentation/screens/question_screen/questions_list_screen_devices/main_question_list_screen.dart';
import 'routing_screen_path.dart';

// Scale transition
Widget _scaleTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
    ) {
  const double begin = -1;
  const double end = 1;
  const curve = Curves.elasticOut;
  final tween = Tween<double>(begin: begin, end: end).chain(CurveTween(curve: curve));
  final scaleAnimation = animation.drive(tween);

  return ScaleTransition(
    scale: scaleAnimation,
    child: child,
  );
}

final GoRouter router = GoRouter(
  initialLocation: RoutingScreenPath.splashScreen,  // Set splash as the initial route
  routes: [
    GoRoute(
      path: RoutingScreenPath.splashScreen,
      pageBuilder: (context, state) {
        return const CustomTransitionPage(
          child: SplashScreen(),
          transitionsBuilder: _scaleTransition,  // Specify animation here
        );
      },
    ),
    GoRoute(
      path: RoutingScreenPath.testScreen,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          child: const TestBlocPage(),
          transitionsBuilder: _scaleTransition,
        );
      },
    ),
    GoRoute(
      path: RoutingScreenPath.questionsListScreen,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          child: const QuestionsListScreen(),
          transitionsBuilder: _scaleTransition,
        );
      },
    ),
  ],
);
