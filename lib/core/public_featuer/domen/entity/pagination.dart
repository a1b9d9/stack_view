import 'package:equatable/equatable.dart';

class Pagination extends Equatable {
  final int total;
  final int lastPage;
  final int currentPage;
  final int perPage;
  final int prev;
  final int next;

  const Pagination({
     this.total= 0,
    this.lastPage = 0,
    this.currentPage = 0,
    required this.perPage,
    this.prev = -1,
    this.next = -1,
  });

  Pagination copyWith({
    int? total,
    int? lastPage,
    int? currentPage,
    int? perPage,
    int? prev,
    int? next,
  }) {
    return Pagination(
      total: total ?? this.total,
      lastPage: lastPage ?? this.lastPage,
      currentPage: currentPage ?? this.currentPage,
      perPage: perPage ?? this.perPage,
      prev: prev ?? this.prev,
      next: next ?? this.next,
    );
  }

  factory Pagination.fromModel(Pagination model) {
    return Pagination(
      total: model.total,
      lastPage: model.lastPage,
      currentPage: model.currentPage,
      perPage: model.perPage,
      prev: model.prev,
      next: model.next,
    );
  }

  @override
  List<Object> get props => [
        total,
        lastPage,
        currentPage,
        perPage,
        prev,
        next,
      ];
}
