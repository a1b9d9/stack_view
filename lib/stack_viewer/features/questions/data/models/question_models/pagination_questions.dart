
import 'package:stack_viewer/stack_viewer/features/questions/data/models/question_models/question.dart';

import '../../../../../../core/public_featuer/data/model/paginattion_model.dart';
import '../../../../../../core/public_featuer/domen/entity/pagination.dart';
import '../../../domain/entities/question_entities/pagination_questions.dart';

class PaginatedQuestionsModel extends PaginatedQuestionsEntity {
  const PaginatedQuestionsModel({
    required super.questions,
    required super.hasMore,
    required super.paginationInfo,

  });

  factory PaginatedQuestionsModel.fromJson(Map<String, dynamic> json,Pagination paginationInfo) {
    return PaginatedQuestionsModel(
      questions: (json['items'] as List<dynamic>)
          .map((e) => QuestionModel.fromJson(e))
          .toList(),
      hasMore: json['has_more'] ?? false,
      paginationInfo: PaginationModel.fromJson(json, paginationInfo) ,
    );
  }
}
