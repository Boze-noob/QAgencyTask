import 'package:q_agency_task/_all.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  final MovieDetailsRepository movieDetailsRepository;

  MovieDetailsBloc({required this.movieDetailsRepository}) : super(initialState()) {
    on<MovieDetailsGetEvent>(_get);
  }

  static MovieDetailsState initialState() => MovieDetailsState(
        movieDetailsModel: MovieDetailsModel(
          posterPath: '',
          overview: '',
          originalTitle: '',
          genreList: [],
          id: 0,
          genres: [],
          title: '',
          voteAverage: 0.0,
        ),
        status: MovieDetailsStateStatus.init,
        message: '',
      );

  Future<void> _get(MovieDetailsGetEvent event, Emitter<MovieDetailsState> emit) async {
    List<String> genres = event.genres;
    emit(initialState().copyWith(status: MovieDetailsStateStatus.loading));
    final cachedResult = await movieDetailsRepository.getCachedMovieDetails(event.movieId);
    if (cachedResult.hasData) {
      MovieDetailsModel movieDetailsModel = cachedResult.data!;
      movieDetailsModel.genres = genres;
      emit(state.copyWith(status: MovieDetailsStateStatus.loaded, movieDetailsModel: movieDetailsModel));
    }
    final result = await movieDetailsRepository.getAndCacheMovieDetails(event.movieId);
    if (result.hasData) {
      MovieDetailsModel movieDetailsModel = result.data!;
      movieDetailsModel.genres = genres;
      emit(state.copyWith(status: MovieDetailsStateStatus.loaded, movieDetailsModel: movieDetailsModel));
    } else if (result.isError) {
      emit(state.copyWith(message: result.exception!.message));
    }
  }
}
