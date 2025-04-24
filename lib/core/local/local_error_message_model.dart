import 'package:equatable/equatable.dart';

class LocalErrorMessageModel extends Equatable {
  final int statusCode;
  final String messageError;

  const LocalErrorMessageModel({
    required this.statusCode,
    required this.messageError,
  });

  factory LocalErrorMessageModel.fromJson(Map<String, dynamic> json) {
    return LocalErrorMessageModel(
      messageError: json["error"] ?? "",
      statusCode: json["statusCode"] ?? "",
    );
  }

  @override
  List<Object> get props => [statusCode, messageError,];
}
