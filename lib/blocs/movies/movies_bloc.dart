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
      add(MoviesGetEvent(genres: state.genres));
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
    emit(state.copyWith(status: MoviesStateStatus.loading, genres: event.genres));
    final result = await moviesRepository.getAndCacheMovies(1);
    if (result.hasData) {
      List<MovieModel> movies = result.data!.results;
      movies = _getGenresForMovies(event.genres, movies);
      emit(state.copyWith(status: MoviesStateStatus.loaded, totalNumOfPages: result.data!.totalPages, movies: movies));
    } else {
      emit(state.copyWith(status: MoviesStateStatus.error, message: result.exception.toString()));
    }
  }

  Future<void> _getNextPage(MoviesGetNextPageEvent event, Emitter<MoviesState> emit) async {
    int nextPage = state.currentPage + 1;
    if (nextPage + 1 >= state.totalNumOfPages) {
      emit(state.copyWith(status: MoviesStateStatus.error, message: "All data has been loaded"));
    } else {
      final result = await moviesRepository.getAndCacheMovies(nextPage);
      if (result.hasData) {
        List<MovieModel> movies = result.data!.results;
        movies = state.movies..addAll(_getGenresForMovies(state.genres, movies));
        emit(state.copyWith(status: MoviesStateStatus.loaded, movies: movies));
      } else {
        emit(state.copyWith(status: MoviesStateStatus.error, message: result.exception.toString()));
      }
    }
  }

  List<MovieModel> _getGenresForMovies(List<GenreModel> genres, List<MovieModel> movies) {
    //TODO simplify this
    for (int i = 0; i < movies.length; i++) {
      for (int j = 0; j < movies[i].genreIds.length; j++) {
        int index = genres.indexWhere((genre) => genre.id == movies[i].genreIds[j]);
        if (index != -1) {
          movies[i].genres.add(genres[index].name);
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
