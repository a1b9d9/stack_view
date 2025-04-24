import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stackexchange_plugin/stackexchange_plugin.dart';
import '../../../../../../../core/services/services_locator.dart';
import '../../../../../../../core/utils/enums/request_status_bloc.dart';
import '../../../controller/question_controller/question_bloc.dart';
import '../../../widgets/error_card.dart';
import '../../../widgets/owner_info_card.dart';
import '../../../widgets/stat_item.dart';
import '../../../widgets/static_methode.dart';

class QuestionDetailMobilePortraitScreen extends StatefulWidget {
  final int questionId;

  const QuestionDetailMobilePortraitScreen({
    super.key,
    required this.questionId,
  });

  @override
  State<QuestionDetailMobilePortraitScreen> createState() => _QuestionDetailMobilePortraitScreenState();
}

class _QuestionDetailMobilePortraitScreenState extends State<QuestionDetailMobilePortraitScreen> {
  @override
  void initState() {
    super.initState();
    sl<QuestionBloc>().add(
      GetQuestionByIdEvent(id: widget.questionId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Question Details'),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            final result = await StackexchangePlugin.fetchQuestions();
            print('Plugin response: $result');
          } catch (e) {
            print('Plugin error: $e');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error: $e'),
              ),
            );
          }
        },
        child: const Icon(Icons.refresh),
        tooltip: 'Fetch from Stack Exchange',
      ),
      body: BlocBuilder<QuestionBloc, QuestionState>(
        bloc: sl<QuestionBloc>(),
        builder: (context, state) {
          if (state.getQuestionInfoById.requestStatus == RequestStatusBloc.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.getQuestionInfoById.requestStatus == RequestStatusBloc.error) {
            return Center(
              child: ErrorCard(
                message: "Connection Failed",
                onRetry: () {
                  sl<QuestionBloc>().add(
                    GetQuestionByIdEvent(id: widget.questionId),
                  );
                },
              ),
            );
          }

          final question = state.question;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  question.title,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 16),
                
                // Tags
                Wrap(
                  spacing: 8,
                  children: question.tags.map((tag) {
                    return Chip(label: Text(tag));
                  }).toList(),
                ),
                const SizedBox(height: 16),

                // Question Stats
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        StatItem(
                          icon: Icons.remove_red_eye,
                          value: question.viewCount.toString(),
                          label: 'Views',
                        ),
                        StatItem(
                          icon: Icons.question_answer,
                          value: question.answerCount.toString(),
                          label: 'Answers',
                        ),
                        StatItem(
                          icon: Icons.score,
                          value: question.score.toString(),
                          label: 'Score',
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Question Body
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(question.body),
                  ),
                ),
                const SizedBox(height: 16),

                // Owner Info
                OwnerInfoCard(owner: question.owner),
                const SizedBox(height: 16),

                // Additional Info
                Card(
                  child: SizedBox(
                    width: double.infinity,
                    height: 100.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 15.w),
                          child: Text(
                            'Posted on: ${StaticMethode.formatDate(question.creationDate)}',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextButton.icon(
                          onPressed: () async {
                            try {
                              await StaticMethode.launchUrlMethode(question.link);
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Could not open link'),
                                ),
                              );
                            }
                          },
                          icon: const Icon(Icons.link),
                          label: const Text('View on Stack Exchange'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
} 