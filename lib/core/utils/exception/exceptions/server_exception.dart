import '../../../network/server_error_message_model.dart';

class ServerException implements Exception {
  final ServerErrorMessageModel errorMessageModel;

  const ServerException({required this.errorMessageModel});
}

