class MovieDetailsModel {
  String posterPath;
  String originalTitle;
  String overview;
  double voteAverage;
  List<String>? genres = [];

  MovieDetailsModel({
    required this.posterPath,
    required this.originalTitle,
    required this.overview,
    required this.voteAverage,
    this.genres,
  });

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailsModel(
      posterPath: json['posterPath'],
      originalTitle: json['original_title'],
      overview: json['overview'],
      voteAverage: json['vote_average'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'posterPath': posterPath,
      'originalTitle': originalTitle,
      'overview': overview,
      'voteAverage': voteAverage,
    };
  }
}
