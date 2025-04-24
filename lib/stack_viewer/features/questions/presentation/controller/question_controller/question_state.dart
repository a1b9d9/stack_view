part of 'question_bloc.dart';

class QuestionState extends Equatable {
  final InfoBlocStatus getQuestionsInfo;
  final PaginatedQuestionsEntity listOfQuestions;
  final InfoBlocStatus getQuestionInfoById;
///
  final QuestionEntity question;
  final InfoBlocStatus cachingQuestionsInfo;
  ///
  final int cachedQuestionsCount;
  ///
  final List<QuestionEntity> cachedQuestions;

  // Cache-related status
  final InfoBlocStatus clearCacheStatus;
  final InfoBlocStatus insertCacheStatus;
  final InfoBlocStatus getCachedQuestionsStatus;
  final InfoBlocStatus getCachedCountStatus;

   QuestionState({
    this.getQuestionsInfo = const InfoBlocStatus(),
    this.listOfQuestions = const PaginatedQuestionsEntity(questions: [], hasMore: false, paginationInfo: Pagination(total: 0, perPage: 0)),
    this.getQuestionInfoById = const InfoBlocStatus(),
    QuestionEntity? question,
    this.cachingQuestionsInfo = const InfoBlocStatus(),
    this.cachedQuestionsCount = 0,
    this.cachedQuestions = const [],
    // Initialize cache-related status
    this.clearCacheStatus = const InfoBlocStatus(),
    this.insertCacheStatus = const InfoBlocStatus(),
    this.getCachedQuestionsStatus = const InfoBlocStatus(),
    this.getCachedCountStatus = const InfoBlocStatus(),
  }) : question = question ?? QuestionEntity(
    id: 0,
    title: '',
    body: '',
    tags: [],
    isAnswered: false,
    viewCount: 0,
    answerCount: 0,
    score: 0,
    creationDate: DateTime(1970, 1, 1), // ✅ Fine here
    link: '',
    owner: OwnerEntity(name: "", avatarUrl: "", profileLink: ""),
  );

  QuestionState copyWith({
    InfoBlocStatus? getQuestionsInfo,
    PaginatedQuestionsEntity? listOfQuestions,
    InfoBlocStatus? getQuestionInfoById,
    QuestionEntity? question,
    InfoBlocStatus? cachingQuestionsInfo,
    int? cachedQuestionsCount,
    List<QuestionEntity>? cachedQuestions,
    // Add cache-related status parameters
    InfoBlocStatus? clearCacheStatus,
    InfoBlocStatus? insertCacheStatus,
    InfoBlocStatus? getCachedQuestionsStatus,
    InfoBlocStatus? getCachedCountStatus,
  }) {
    return QuestionState(
      getQuestionsInfo: getQuestionsInfo ?? this.getQuestionsInfo,
      listOfQuestions: listOfQuestions ?? this.listOfQuestions,
      getQuestionInfoById: getQuestionInfoById ?? this.getQuestionInfoById,
      question: question ?? this.question,
      cachingQuestionsInfo: cachingQuestionsInfo ?? this.cachingQuestionsInfo,
      cachedQuestionsCount: cachedQuestionsCount ?? this.cachedQuestionsCount,
      cachedQuestions: cachedQuestions ?? this.cachedQuestions,
      // Include cache-related status in copyWith
      clearCacheStatus: clearCacheStatus ?? this.clearCacheStatus,
      insertCacheStatus: insertCacheStatus ?? this.insertCacheStatus,
      getCachedQuestionsStatus: getCachedQuestionsStatus ?? this.getCachedQuestionsStatus,
      getCachedCountStatus: getCachedCountStatus ?? this.getCachedCountStatus,
    );
  }

  @override
  List<Object> get props => [
    getQuestionsInfo,
    listOfQuestions,
    getQuestionInfoById,
    question,
    cachingQuestionsInfo,
    cachedQuestionsCount,
    cachedQuestions,
    clearCacheStatus,
    insertCacheStatus,
    getCachedQuestionsStatus,
    getCachedCountStatus,
  ];
}
