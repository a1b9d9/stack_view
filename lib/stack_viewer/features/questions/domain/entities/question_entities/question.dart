import 'package:equatable/equatable.dart';

import 'owner_question.dart';

class QuestionEntity extends Equatable {
  final int id;
  final String title;
  final String body;
  final List<String> tags;
  final bool isAnswered;
  final int viewCount;
  final int answerCount;
  final int score;
  final DateTime creationDate;
  final String link;
  final OwnerEntity owner;

  const QuestionEntity({
    required this.id,
    required this.title,
    required this.body,
    required this.tags,
    required this.isAnswered,
    required this.viewCount,
    required this.answerCount,
    required this.score,
    required this.creationDate,
    required this.link,
    required this.owner,
  });


  QuestionEntity copyWith({
    int? id,
    String? title,
    String? body,
    List<String>? tags,
    bool? isAnswered,
    int? viewCount,
    int? answerCount,
    int? score,
    DateTime? creationDate,
    String? link,
    OwnerEntity? owner,
  }) {
    return QuestionEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      tags: tags ?? this.tags,
      isAnswered: isAnswered ?? this.isAnswered,
      viewCount: viewCount ?? this.viewCount,
      answerCount: answerCount ?? this.answerCount,
      score: score ?? this.score,
      creationDate: creationDate ?? this.creationDate,
      link: link ?? this.link,
      owner: owner ?? this.owner,
    );
  }

  factory QuestionEntity.fromModel(QuestionEntity model) {
    return QuestionEntity(
      id: model.id,
      title: model.title,
      body: model.body,
      tags: model.tags,
      isAnswered: model.isAnswered,
      viewCount: model.viewCount,
      answerCount: model.answerCount,
      score: model.score,
      creationDate: model.creationDate,
      link: model.link,
      owner: model.owner,
    );
  }

  @override
  List<Object> get props => [
    id,
    title,
    body,
    tags,
    isAnswered,
    viewCount,
    answerCount,
    score,
    creationDate,
    link,
    owner,
  ];
}
