import 'package:dartz/dartz.dart';
import 'package:stack_viewer/stack_viewer/features/questions/domain/entities/question_entities/question.dart';

import '../../../../../core/public_featuer/domen/entity/pagination.dart';
import '../../../../../core/utils/exception/failures/failure.dart';
import '../entities/question_entities/pagination_questions.dart';


abstract class BaseQuestionRepository {
  Future<Either<Failure, PaginatedQuestionsEntity>> getQuestions({
    required Pagination paginationInfo ,
  });
  Future<Either<Failure, QuestionEntity>> getQuestionById({
    required int id ,
  });

  Future<Either<Failure, void>> insertCachedQuestions({required List<QuestionEntity> questions}) ;

  Future<Either<Failure, void>> clearCachedQuestions();

  Future<Either<Failure,List<QuestionEntity>>> getCachedQuestions({
    required int offset,
    required int limit,
  });
  Future<Either<Failure,int>> getCachedQuestionsCount();


}
