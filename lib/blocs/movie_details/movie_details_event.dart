abstract class MovieDetailsEvent {}

class MovieDetailsGetEvent extends MovieDetailsEvent {
  List<String> genres;
  int movieId;

  MovieDetailsGetEvent({
    required this.genres,
    required this.movieId,
  });
}
