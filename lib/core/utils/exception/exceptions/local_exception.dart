import '../../../local/local_error_message_model.dart';

class LocalException implements Exception {
  final LocalErrorMessageModel errorMessageModel;

  const LocalException({required this.errorMessageModel});
}
