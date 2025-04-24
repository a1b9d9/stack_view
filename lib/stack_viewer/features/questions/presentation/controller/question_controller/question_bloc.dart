import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stack_viewer/core/public_featuer/domen/entity/pagination.dart';
import 'package:stack_viewer/stack_viewer/features/questions/domain/entities/question_entities/question.dart';

import '../../../../../../core/public_featuer/domen/entity/info_bloc_status.dart';
import '../../../../../../core/public_featuer/domen/usecase/base_usecase.dart';
import '../../../../../../core/utils/enums/request_status_bloc.dart';
import '../../../domain/entities/question_entities/owner_question.dart';
import '../../../domain/entities/question_entities/pagination_questions.dart';
import '../../../domain/usecases/usecases/questions_repository_usecases/get_cached_questions_count_uscase.dart';
import '../../../domain/usecases/usecases/questions_repository_usecases/get_cached_questions_uscase.dart';
import '../../../domain/usecases/usecases/questions_repository_usecases/get_question_by_id.dart';
import '../../../domain/usecases/usecases/questions_repository_usecases/get_questions_usecase.dart';
import '../../../domain/usecases/usecases/questions_repository_usecases/clear_cached_questions_usecase.dart';
import '../../../domain/usecases/usecases/questions_repository_usecases/insert_cached_questions_usecase.dart';

part 'question_event.dart';

part 'question_state.dart';

class QuestionBloc extends Bloc<QuestionEvent, QuestionState> {
  static QuestionBloc get(context) => BlocProvider.of(context);

  final GetQuestionsUseCase getQuestionUseCase;
  final GetQuestionByIdUseCase getQuestionByIdUseCase;
  final ClearCachedQuestionsUseCase clearCachedQuestionsUseCase;
  final GetCachedQuestionsUseCase getCachedQuestionsUseCase;
  final GetCachedQuestionsCountUseCase getCachedQuestionsCountUseCase;
  final InsertCachedQuestionsUseCase insertCachedQuestionsUseCase;

  QuestionBloc(
    this.getQuestionUseCase,
    this.getQuestionByIdUseCase,
    this.clearCachedQuestionsUseCase,
    this.getCachedQuestionsUseCase,
    this.getCachedQuestionsCountUseCase,
    this.insertCachedQuestionsUseCase,
  ) : super(QuestionState()) {
    on<GetQuestionsEvent>(_getQuestionsEvent);
    on<GetQuestionByIdEvent>(_getQuestionByIdEvent);
    on<ClearCachedQuestionsEvent>(_clearCachedQuestionsEvent);
    on<GetCachedQuestionsEvent>(_getCachedQuestionsEvent);
    on<GetCachedQuestionsCountEvent>(_getCachedQuestionsCountEvent);
    on<InsertCachedQuestionsEvent>(_insertCachedQuestionsEvent);
  }

  FutureOr<void> _getQuestionsEvent(
      GetQuestionsEvent event, Emitter<QuestionState> emit) async {
    emit(state.copyWith(
      getQuestionsInfo: InfoBlocStatus(
        requestStatus: RequestStatusBloc.loading,
        message: "",
      ),
      listOfQuestions: event.pagination.currentPage == 0
          ? PaginatedQuestionsEntity(
              questions: [],
              hasMore: false,
              paginationInfo: Pagination(currentPage: 0, perPage: 0),
            )
          : state.listOfQuestions,
    ));

    final pagination = event.pagination.currentPage == 0
        ? event.pagination.copyWith(currentPage: 1)
        : event.pagination;

    final result = await getQuestionUseCase(pagination);

    result.fold(
      (failure) {
        emit(
          state.copyWith(
              getQuestionsInfo: InfoBlocStatus(
                requestStatus: RequestStatusBloc.error,
                message: failure.message,
              ),
              listOfQuestions: event.pagination.currentPage == 0
                  ? PaginatedQuestionsEntity(
                      questions: [],
                      hasMore: false,
                      paginationInfo: Pagination(total: 0, perPage: 0))
                  : state.listOfQuestions),
        );
      },
      (questions) {
        final PaginatedQuestionsEntity updatedQuestions;


        if (event.pagination.currentPage == 0) {
          // Reset list if currentPage was 0
          updatedQuestions = questions;
        } else {
          // Add new questions to existing list
          updatedQuestions = PaginatedQuestionsEntity(
            questions: [
              ...state.listOfQuestions.questions,
              ...questions.questions
            ],
            hasMore: questions.hasMore,
            paginationInfo: questions.paginationInfo,
          );
        }

        emit(
          state.copyWith(
            getQuestionsInfo: InfoBlocStatus(
              requestStatus: RequestStatusBloc.loaded,
            ),
            listOfQuestions: updatedQuestions,
          ),
        );
      },
    );
  }

