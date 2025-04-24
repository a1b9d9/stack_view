import 'package:get_it/get_it.dart';

import '../../stack_viewer/features/questions/data/data_sourses/local_data_sours/question.dart';
import '../../stack_viewer/features/questions/data/data_sourses/remote_data_sours/question.dart';
import '../../stack_viewer/features/questions/data/repository/questions_repository.dart';
import '../../stack_viewer/features/questions/domain/repository/base_question_repositories.dart';
import '../../stack_viewer/features/questions/domain/usecases/usecases/questions_repository_usecases/get_cached_questions_count_uscase.dart';
import '../../stack_viewer/features/questions/domain/usecases/usecases/questions_repository_usecases/get_cached_questions_uscase.dart';
import '../../stack_viewer/features/questions/domain/usecases/usecases/questions_repository_usecases/get_question_by_id.dart';
import '../../stack_viewer/features/questions/domain/usecases/usecases/questions_repository_usecases/get_questions_usecase.dart';
import '../../stack_viewer/features/questions/presentation/controller/question_controller/question_bloc.dart';
import '../local/sql_flite/database_helper.dart';
import '../network/dio_helper.dart';
import '../../stack_viewer/features/questions/domain/usecases/usecases/questions_repository_usecases/clear_cached_questions_usecase.dart';
import '../../stack_viewer/features/questions/domain/usecases/usecases/questions_repository_usecases/insert_cached_questions_usecase.dart';


final sl = GetIt.instance;

class ServicesLocator {
  void init() {
    /// Initialize DioHelper
    sl.registerLazySingleton<DioHelper>(() => DioHelper());
    // Call the init method of DioHelper to initialize Dio
    sl<DioHelper>().init();


  // Database
  sl.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());
  
  // If you need to initialize the database, you might want to do this:
    sl<DatabaseHelper>().database; // This triggers database initialization


    /// Cases
    sl.registerLazySingleton(() => GetQuestionsUseCase(sl()));
    sl.registerLazySingleton(() => GetQuestionByIdUseCase(sl()));
    sl.registerLazySingleton(() => ClearCachedQuestionsUseCase(sl()));
    sl.registerLazySingleton(() => GetCachedQuestionsUseCase(sl()));
    sl.registerLazySingleton(() => GetCachedQuestionsCountUseCase(sl()));
    sl.registerLazySingleton(() => InsertCachedQuestionsUseCase(sl()));

    /// Bloc
    sl.registerLazySingleton(() => QuestionBloc(
          sl(), // GetQuestionsUseCase
          sl(), // GetQuestionByIdUseCase
          sl(), // ClearCachedQuestionsUseCase
          sl(), // GetCachedQuestionsUseCase
          sl(), // GetCachedQuestionsCountUseCase
          sl(), // InsertCachedQuestionsUseCase
        ));


    /// Repositories
    sl.registerLazySingleton<BaseQuestionRepository>(() => QuestionRepository(
      sl(),
      sl(),
    ));


    /// DATA Remote SOURCE
    sl.registerLazySingleton<BaseQuestionRemoteDataSource>(
            () => QuestionRemoteDataSource());



    /// DATA Local SOURCE
    sl.registerLazySingleton<BaseQuestionLocalDataSource>(
            () => QuestionLocalDataSource());


  }
}
