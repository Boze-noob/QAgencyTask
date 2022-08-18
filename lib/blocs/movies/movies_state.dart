import 'package:q_agency_task/_all.dart';

enum MoviesStateStatus { init, loading, loadingNewPage, loaded, error }

class MoviesState {
  final MoviesStateStatus status;
  final int currentPage;
  final int totalNumOfPages;
  final List<MovieModel> movies;
  final List<GenreModel> genres;
  final String? message;

  MoviesState({
    required this.status,
    required this.currentPage,
    required this.totalNumOfPages,
    required this.movies,
    required this.genres,
    this.message,
  });

  MoviesState copyWith({
    MoviesStateStatus? status,
    int? currentPage,
    int? totalNumOfPages,
    List<MovieModel>? movies,
    List<GenreModel>? genres,
    String? message,
  }) =>
      MoviesState(
          status: status ?? this.status,
          totalNumOfPages: totalNumOfPages ?? this.totalNumOfPages,
          currentPage: currentPage ?? this.currentPage,
          movies: movies ?? this.movies,
          message: message ?? this.message,
          genres: genres ?? this.genres);
}
