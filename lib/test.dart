import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stack_viewer/core/public_featuer/domen/entity/pagination.dart';
import 'package:stack_viewer/stack_viewer/features/questions/domain/entities/question_entities/owner_question.dart';
import 'package:stack_viewer/stack_viewer/features/questions/domain/entities/question_entities/question.dart';
import 'package:stack_viewer/stack_viewer/features/questions/presentation/controller/question_controller/question_bloc.dart';
import 'package:stack_viewer/core/services/services_locator.dart';
import 'package:stack_viewer/stack_viewer/features/questions/presentation/screens/question_screen/questions_list_screen_devices/main_question_list_screen.dart';

class TestBlocPage extends StatefulWidget {
  const TestBlocPage({super.key});

  @override
  State<TestBlocPage> createState() => _TestBlocPageState();
}

class _TestBlocPageState extends State<TestBlocPage> {
  late QuestionBloc questionBloc;

  @override
  void initState() {
    super.initState();
    questionBloc = sl<QuestionBloc>();
  }

  @override
  void dispose() {
    questionBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Question Bloc'),
        actions: [
          IconButton(
            icon: const Icon(Icons.design_services),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider.value(
                    value: questionBloc,
                    child: const QuestionsListScreen(),
                  ),
                ),
              );
            },
            tooltip: 'Open Design View',
          ),
        ],
      ),
      body: BlocProvider.value(
        value: questionBloc,
        child: BlocConsumer<QuestionBloc, QuestionState>(
          listener: (context, state) {
            // Print all state changes
            print('\n--- State Changed ---');
            
            // Questions Info
            print('Questions Info Status: ${state.getQuestionsInfo.requestStatus}');
            print('Questions Info Message: ${state.getQuestionsInfo.message}');
            print('Questions Count: ${state.listOfQuestions.questions.length}');
            print('Has More Questions: ${state.listOfQuestions.hasMore}');
            print('Pagination Info: ${state.listOfQuestions.paginationInfo}');
            
            // Question By ID
            print('Question By ID Status: ${state.getQuestionInfoById.requestStatus}');
            print('Question By ID Message: ${state.getQuestionInfoById.message}');
            print('Current Question ID: ${state.question.id}');
            print('Current Question Title: ${state.question.title}');
            
            // Cache Operations
            print('Clear Cache Status: ${state.clearCacheStatus.requestStatus}');
            print('Clear Cache Message: ${state.clearCacheStatus.message}');
            
            print('Insert Cache Status: ${state.insertCacheStatus.requestStatus}');
            print('Insert Cache Message: ${state.insertCacheStatus.message}');
            
            print('Get Cached Questions Status: ${state.getCachedQuestionsStatus.requestStatus}');
            print('Get Cached Questions Message: ${state.getCachedQuestionsStatus.message}');
            print('Cached Questions Length: ${state.cachedQuestions.length}');
            
            print('Get Cached Count Status: ${state.getCachedCountStatus.requestStatus}');
            print('Get Cached Count Message: ${state.getCachedCountStatus.message}');
            print('Cached Questions Count: ${state.cachedQuestionsCount}');
            
            print('-------------------\n');
          },
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider.value(
                            value: questionBloc,
                            child: const QuestionsListScreen(),
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.design_services),
                    label: const Text('Open Design View'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Divider(),
                  const SizedBox(height: 24),

                  // Get Questions
                  ElevatedButton(
                    onPressed: () {
                      questionBloc.add(
                        GetQuestionsEvent(
                          pagination: Pagination(
                            lastPage: 0,
                            perPage: 10, total: 20,
                            currentPage: 3
                          ),
                        ),
                      );
                    },
                    child: const Text('Get Questions'),
                  ),
                  const SizedBox(height: 16),

                  // Get Question By ID
                  ElevatedButton(
                    onPressed: () {
                      questionBloc.add(
                        const GetQuestionByIdEvent(id: 79586803),
                      );
                    },
                    child: const Text('Get Question By ID (1)'),
                  ),
                  const SizedBox(height: 16),

                  // Clear Cached Questions
                  ElevatedButton(
                    onPressed: () {
                      questionBloc.add(
                        ClearCachedQuestionsEvent(),
                      );
                    },
                    child: const Text('Clear Cached Questions'),
                  ),
                  const SizedBox(height: 16),

                  // Get Cached Questions
                  ElevatedButton(
                    onPressed: () {
                      questionBloc.add(
                        GetCachedQuestionsEvent(
                          pagination: Pagination(
                            lastPage: 0,
                            perPage: 10,
                          ),
                        ),
                      );
                    },
                    child: const Text('Get Cached Questions'),
                  ),
                  const SizedBox(height: 16),

                  // Get Cached Questions Count
                  ElevatedButton(
                    onPressed: () {
                      questionBloc.add(
                        GetCachedQuestionsCountEvent(),
                      );
                    },
                    child: const Text('Get Cached Questions Count'),
                  ),
                  const SizedBox(height: 16),

                  // Insert Cached Questions
                  ElevatedButton(
                    onPressed: () {
                      // Create a sample question for testing
                      final sampleQuestion = QuestionEntity(
                        id: 1,
                        title: 'Test Question',
                        body: 'Test Body',
                        tags: ['test'],
                        isAnswered: false,
                        viewCount: 0,
                        answerCount: 0,
                        score: 0,
                        creationDate: DateTime.now(),
                        link: 'https://test.com',
                        owner: OwnerEntity(
                          name: 'Test User',
                          avatarUrl: 'https://test.com/avatar.png',
                          profileLink: 'https://test.com/user',
                        ),
                      );

                      questionBloc.add(
                        InsertCachedQuestionsEvent(
                          questions: [sampleQuestion],
                        ),
                      );
                    },
                    child: const Text('Insert Sample Cached Question'),
                  ),
                  const SizedBox(height: 32),

                  // Current State Display
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Get Questions Status
                          Text('Questions Status: ${state.getQuestionsInfo.requestStatus}'),
                          Text('Questions Error: ${state.getQuestionsInfo.message}'),
                          Text('Questions Count: ${state.listOfQuestions.questions.length}'),
                          Text('Has More Questions: ${state.listOfQuestions.hasMore}'),
                          Text('Pagination Info: ${state.listOfQuestions.paginationInfo.toString()}'),
                          
                          const Divider(),
                          
                          // Get Question By ID Status
                          Text('Question By ID Status: ${state.getQuestionInfoById.requestStatus}'),
                          Text('Question By ID Error: ${state.getQuestionInfoById.message}'),
                          Text('Current Question ID: ${state.question.id}'),
                          Text('Current Question Title: ${state.question.title}'),
                          
                          const Divider(),
                          
                          // Clear Cache Status
                          Text('Clear Cache Status: ${state.clearCacheStatus.requestStatus}'),
                          Text('Clear Cache Error: ${state.clearCacheStatus.message}'),
                          
                          const Divider(),
                          
                          // Insert Cache Status
                          Text('Insert Cache Status: ${state.insertCacheStatus.requestStatus}'),
                          Text('Insert Cache Error: ${state.insertCacheStatus.message}'),
                          
                          const Divider(),
                          
                          // Get Cached Questions Status
                          Text('Get Cached Questions Status: ${state.getCachedQuestionsStatus.requestStatus}'),
                          Text('Get Cached Questions Error: ${state.getCachedQuestionsStatus.message}'),
                          Text('Cached Questions Length: ${state.cachedQuestions.length}'),
                          
                          const Divider(),
                          
                          // Get Cached Count Status
                          Text('Get Cached Count Status: ${state.getCachedCountStatus.requestStatus}'),
                          Text('Get Cached Count Error: ${state.getCachedCountStatus.message}'),
                          Text('Cached Questions Count: ${state.cachedQuestionsCount}'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
