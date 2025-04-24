import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../core/public_featuer/domen/entity/pagination.dart';
import '../core/services/services_locator.dart';
import '../core/utils/navigation/routing_screen_path.dart';
import '../stack_viewer/features/questions/presentation/controller/question_controller/question_bloc.dart';
import '../stack_viewer/features/questions/presentation/widgets/animated_app_name.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToQuestions();
  }

  @override
  void dispose() {
    // Dispose SvgController
    // controller.dispose();
    super.dispose();
  }

  Future<void> _navigateToQuestions() async {
    await Future.delayed(const Duration(seconds: 3));
    sl<QuestionBloc>();
    if (mounted) {
      sl<QuestionBloc>().add(
        GetQuestionsEvent(
          pagination: Pagination(
            currentPage: 0,
            perPage: 10,
          ),
        ),
      );
      context.go(RoutingScreenPath.questionsListScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Icon
            Icon(
              Icons.question_answer,
              size: 100.sp,
              color: Theme.of(context).primaryColor,
            ),
            SizedBox(height: 20.h),
            // Animated App Name
            AnimatedAppName(
              appName: 'Stack Viewer',
              textStyle: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
              duration: const Duration(milliseconds: 1500),
            ),
            SizedBox(height: 40.h),
            // Loading Indicator
            CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
