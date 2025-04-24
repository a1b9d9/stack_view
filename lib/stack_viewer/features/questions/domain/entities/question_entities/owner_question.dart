import 'package:equatable/equatable.dart';

class OwnerEntity extends Equatable {
  final String name;
  final String avatarUrl;
  final String profileLink;

  const OwnerEntity({
    required this.name,
    required this.avatarUrl,
    required this.profileLink,
  });

  OwnerEntity copyWith({
    String? name,
    String? avatarUrl,
    String? profileLink,
  }) {
    return OwnerEntity(
      name: name ?? this.name,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      profileLink: profileLink ?? this.profileLink,
    );
  }

  factory OwnerEntity.fromModel(OwnerEntity model) {
    return OwnerEntity(
      name: model.name,
      avatarUrl: model.avatarUrl,
      profileLink: model.profileLink,
    );
  }

  @override
  List<Object> get props => [name, avatarUrl, profileLink];
}
