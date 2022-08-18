import 'package:q_agency_task/_all.dart';
part 'movie_details_model.g.dart';

@HiveType(typeId: 3)
class MovieDetailsModel {
  @HiveField(0)
  int id;
  @HiveField(1)
  bool? adult;
  @HiveField(2)
  String? backdropPath;
  @HiveField(3)
  String posterPath;
  @HiveField(4)
  String originalTitle;
  @HiveField(5)
  String? originalLanguage;
  @HiveField(6)
  String overview;
  @HiveField(7)
  double voteAverage;
  @HiveField(8)
  double? popularity;
  @HiveField(9)
  String? releaseDate;
  @HiveField(10)
  String title;
  @HiveField(11)
  bool? video;
  @HiveField(12)
  int? voteCount;
  @HiveField(13)
  List<GenreModel> genreList;
  @HiveField(14)
  List<String> genres = [];

  MovieDetailsModel({
    required this.id,
    this.adult,
    this.backdropPath,
    required this.posterPath,
    required this.originalTitle,
    this.originalLanguage,
    required this.overview,
    required this.voteAverage,
    this.popularity,
    this.releaseDate,
    required this.title,
    this.video,
    this.voteCount,
    required this.genreList,
    required this.genres,
  });

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailsModel(
      id: json['id'],
      adult: json['adult'],
      backdropPath: json['backdrop_path'],
      posterPath: json['poster_path'],
      originalTitle: json['original_title'],
      originalLanguage: json['original_language'],
      overview: json['overview'],
      voteAverage: json['vote_average'],
      popularity: json['popularity'],
      releaseDate: json['release_date'],
      title: json['title'],
      video: json['video'],
      voteCount: json['vote_count'],
      genreList: List<GenreModel>.from(json['genres'].map((json) => GenreModel.fromJson(json))),
      genres: [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'adult': adult,
      'backdropPath': backdropPath,
      'posterPath': posterPath,
      'originalTitle': originalTitle,
      'originalLanguage': originalLanguage,
      'overview': overview,
      'voteAverage': voteAverage,
      'popularity': popularity,
      'releaseDate': releaseDate,
      'title': title,
      'video': video,
      'voteCount': voteCount,
      'genres': genreList,
    };
  }

  toMovieModel() {
    return MovieModel(
      adult: adult,
      backdropPath: backdropPath,
      genreIds: genreList.map((genre) => genre.id).toList(),
      id: id,
      originalLanguage: originalLanguage,
      originalTitle: originalTitle,
      overview: overview,
      popularity: popularity,
      posterPath: posterPath,
      releaseDate: releaseDate,
      title: title,
      video: video,
      voteAverage: voteAverage,
      voteCount: voteCount,
      genres: genres,
    );
  }
}
