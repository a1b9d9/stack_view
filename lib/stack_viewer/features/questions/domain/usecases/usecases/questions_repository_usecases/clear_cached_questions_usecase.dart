import 'package:dartz/dartz.dart';

 import '../../../../../../../core/public_featuer/domen/usecase/base_usecase.dart';
import '../../../../../../../core/utils/exception/failures/failure.dart';

import '../../../repository/base_question_repositories.dart';


class ClearCachedQuestionsUseCase extends BaseUseCase<
// return type
    void,
// object type
    NoParameters> {
  final BaseQuestionRepository baseQuestionRepository;

  ClearCachedQuestionsUseCase(this.baseQuestionRepository);

  @override
  Future<Either<Failure, void>> call(NoParameters parameters) async {
    return await baseQuestionRepository.clearCachedQuestions();
  }
}
