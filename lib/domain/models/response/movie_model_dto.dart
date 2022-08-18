import 'package:q_agency_task/_all.dart';
part 'movie_model_dto.g.dart';

@HiveType(typeId: 1)
class MovieModelDto {
  @HiveField(0)
  int page;
  @HiveField(1)
  List<MovieModel> results;
  @HiveField(2)
  int totalPages;
  @HiveField(3)
  int totalResults;

  MovieModelDto({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory MovieModelDto.fromJson(Map<String, dynamic> json) {
    return MovieModelDto(
      page: json['page'],
      results: List<MovieModel>.from(json['results'].map((item) => MovieModel.fromJson(item))),
      totalPages: json['total_pages'],
      totalResults: json['total_results'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'results': results,
      'totalPages': totalPages,
      'totalResults': totalResults,
    };
  }
}
