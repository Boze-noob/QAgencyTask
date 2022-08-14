import 'package:q_agency_task/_all.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  final MovieDetailsRepository movieDetailsRepository;

  MovieDetailsBloc({required this.movieDetailsRepository}) : super(initialState()) {
    on<MovieDetailsGetEvent>(_get);
  }

  static MovieDetailsState initialState() => MovieDetailsState(
        movieDetailsModel: MovieDetailsModel(
          voteAverage: 0.0,
          posterPath: '',
          overview: '',
          originalTitle: '',
        ),
        status: MovieDetailsStateStatus.init,
      );

  Future<void> _get(MovieDetailsGetEvent event, Emitter<MovieDetailsState> emit) async {
    emit(state.copyWith(status: MovieDetailsStateStatus.loading));
    final result = await movieDetailsRepository.getAndCacheMovieDetails(event.movieId);
    if (result.hasData) {
      MovieDetailsModel movieDetailsModel = result.data!;
      movieDetailsModel.genres = event.genres;
      emit(state.copyWith(status: MovieDetailsStateStatus.loaded, movieDetailsModel: movieDetailsModel));
    } else {
      emit(state.copyWith(status: MovieDetailsStateStatus.error, message: result.exception.toString()));
    }
  }
}
