import 'package:dartz/dartz.dart';

import '../../../../../../../core/public_featuer/domen/usecase/base_usecase.dart';
import '../../../../../../../core/utils/exception/failures/failure.dart';

import '../../../repository/base_question_repositories.dart';


class GetCachedQuestionsCountUseCase extends BaseUseCase<
// return type
    int,
// object type
    NoParameters> {
  final BaseQuestionRepository baseQuestionRepository;

  GetCachedQuestionsCountUseCase(this.baseQuestionRepository);

  @override
  Future<Either<Failure, int>> call(NoParameters parameters) async {
    return await baseQuestionRepository.getCachedQuestionsCount();
  }
}
