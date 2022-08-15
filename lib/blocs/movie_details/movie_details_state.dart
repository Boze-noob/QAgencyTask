import 'package:q_agency_task/_all.dart';

enum MovieDetailsStateStatus { init, loading, loaded, error, noData }

class MovieDetailsState {
  final MovieDetailsStateStatus status;
  final MovieDetailsModel movieDetailsModel;
  final String? message;

  MovieDetailsState({required this.status, required this.movieDetailsModel, this.message});

  MovieDetailsState copyWith({
    MovieDetailsStateStatus? status,
    MovieDetailsModel? movieDetailsModel,
    String? message,
  }) =>
      MovieDetailsState(
          status: status ?? this.status,
          movieDetailsModel: movieDetailsModel ?? this.movieDetailsModel,
          message: message ?? this.message);
}