  FutureOr<void> _getQuestionByIdEvent(
      GetQuestionByIdEvent event, Emitter<QuestionState> emit) async {
    emit(
      state.copyWith(
        getQuestionInfoById: InfoBlocStatus(
          requestStatus: RequestStatusBloc.loading,
        ),
      ),
    );

    final result = await getQuestionByIdUseCase(event.id);

    result.fold(
      (failure) => emit(
        state.copyWith(
          getQuestionInfoById: InfoBlocStatus(
            requestStatus: RequestStatusBloc.error,
            message: failure.message,
          ),
        ),
      ),
      (question) => emit(
        state.copyWith(
          getQuestionInfoById: InfoBlocStatus(
            requestStatus: RequestStatusBloc.loaded,
          ),
          question: question,
        ),
      ),
    );
  }

  FutureOr<void> _clearCachedQuestionsEvent(
      ClearCachedQuestionsEvent event, Emitter<QuestionState> emit) async {
    emit(state.copyWith(
      clearCacheStatus: InfoBlocStatus(
        requestStatus: RequestStatusBloc.loading,
      ),
    ));

    final result = await clearCachedQuestionsUseCase(NoParameters());
    result.fold(
      (failure) => emit(state.copyWith(
        clearCacheStatus: InfoBlocStatus(
          requestStatus: RequestStatusBloc.error,
          message: failure.message,
        ),
      )),
      (_) => emit(state.copyWith(
        clearCacheStatus: InfoBlocStatus(
          requestStatus: RequestStatusBloc.loaded,
        ),
        cachedQuestionsCount: 0,
        cachedQuestions: [],
      )),
    );
  }

  FutureOr<void> _getCachedQuestionsEvent(
      GetCachedQuestionsEvent event, Emitter<QuestionState> emit) async {
    emit(state.copyWith(
      getCachedQuestionsStatus: InfoBlocStatus(
        requestStatus: RequestStatusBloc.loading,
      ),
    ));

    final result = await getCachedQuestionsUseCase(event.pagination);
    result.fold(
      (failure) => emit(state.copyWith(
          getCachedQuestionsStatus: InfoBlocStatus(
            requestStatus: RequestStatusBloc.error,
            message: failure.message,
          ),
          listOfQuestions: PaginatedQuestionsEntity(
              paginationInfo: state.listOfQuestions.paginationInfo,
              hasMore: false,
              questions: state.listOfQuestions.questions))),
      (questions) {
        if (event.pagination.lastPage == 0) {
          emit(state.copyWith(
            getCachedQuestionsStatus: InfoBlocStatus(
              requestStatus: RequestStatusBloc.loaded,
            ),
            cachedQuestions: questions,
            listOfQuestions: PaginatedQuestionsEntity(
                hasMore: true,
                questions: questions,
                paginationInfo: event.pagination),
          ));
        } else {
          emit(state.copyWith(
            getCachedQuestionsStatus: InfoBlocStatus(
              requestStatus: RequestStatusBloc.loaded,
            ),
            listOfQuestions: PaginatedQuestionsEntity(
                hasMore: true,
                questions: [...state.cachedQuestions, ...questions],
                paginationInfo: event.pagination),
            cachedQuestions: [...state.cachedQuestions, ...questions],
          ));
        }
      },
    );
  }

  FutureOr<void> _getCachedQuestionsCountEvent(
      GetCachedQuestionsCountEvent event, Emitter<QuestionState> emit) async {
    emit(state.copyWith(
      getCachedCountStatus: InfoBlocStatus(
        requestStatus: RequestStatusBloc.loading,
      ),
    ));

    final result = await getCachedQuestionsCountUseCase(NoParameters());
    result.fold(
      (failure) => emit(state.copyWith(
        getCachedCountStatus: InfoBlocStatus(
          requestStatus: RequestStatusBloc.error,
          message: failure.message,
        ),
      )),
      (count) => emit(state.copyWith(
        getCachedCountStatus: InfoBlocStatus(
          requestStatus: RequestStatusBloc.loaded,
        ),
        cachedQuestionsCount: count,
      )),
    );
  }

  FutureOr<void> _insertCachedQuestionsEvent(
      InsertCachedQuestionsEvent event, Emitter<QuestionState> emit) async {
    emit(state.copyWith(
      insertCacheStatus: InfoBlocStatus(
        requestStatus: RequestStatusBloc.loading,
      ),
    ));

    final result = await insertCachedQuestionsUseCase(event.questions);
    result.fold(
      (failure) => emit(state.copyWith(
        insertCacheStatus: InfoBlocStatus(
          requestStatus: RequestStatusBloc.error,
          message: failure.message,
        ),
      )),
      (_) => emit(state.copyWith(
        insertCacheStatus: InfoBlocStatus(
          requestStatus: RequestStatusBloc.loaded,
        ),
        // Optionally update cached questions list and count
        cachedQuestions: [...state.cachedQuestions, ...event.questions],
        cachedQuestionsCount:
            state.cachedQuestionsCount + event.questions.length,
      )),
    );
  }

  Future<void> addTriggerAndAwait(
      {required dynamic event,
      required bool Function(QuestionState) checkStateAccept}) async {
    add(event);
    await for (final state in stream) {
      if (checkStateAccept(state)) {
        break;
      }
    }
  }
}
