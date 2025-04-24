import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/local/sql_flite/database_helper.dart';
import 'core/network/api_constance.dart';
import 'core/network/dio_helper.dart';
import 'core/services/services_locator.dart';
import 'main/main_app.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  ServicesLocator().init();
  sl<DioHelper>().init(baseUrl: ApiConstance.baseURL);
  sl<DatabaseHelper>().database;
  // Bloc.observer = MyBlocObserver();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(
        EasyLocalization(
            supportedLocales: [Locale('en'), Locale('ar')],
            path: 'assets/translations', // <-- change the path of the translation files
            fallbackLocale: Locale('en'),
            child: MyApp()
        ),);

  });
}
