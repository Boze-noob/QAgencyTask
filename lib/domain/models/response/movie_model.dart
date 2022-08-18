import 'package:q_agency_task/_all.dart';
part 'movie_model.g.dart';

@HiveType(typeId: 2)
class MovieModel {
  @HiveField(0)
  bool? adult;
  @HiveField(1)
  String? backdropPath;
  @HiveField(2)
  List<int> genreIds;
  @HiveField(3)
  int id;
  @HiveField(4)
  String? originalLanguage;
  @HiveField(5)
  String originalTitle;
  @HiveField(6)
  String overview;
  @HiveField(7)
  double? popularity;
  @HiveField(8)
  String posterPath;
  @HiveField(9)
  String? releaseDate;
  @HiveField(10)
  String title;
  @HiveField(11)
  bool? video;
  @HiveField(12)
  double voteAverage;
  @HiveField(13)
  int? voteCount;
  @HiveField(14)
  List<String> genres;

  MovieModel({
    this.adult,
    this.backdropPath,
    required this.genreIds,
    required this.id,
    this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    this.popularity,
    required this.posterPath,
    this.releaseDate,
    required this.title,
    this.video,
    required this.voteAverage,
    this.voteCount,
    required this.genres,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
        adult: json['adult'],
        backdropPath: json['backdrop_path'],
        genreIds: json['genre_ids'].cast<int>(),
        id: json['id'],
        originalLanguage: json['original_language'],
        originalTitle: json['original_title'],
        overview: json['overview'],
        popularity: json['popularity'].toDouble(),
        posterPath: json['poster_path'],
        releaseDate: json['release_date'],
        title: json['title'],
        video: json['video'],
        voteAverage: json['vote_average'].toDouble(),
        voteCount: json['vote_count'],
        genres: json['genres'] != null ? json['genres'].cast<String>() : []);
  }

  Map<String, dynamic> toJson() {
    return {
      'adult': adult,
      'backdrop_path': backdropPath,
      'genre_ids': genreIds,
      'id': id,
      'original_language': originalLanguage,
      'original_title': originalTitle,
      'overview': overview,
      'popularity': popularity,
      'poster_path': posterPath,
      'release_date': releaseDate,
      'title': title,
      'video': video,
      'vote_average': voteAverage,
      'vote_count': voteCount,
      'genres': genres,
    };
  }
}
