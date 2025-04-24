import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/public_featuer/domen/entity/pagination.dart';
import '../../../../../../../core/services/services_locator.dart';
import '../../../../../../../core/utils/enums/request_status_bloc.dart';
import '../../../controller/question_controller/question_bloc.dart';
import '../../../widgets/error_card.dart';
import '../../../widgets/question_card.dart';
import '../question_detail_screen_devices/main_question_detail_screen.dart';

class QuestionsListScreenMobilePortraitScreen extends StatefulWidget {
  const QuestionsListScreenMobilePortraitScreen({super.key});

  @override
  QuestionsListScreenMobilePortraitScreenState createState() =>
      QuestionsListScreenMobilePortraitScreenState();
}

class QuestionsListScreenMobilePortraitScreenState
    extends State<QuestionsListScreenMobilePortraitScreen> {
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 0;
  bool _isOffline = false;
  static const int _perPage = 10;

  @override
  void initState() {
    super.initState();
    _setupScrollListener();
    //here i change the value from 0 to 1 to avoid the double refresh when the app start
    _currentPage =1;
  }

  void _loadInitialQuestions() {
    sl<QuestionBloc>().add(
      GetQuestionsEvent(
        pagination: Pagination(
          //first initial start with 0
          currentPage: 0,
          perPage: _perPage,
        ),
      ),
    );

    _currentPage+=2;
  }

  void _setupScrollListener() {
    _scrollController.addListener(() {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;
      final delta = MediaQuery.of(context).size.height * 0.2; // 20% of screen height

      if (maxScroll - currentScroll <= delta) {
        _loadMoreQuestions();
      }
    });
  }

  void _loadMoreQuestions() {
    var state = sl<QuestionBloc>().state;
    if (
        state.listOfQuestions.hasMore &&
        state.getQuestionsInfo.requestStatus == RequestStatusBloc.loaded) {
      sl<QuestionBloc>().add(InsertCachedQuestionsEvent(questions: state.listOfQuestions.questions.sublist(state.listOfQuestions.questions.length - 10)));

      //to avoid duplicate data in the first time
        _currentPage == 1 ? _currentPage++: _currentPage;
        sl<QuestionBloc>().add(
        GetQuestionsEvent(
          pagination: Pagination(
            currentPage: _currentPage,
            perPage: _perPage,
            total: state.listOfQuestions.paginationInfo.total,
          ),
        ),
      );
    }

    if(_isOffline){
      sl<QuestionBloc>().add(
        GetCachedQuestionsEvent(
          pagination: Pagination(
            perPage: _perPage,
            lastPage: _currentPage==0
                  ? 0
                  :_currentPage-1,
          ),
        ),
      );
    }
    _currentPage++;


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stack Exchange Questions'),
        elevation: 0,
      ),
      body: BlocConsumer<QuestionBloc, QuestionState>(
        bloc: sl<QuestionBloc>(),


        listener: (context, state) {
          // Handle offline mode
          if (state.listOfQuestions.questions.isEmpty &&
              state.getQuestionsInfo.requestStatus == RequestStatusBloc.error) {
            //here when became true the listener will be off
            _isOffline = true;
            //for one time call and first request just ..
            sl<QuestionBloc>().add(
              GetCachedQuestionsEvent(
                pagination: Pagination(
                  perPage: _perPage,
                  lastPage: 0,
                ),
              ),
            );
          }


          if(state.listOfQuestions.questions.length<=_perPage &&
              state.getQuestionsInfo.requestStatus == RequestStatusBloc.loaded) {
            sl<QuestionBloc>().add(ClearCachedQuestionsEvent());
          }

        },
        listenWhen: (previous, current) => !_isOffline,
        builder: (context, state) {
          if (
          (state.getQuestionsInfo.requestStatus == RequestStatusBloc.loading||
              state.getCachedQuestionsStatus.requestStatus == RequestStatusBloc.loading) &&
              state.listOfQuestions.questions.isEmpty)
          {
            return const Center(child: CircularProgressIndicator());
          }

          if ((state.getQuestionsInfo.requestStatus == RequestStatusBloc.error||
              state.getCachedQuestionsStatus.requestStatus == RequestStatusBloc.error) &&
              state.listOfQuestions.questions.isEmpty) {
            return Center(
              child: ErrorCard(
                message: "Connection Failed",
                onRetry: () {
                  _loadInitialQuestions();
                },
              ),
            );
          }


          return RefreshIndicator(
            onRefresh: () async {
                _currentPage = 0;
                _isOffline = false;
              _loadInitialQuestions();
            },


            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),

              itemCount: state.listOfQuestions.questions.length +
                  (state.getQuestionsInfo.requestStatus == RequestStatusBloc.loading ||
                      state.getCachedQuestionsStatus.requestStatus == RequestStatusBloc.loading
                      ? 1
                      : 0),
              itemBuilder: (context, index) {
                if (index == state.listOfQuestions.questions.length) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                final question = state.listOfQuestions.questions[index];
                return QuestionCard(
                  question: question,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            MainQuestionDetailScreen(questionId: question.id),
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
