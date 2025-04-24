
import '../../../../../../core/local/sql_flite/database_helper.dart';
import '../../../../../../core/local/sql_flite/database_tables_name.dart';
import '../../../../../../core/services/services_locator.dart';
import '../../../domain/entities/question_entities/question.dart';
import '../../models/question_models/question.dart';

abstract class BaseQuestionLocalDataSource {
  Future<void> clearCachedQuestions();
  Future<void> insertCachedQuestions(List<QuestionEntity> questions);
  Future<List<QuestionEntity>> getCachedQuestions({
    required int offset,
    required int limit,
  });
  Future<int> getCachedQuestionsCount();

}

class QuestionLocalDataSource extends BaseQuestionLocalDataSource {
  final DatabaseHelper dbHelper =sl<DatabaseHelper>();

  QuestionLocalDataSource();

  @override
  Future<void> clearCachedQuestions() async {
    await dbHelper.deleteAllData(DatabaseTablesName.questions);
  }

  @override
  Future<void> insertCachedQuestions(List<QuestionEntity> questions) async {
    final List<Map<String, dynamic>> questionMaps =
    questions.map((e) => QuestionModel.toMapFromEntity(e)).toList();

    await dbHelper.insertList(DatabaseTablesName.questions, questionMaps);
  }

  @override
  Future<List<QuestionEntity>> getCachedQuestions({
    required int offset,
    required int limit,
  }) async {
    final List<Map<String, dynamic>> rows = await dbHelper.query(
      DatabaseTablesName.questions,
      limit: limit,
      offset: offset,
    );

    return rows.map((row) => QuestionModel.fromMap(row)).toList();
  }

  @override
  Future<int> getCachedQuestionsCount() async {
    return await dbHelper.getCount(DatabaseTablesName.questions);
  }

}