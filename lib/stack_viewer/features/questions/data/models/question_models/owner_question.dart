import '../../../domain/entities/question_entities/owner_question.dart';

class OwnerModel extends OwnerEntity {
  const OwnerModel({
    required super.name,
    required super.avatarUrl,
    required super.profileLink,
  });

  factory OwnerModel.fromJson(Map<String, dynamic> json) {
    return OwnerModel(
      name: json['display_name'] ?? '',
      avatarUrl: json['profile_image'] ?? '',
      profileLink: json['link'] ?? '',
    );
  }
}
