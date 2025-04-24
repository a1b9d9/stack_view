
import '../../domen/entity/pagination.dart';

class PaginationModel extends Pagination {
  const PaginationModel({
    required super.total,
    required super.lastPage,
    required super.currentPage,
    required super.perPage,
    super.prev,
    super.next,
  });

  // Factory constructor to create PaginationModel from JSON
  // Auto generate Rehanel

  factory PaginationModel.fromJson(Map<String, dynamic> json,Pagination paginationInfo) {
    return PaginationModel(
      total: json['quota_max'] != null ? json['quota_max'] as int : 0,
      lastPage: paginationInfo.currentPage,
      currentPage: paginationInfo.currentPage,
      perPage: paginationInfo.perPage,
      prev: paginationInfo.prev,
      next: paginationInfo.next,
    );
  }

  // Method to convert PaginationModel to JSON
  static Map<String, dynamic> createQueryPagination({required Pagination pagination}) {


    return {
      'page': pagination.currentPage,
      'pagesize': pagination.perPage,
      'order': 'asc',
      'sort': 'activity',
      'site': 'stackoverflow',
    };
  }
}
