import 'package:flutter/material.dart';
import '../../../../../../../core/responsive/responsive_layout.dart';
import 'question_detail_mobile_portrait_screen.dart';

class MainQuestionDetailScreen extends StatelessWidget {
  final int questionId;

  const MainQuestionDetailScreen({
    super.key,
    required this.questionId,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        mobilePortrait:  QuestionDetailMobilePortraitScreen(questionId: questionId),

    );
  }
} 