import 'databace_colums_name.dart';
import 'database_tables_name.dart';

class DatabaseStructureTables {
  // SQL to create the users table
  static const String createTokensTable = '''
    CREATE TABLE ${DatabaseTablesName.token}(
      ${DatabaseColumnName.idToken} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${DatabaseColumnName.token} TEXT,
      ${DatabaseColumnName.notificationToken} TEXT,
      ${DatabaseColumnName.refreshToken} TEXT
    )
  ''';


  // ✅ SQL to create the questions table
  static const String createQuestionsTable = '''
  CREATE TABLE ${DatabaseTablesName.questions}(
    ${DatabaseColumnName.questionId} INTEGER PRIMARY KEY,
    ${DatabaseColumnName.questionTitle} TEXT,
    ${DatabaseColumnName.questionBody} TEXT,
    ${DatabaseColumnName.questionTags} TEXT,
    ${DatabaseColumnName.questionIsAnswered} INTEGER,
    ${DatabaseColumnName.questionViewCount} INTEGER,
    ${DatabaseColumnName.questionAnswerCount} INTEGER,
    ${DatabaseColumnName.questionScore} INTEGER,
    ${DatabaseColumnName.questionCreationDate} INTEGER,
    ${DatabaseColumnName.questionLink} TEXT,
    ${DatabaseColumnName.ownerName} TEXT,
    ${DatabaseColumnName.ownerAvatar} TEXT,
    ${DatabaseColumnName.ownerProfile} TEXT
  )
''';



  // Method to get all table creation SQL strings
  static List<String> get createAllTables => [
        createTokensTable,
    createQuestionsTable,
        // Add other table creation strings here
      ];
}
