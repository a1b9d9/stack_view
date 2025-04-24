import 'package:dartz/dartz.dart';

import '../../../../../../../core/public_featuer/domen/entity/pagination.dart';
import '../../../../../../../core/public_featuer/domen/usecase/base_usecase.dart';
import '../../../../../../../core/utils/exception/failures/failure.dart';
import '../../../entities/question_entities/pagination_questions.dart';
import '../../../repository/base_question_repositories.dart';


class GetQuestionsUseCase extends BaseUseCase<
// return type
    PaginatedQuestionsEntity,
// object type
    Pagination> {
  final BaseQuestionRepository baseQuestionRepository;

  GetQuestionsUseCase(this.baseQuestionRepository);

  @override
  Future<Either<Failure, PaginatedQuestionsEntity>> call(Pagination parameters) async {
    return await baseQuestionRepository.getQuestions(
      paginationInfo: parameters,
     );
  }
}
