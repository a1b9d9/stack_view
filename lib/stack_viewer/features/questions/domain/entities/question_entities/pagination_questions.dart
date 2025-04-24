import 'package:equatable/equatable.dart';
import 'package:stack_viewer/stack_viewer/features/questions/domain/entities/question_entities/question.dart';

import '../../../../../../core/public_featuer/domen/entity/pagination.dart';

class PaginatedQuestionsEntity extends Equatable {
  final List<QuestionEntity> questions;
  final bool hasMore;
  final Pagination paginationInfo;

  const PaginatedQuestionsEntity({
    required this.questions,
    required this.hasMore,
    required this.paginationInfo,
  });

  PaginatedQuestionsEntity copyWith({
    List<QuestionEntity>? questions,
    bool? hasMore,
    Pagination? paginationInfo,
  }) {
    return PaginatedQuestionsEntity(
      questions: questions ?? this.questions,
      hasMore: hasMore ?? this.hasMore,
      paginationInfo: paginationInfo ?? this.paginationInfo,
    );
  }

  @override
  List<Object> get props => [questions, hasMore, paginationInfo];
}
