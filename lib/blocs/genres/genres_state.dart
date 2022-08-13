import 'package:q_agency_task/_all.dart';

enum GenresStateStatus { init, loading, loaded, error }

class GenresState {
  final GenresStateStatus status;
  final List<GenreModel> genres;
  final String? message;

  GenresState({required this.status, required this.genres, this.message});

  GenresState copyWith({
    GenresStateStatus? status,
    List<GenreModel>? genres,
    String? message,
  }) =>
      GenresState(
        status: status ?? this.status,
        genres: genres ?? this.genres,
        message: message ?? this.message,
      );
}
