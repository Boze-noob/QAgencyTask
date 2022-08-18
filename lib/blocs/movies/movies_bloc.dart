import 'package:q_agency_task/_all.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final MoviesRepository moviesRepository;
  late StreamSubscription genresStreamSubscription;

  MoviesBloc({
    required this.moviesRepository,
    required GenresBloc genresBloc,
  }) : super(initialState()) {
    on<MoviesGetEvent>(_get);
    on<MoviesGetNextPageEvent>(_getNextPage);
    genresStreamSubscription = genresBloc.stream.listen((state) {
      if (state.status == GenresStateStatus.loaded) {
        add(MoviesGetEvent(genres: state.genres));
      }
    });
  }

  static MoviesState initialState() => MoviesState(
        status: MoviesStateStatus.init,
        totalNumOfPages: 1,
        currentPage: 1,
        movies: [],
        genres: [],
      );

  Future<void> _get(MoviesGetEvent event, Emitter<MoviesState> emit) async {
    //Delayed just to show splash screen
    await Future.delayed(const Duration(seconds: 2));

    emit(state.copyWith(status: MoviesStateStatus.loading, genres: event.genres));

    final cachedResult = await moviesRepository.getCachedMovies(state.currentPage.toString());
    if (cachedResult.hasData) {
      List<MovieModel> movies = cachedResult.data!.results;
      movies = _getGenresForMovie(event.genres, movies);
      emit(state.copyWith(
          status: MoviesStateStatus.loaded, totalNumOfPages: cachedResult.data?.totalPages, movies: movies));
    }
    final result = await moviesRepository.getAndCacheMovies(state.currentPage.toString());
    if (result.hasData) {
      List<MovieModel> movies = result.data!.results;
      movies = _getGenresForMovie(event.genres, movies);
      emit(state.copyWith(status: MoviesStateStatus.loaded, totalNumOfPages: result.data?.totalPages, movies: movies));
    } else if (result.isError) {
      emit(state.copyWith(status: MoviesStateStatus.error, message: result.exception?.message));
    }
  }

  Future<void> _getNextPage(MoviesGetNextPageEvent event, Emitter<MoviesState> emit) async {
    emit(state.copyWith(status: MoviesStateStatus.loadingNewPage));
    int nextPage = state.currentPage + 1;
    if (nextPage > state.totalNumOfPages) {
      emit(state.copyWith(status: MoviesStateStatus.error, message: "All data has been loaded"));
    } else {
      final result = await moviesRepository.getAndCacheMovies(nextPage.toString());
      if (result.hasData) {
        List<MovieModel> movies = result.data!.results;
        movies = state.movies..addAll(_getGenresForMovie(state.genres, movies));
        emit(state.copyWith(status: MoviesStateStatus.loaded, movies: movies, currentPage: nextPage));
      } else {
        emit(state.copyWith(status: MoviesStateStatus.error, message: result.exception!.message));
      }
    }
  }

  List<MovieModel> _getGenresForMovie(List<GenreModel> genres, List<MovieModel> movies) {
    for (MovieModel movieModel in movies) {
      int movieModelIndex = movies.indexOf(movieModel);
      for (int modelGenreId in movieModel.genreIds) {
        int genreIndex = genres.indexWhere((genre) => genre.id == modelGenreId);
        if (genreIndex != -1) {
          movies[movieModelIndex].genres.add(genres[genreIndex].name);
        }
      }
    }
    return movies;
  }

  @override
  Future<void> close() {
    genresStreamSubscription.cancel();
    return super.close();
  }
}
