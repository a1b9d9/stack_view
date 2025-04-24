import 'dart:async';
import 'package:dio/dio.dart';

class ErrorMessage {
  static String getDioExceptionMessage({required DioException errorObject}) {
    switch (errorObject.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timeout with the server';
      case DioExceptionType.sendTimeout:
        return 'Send timeout in connection with the server';
      case DioExceptionType.receiveTimeout:
        return 'Receive timeout in connection with the server';
      case DioExceptionType.badResponse:
        return 'Received invalid status code: ${errorObject.response?.statusCode}';
      case DioExceptionType.cancel:
        return 'Request to the server was cancelled';
      case DioExceptionType.unknown:
        return 'Connection to the server failed due to internet connection';
      default:
        return 'An unexpected Dio error occurred ${errorObject.message}';
    }
  }

  static String getGeneralMessage({required dynamic errorObject}) {
    if (errorObject is FormatException) {
      return 'Data format error: ${errorObject.message}';
    } else if (errorObject is TimeoutException) {
      return 'Request timed out: ${errorObject.message}';
    } else {
      return 'An unexpected Dio error occurred : ${errorObject.message}';
    }
  }
}
