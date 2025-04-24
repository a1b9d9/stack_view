
import '../../../../../../core/local/sql_flite/databace_colums_name.dart';
import '../../../domain/entities/question_entities/question.dart';
import 'owner_question.dart';

class QuestionModel extends QuestionEntity {
  const QuestionModel({
    required super.id,
    required super.title,
    required super.body,
    required super.tags,
    required super.isAnswered,
    required super.viewCount,
    required super.answerCount,
    required super.score,
    required super.creationDate,
    required super.link,
    required super.owner,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['question_id'] ?? 0,
      title: json['title'] ?? '',
      body: json['body'] ?? '',
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      isAnswered: json['is_answered'] ?? false,
      viewCount: json['view_count'] ?? 0,
      answerCount: json['answer_count'] ?? 0,
      score: json['score'] ?? 0,
      creationDate: json['creation_date'] != null
          ? DateTime.fromMillisecondsSinceEpoch((json['creation_date'] as int) * 1000)
          : DateTime(1970, 1, 1),
      link: json['link'] ?? '',
      owner: json['owner'] != null
          ? OwnerModel.fromJson(json['owner'])
          : const OwnerModel(name: "", avatarUrl: "", profileLink: ""), // Assuming you have this
    );
  }


  factory QuestionModel.fromJsonGetBuId(Map<String, dynamic> json) {

    json  = json['items'][0];
    return QuestionModel(
      id: json['question_id'] ?? 0,
      title: json['title'] ?? '',
      body: json['body'] ?? '',
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      isAnswered: json['is_answered'] ?? false,
      viewCount: json['view_count'] ?? 0,
      answerCount: json['answer_count'] ?? 0,
      score: json['score'] ?? 0,
      creationDate: json['creation_date'] != null
          ? DateTime.fromMillisecondsSinceEpoch((json['creation_date'] as int) * 1000)
          : DateTime(1970, 1, 1),
      link: json['link'] ?? '',
      owner: json['owner'] != null
          ? OwnerModel.fromJson(json['owner'])
          : const OwnerModel(name: "", avatarUrl: "", profileLink: ""), // Assuming you have this
    );
  }


  static Map<String, dynamic> createQueryGetId() {


    return {
      'filter':'withbody',
      'order': 'asc',
      'sort': 'activity',
      'site': 'stackoverflow',
    };
  }

  // ✅ To save to SQLite
  static Map<String, dynamic> toMapFromEntity(QuestionEntity entity) {
    return {
      DatabaseColumnName.questionId: entity.id,
      DatabaseColumnName.questionTitle: entity.title,
      DatabaseColumnName.questionBody: entity.body,
      DatabaseColumnName.questionTags: entity.tags.join(','), // Convert list to string
      DatabaseColumnName.questionIsAnswered: entity.isAnswered ? 1 : 0,
      DatabaseColumnName.questionViewCount: entity.viewCount,
      DatabaseColumnName.questionAnswerCount: entity.answerCount,
      DatabaseColumnName.questionScore: entity.score,
      DatabaseColumnName.questionCreationDate:
      entity.creationDate.millisecondsSinceEpoch,
      DatabaseColumnName.questionLink: entity.link,
      DatabaseColumnName.ownerName: entity.owner.name,
      DatabaseColumnName.ownerAvatar: entity.owner.avatarUrl,
      DatabaseColumnName.ownerProfile: entity.owner.profileLink,
    };
  }

  // ✅ From SQLite map
  factory QuestionModel.fromMap(Map<String, dynamic> map) {
    return QuestionModel(
      id: map[DatabaseColumnName.questionId],
      title: map[DatabaseColumnName.questionTitle],
      body: map[DatabaseColumnName.questionBody],
      tags: (map[DatabaseColumnName.questionTags] as String).split(','),
      isAnswered: map[DatabaseColumnName.questionIsAnswered] == 1,
      viewCount: map[DatabaseColumnName.questionViewCount],
      answerCount: map[DatabaseColumnName.questionAnswerCount],
      score: map[DatabaseColumnName.questionScore],
      creationDate: DateTime.fromMillisecondsSinceEpoch(map[DatabaseColumnName.questionCreationDate]),
      link: map[DatabaseColumnName.questionLink],
      owner: OwnerModel(
        name: map[DatabaseColumnName.ownerName],
        avatarUrl: map[DatabaseColumnName.ownerAvatar],
        profileLink: map[DatabaseColumnName.ownerProfile],
      ),
    );
  }



}
