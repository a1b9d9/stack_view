import 'package:dartz/dartz.dart';

import '../../../../../../../core/public_featuer/domen/entity/pagination.dart';
import '../../../../../../../core/public_featuer/domen/usecase/base_usecase.dart';
import '../../../../../../../core/utils/exception/failures/failure.dart';
import '../../../entities/question_entities/pagination_questions.dart';
import '../../../entities/question_entities/question.dart';
import '../../../repository/base_question_repositories.dart';


class GetQuestionByIdUseCase extends BaseUseCase<
// return type
    QuestionEntity,
// object type
    int> {
  final BaseQuestionRepository baseQuestionRepository;

  GetQuestionByIdUseCase(this.baseQuestionRepository);

  @override
  Future<Either<Failure, QuestionEntity>> call(int parameters) async {
    return await baseQuestionRepository.getQuestionById(
      id: parameters,
    );
  }
}
