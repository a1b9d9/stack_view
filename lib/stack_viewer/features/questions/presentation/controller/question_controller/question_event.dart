part of 'question_bloc.dart';

abstract class QuestionEvent extends Equatable {
  const QuestionEvent();

  @override
  List<Object> get props => [];
}

class GetQuestionsEvent extends QuestionEvent {
  final Pagination pagination;

  const GetQuestionsEvent({
    required this.pagination,
  });
}
class GetQuestionByIdEvent extends QuestionEvent {
  final int id;

  const GetQuestionByIdEvent({
    required this.id,
  });
}

class ClearCachedQuestionsEvent extends QuestionEvent {}

class GetCachedQuestionsEvent extends QuestionEvent {
  final Pagination pagination;
  const GetCachedQuestionsEvent({required this.pagination});
}

class GetCachedQuestionsCountEvent extends QuestionEvent {}

class InsertCachedQuestionsEvent extends QuestionEvent {
  final List<QuestionEntity> questions;
  const InsertCachedQuestionsEvent({required this.questions});
}
