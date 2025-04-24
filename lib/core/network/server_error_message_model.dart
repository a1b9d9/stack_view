import 'package:equatable/equatable.dart';

class ServerErrorMessageModel extends Equatable {
  final int statusCode;
  final String messageError;

  const ServerErrorMessageModel({
    required this.statusCode,
    required this.messageError,
  });

  factory ServerErrorMessageModel.fromJson(Map<String, dynamic> json) {

    return ServerErrorMessageModel(
      messageError: json["error_message"] ?? "",
      statusCode: json["error_id"] ?? "",
    );
  }

  @override
  List<Object> get props => [statusCode, messageError,];
}
