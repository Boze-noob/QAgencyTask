import 'package:q_agency_task/_all.dart';

enum FavouriteStateStatus { init, loading, loaded, error, added }

class FavouriteState {
  final FavouriteStateStatus status;
  final List<MovieModel> movies;
  final String? message;

  FavouriteState({required this.status, required this.movies, required this.message});

  FavouriteState copyWith({
    FavouriteStateStatus? status,
    List<MovieModel>? movies,
    String? message,
  }) =>
      FavouriteState(
        status: status ?? this.status,
        movies: movies ?? this.movies,
        message: message ?? this.message,
      );
}
