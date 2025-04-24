
import '../../../../../../core/network/api_constance.dart';
import '../../../../../../core/network/dio_helper.dart';
import '../../../../../../core/network/server_error_message_model.dart';
import '../../../../../../core/public_featuer/data/model/paginattion_model.dart';
import '../../../../../../core/public_featuer/domen/entity/pagination.dart';
import '../../../../../../core/services/services_locator.dart';
import '../../../../../../core/utils/exception/exceptions/server_exception.dart';
import '../../../domain/entities/question_entities/question.dart';
import '../../models/question_models/pagination_questions.dart';
import 'package:dio/dio.dart';

import '../../models/question_models/question.dart';



abstract class BaseQuestionRemoteDataSource {
  Future<PaginatedQuestionsModel> getQuestions({
    required Pagination paginationInfo ,
  });

  Future<QuestionEntity> getQuestionById({
    required int id ,
  });
}

class QuestionRemoteDataSource extends BaseQuestionRemoteDataSource {

  @override
  Future<PaginatedQuestionsModel> getQuestions({
    required Pagination paginationInfo,
  }) async
  {
    try {
      final DioHelper dioHelper = sl<DioHelper>();
      Map<String, dynamic> paginationQ= PaginationModel.createQueryPagination(pagination: paginationInfo);

      final response = await dioHelper.getData(
        url: ApiConstance.getQuestions,
        query: paginationQ,
      );

      if (response.statusCode == 200) {
        return PaginatedQuestionsModel.fromJson(
          response.data,
          paginationInfo,
        );
      } else {
        throw ServerException(
          errorMessageModel: ServerErrorMessageModel.fromJson(response.data),
        );
      }
    } on DioException catch (e) {

      if (e.type == DioExceptionType.badResponse) {
        throw ServerException(
          errorMessageModel: ServerErrorMessageModel.fromJson(e.response!.data),
        );
      } else {

        throw ServerException(
          errorMessageModel: ServerErrorMessageModel(
            messageError: "Error",
            statusCode: e.response?.statusCode ?? -1,
          ),
        );
      }
    }


    // error for any thing
    catch (e) {
      throw ServerException(
        errorMessageModel: ServerErrorMessageModel(
          messageError: e.toString(),
          statusCode: 0,
        ),
      );
    }
  }

  @override
  Future<QuestionModel> getQuestionById({required int id}) async
  {
    try {
      final DioHelper dioHelper = sl<DioHelper>();
      Map<String, dynamic> paginationQ= QuestionModel.createQueryGetId();

      final response = await dioHelper.getData(
        url: '${ApiConstance.getQuestions}/${id.toString()}',
        query: paginationQ,
      );

      if (response.statusCode == 200) {

        return QuestionModel.fromJsonGetBuId(
          response.data,);
      } else {
        throw ServerException(
          errorMessageModel: ServerErrorMessageModel.fromJson(response.data),
        );
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        throw ServerException(
          errorMessageModel: ServerErrorMessageModel.fromJson(e.response!.data),
        );
      } else {
        throw ServerException(
          errorMessageModel: ServerErrorMessageModel(
            messageError: "Error",
            statusCode: e.response?.statusCode ?? -1,
          ),
        );
      }
    }

    // error for any thing
    catch (e) {
      throw ServerException(
        errorMessageModel: ServerErrorMessageModel(
          messageError: e.toString(),
          statusCode: 0,
        ),
      );
    }
  }
}