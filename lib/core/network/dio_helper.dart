import 'package:dio/dio.dart';

class DioHelper {
  late Dio dio;

  DioHelper() {
    init();
  }

  void init({
    String token = "",
    String baseUrl = "",
  }) {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        headers: {"Content-Type": "application/json"},
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );
    dio.options.headers['Authorization'] = 'Bearer $token';

    //
    // dio.interceptors.add(LogInterceptor(
    //   request: true,
    //   requestBody: true,
    //   responseBody: true,
    //   responseHeader: false,
    //   error: true,
    //   logPrint: (object) => print('📦 $object'), // Optional custom log
    // ));

  }

  Future<Response> getData({
    required String url,
    String extensions = "",
    Map<String, dynamic>? query,
    String lang = "en",
    String token = "",
  }) async {

    final res = await dio.get(url + extensions, queryParameters: query);
    return res;
  }

  Future<Response> postData({
    required String url,
    String extensions = "",
    Map<String, dynamic>? query,
    Object? data,
    String lang = "en",
    String token = "",
    Options? options,
  }) async {
    return await dio.post(
      url + extensions,
      queryParameters: query,
      data: data,
      options: options,
    );
  }

  Future<Response> patchData({
    required String url,
    String extensions = "",
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
    String lang = "en",
    String token = "",
  }) async {
    var res = await dio.patch(
      url + extensions,
      queryParameters: query,
      data: data,
    );
    return res;
  }

  Future<Response> putData({
    required String url,
    String extensions = "",
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
    String lang = "en",
    String token = "",
  }) async {
    return await dio.put(
      url + extensions,
      queryParameters: query,
      data: data,
    );
  }

  Future<Response> deleteData({
    required String url,
    String extensions = "",
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
    String lang = "en",
    String token = "",
  }) async {
    return await dio.delete(
      url + extensions,
      queryParameters: query,
      data: data,
    );
  }

  Future<Response> downLoadData({
    required String url,
    required String pathSaved,
    String extensions = "",
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
    String lang = "en",
    String token = "",
  }) async {
    final res = await dio.download(
      url + extensions,
      pathSaved,
      queryParameters: query,
      data: data,
    );
    return res;
  }

 Future<Response> uploadFile({
  required String url,
  String extensions = "",
  Map<String, dynamic>? query,
  Object? data,
  String lang = "en",
  String token = "",
  Map<String, dynamic>? headers,
  required String localPath,
}) async {
  Options options = Options(
    headers: {
      "Content-Type": "multipart/form-data",
    },
  );

  FormData formData = FormData.fromMap({
    "file": await MultipartFile.fromFile(localPath),
  });

  return await dio.post(
    url + extensions,
    queryParameters: query,
    data: data ?? formData,
    options: options,
  );
}
}
