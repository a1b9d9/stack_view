import 'package:dartz/dartz.dart';
import 'package:stack_viewer/core/public_featuer/domen/entity/pagination.dart';
import 'package:stack_viewer/stack_viewer/features/questions/domain/entities/question_entities/question.dart';

import '../../../../../../../core/public_featuer/domen/usecase/base_usecase.dart';
import '../../../../../../../core/utils/exception/failures/failure.dart';

import '../../../repository/base_question_repositories.dart';

class InsertCachedQuestionsUseCase extends BaseUseCase<
// return type
    void,
// object type
    List<QuestionEntity>> {
  final BaseQuestionRepository baseQuestionRepository;

  InsertCachedQuestionsUseCase(this.baseQuestionRepository);

  @override
  Future<Either<Failure, void>> call(
      List<QuestionEntity> parameters) async {
    return await baseQuestionRepository.insertCachedQuestions(
      questions: parameters
    );
  }
}
