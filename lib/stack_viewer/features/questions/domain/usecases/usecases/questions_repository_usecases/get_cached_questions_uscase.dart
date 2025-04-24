import 'package:dartz/dartz.dart';
import 'package:stack_viewer/core/public_featuer/domen/entity/pagination.dart';
import 'package:stack_viewer/stack_viewer/features/questions/domain/entities/question_entities/question.dart';

import '../../../../../../../core/public_featuer/domen/usecase/base_usecase.dart';
import '../../../../../../../core/utils/exception/failures/failure.dart';

import '../../../repository/base_question_repositories.dart';

class GetCachedQuestionsUseCase extends BaseUseCase<
// return type
    List<QuestionEntity>,
// object type
    Pagination> {
  final BaseQuestionRepository baseQuestionRepository;

  GetCachedQuestionsUseCase(this.baseQuestionRepository);

  @override
  Future<Either<Failure, List<QuestionEntity>>> call(
      Pagination parameters) async {
    return await baseQuestionRepository.getCachedQuestions(
        offset: parameters.lastPage * parameters.perPage,
        limit: parameters.perPage);
  }
}
