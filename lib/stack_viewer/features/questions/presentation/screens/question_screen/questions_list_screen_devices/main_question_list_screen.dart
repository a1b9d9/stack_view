import 'package:flutter/cupertino.dart';
import 'package:stack_viewer/stack_viewer/features/questions/presentation/screens/question_screen/questions_list_screen_devices/questions_list_mobile_portrait_screen.dart';

import '../../../../../../../core/responsive/responsive_layout.dart';

class QuestionsListScreen extends StatelessWidget {
   const QuestionsListScreen({super.key,  });

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      mobilePortrait: QuestionsListScreenMobilePortraitScreen(),
    );
  }
}
