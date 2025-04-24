import 'package:dartz/dartz.dart';
import 'package:stack_viewer/core/utils/exception/exceptions/local_exception.dart';
import 'package:stack_viewer/core/utils/exception/failures/local_failure.dart';
import 'package:stack_viewer/stack_viewer/features/questions/domain/entities/question_entities/question.dart';

import '../../../../../core/public_featuer/domen/entity/pagination.dart';
import '../../../../../core/utils/exception/exceptions/server_exception.dart';
import '../../../../../core/utils/exception/failures/failure.dart';
import '../../../../../core/utils/exception/failures/server_failure.dart';
import '../../../../../core/utils/exception/handle_error.dart';
import '../../domain/entities/question_entities/pagination_questions.dart';
import '../../domain/repository/base_question_repositories.dart';
import '../data_sourses/local_data_sours/question.dart';
import '../data_sourses/remote_data_sours/question.dart';

class QuestionRepository extends BaseQuestionRepository {
  final BaseQuestionRemoteDataSource baseQuestionRemoteDataSource;
  final BaseQuestionLocalDataSource baseQuestionLocalDataSource;

  QuestionRepository(this.baseQuestionRemoteDataSource,
      this.baseQuestionLocalDataSource,);

  @override
  Future<Either<Failure, PaginatedQuestionsEntity>> getQuestions({
    required Pagination paginationInfo,
  }) async 
  {
    try {
      final result = await baseQuestionRemoteDataSource.getQuestions(
          paginationInfo: paginationInfo);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(
        ServerFailure(
          failure.errorMessageModel.messageError,
          failure.errorMessageModel.statusCode,
        ),
      );
    } catch (e) {
      return Left(
          ServerFailure(ErrorMessage.getGeneralMessage(errorObject: e), 0));
    }
  }

  @override
  Future<Either<Failure, QuestionEntity>> getQuestionById(
      {required int id}) async
  {
    try {
      final result = await baseQuestionRemoteDataSource.getQuestionById(id: id);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(
        ServerFailure(
          failure.errorMessageModel.messageError,
          failure.errorMessageModel.statusCode,
        ),
      );
    } catch (e) {
      return Left(
          ServerFailure(ErrorMessage.getGeneralMessage(errorObject: e), 0));
    }
  }
  
  // ✅ Insert questions into local DB
  @override
  Future<Either<Failure, void>> insertCachedQuestions({
      required List<QuestionEntity> questions}) async 
  {
    try {
      final result = await baseQuestionLocalDataSource.insertCachedQuestions(questions);
      return Right(result);
    } on LocalException catch (failure) {
      return Left(
        LocalFailure(
          failure.errorMessageModel.messageError,
          failure.errorMessageModel.statusCode,
        ),
      );
    } catch (e) {
      return Left(
          LocalFailure(ErrorMessage.getGeneralMessage(errorObject: e), 0));
    }
  }

  // ✅ Clear all cached questions from local DB
  @override
  Future<Either<Failure, void>> clearCachedQuestions() async {
    try {
      final result =  await baseQuestionLocalDataSource.clearCachedQuestions();
      return Right(result);
    }

    on LocalException catch (failure) {
      return Left(
        LocalFailure(
          failure.errorMessageModel.messageError,
          failure.errorMessageModel.statusCode,
        ),
      );
    } catch (e) {
      return Left(
          LocalFailure(ErrorMessage.getGeneralMessage(errorObject: e), 0));
    }
  }

  @override
  Future<Either<Failure, List<QuestionEntity>>> getCachedQuestions(
      {required int offset, required int limit})  
  async {
    try {
      final result =  await baseQuestionLocalDataSource.getCachedQuestions(offset: offset, limit: limit);
      return Right(result);
    }

    on LocalException catch (failure) {
      return Left(
        LocalFailure(
          failure.errorMessageModel.messageError,
          failure.errorMessageModel.statusCode,
        ),
      );
    } catch (e) {
      return Left(
          LocalFailure(ErrorMessage.getGeneralMessage(errorObject: e), 0));
    }
  }
  
  
  @override
  Future<Either<Failure, int>> getCachedQuestionsCount()   async {
    try {
      final result =  await baseQuestionLocalDataSource.getCachedQuestionsCount();
      return Right(result);
    }

    on LocalException catch (failure) {
      return Left(
        LocalFailure(
          failure.errorMessageModel.messageError,
          failure.errorMessageModel.statusCode,
        ),
      );
    } catch (e) {
      return Left(
          LocalFailure(ErrorMessage.getGeneralMessage(errorObject: e), 0));
    }
  }
  
  

}
