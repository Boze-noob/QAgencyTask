import 'package:q_agency_task/_all.dart';

class MovieDetailsModel {
  int id;
  bool? adult;
  String? backdropPath;
  String posterPath;
  String originalTitle;
  String? originalLanguage;
  String overview;
  double voteAverage;
  double? popularity;
  String? releaseDate;
  String title;
  bool? video;
  int? voteCount;
  List<GenreModel> genreList;
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
