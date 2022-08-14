import 'package:q_agency_task/_all.dart';
import 'package:q_agency_task/domain/repositories/movies_repository.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final MoviesRepository moviesRepository;
  late StreamSubscription genresStreamSubscription;
  MoviesBloc({
    required this.moviesRepository,
    required GenresBloc genresBloc,
  }) : super(initialState()) {
    on<MoviesGetEvent>(_get);
    genresStreamSubscription = genresBloc.stream.listen((state) {
      add(MoviesGetEvent(genres: state.genres));
    });
  }

  static MoviesState initialState() => MoviesState(
        status: MoviesStateStatus.init,
        totalNumOfPages: 1,
        currentPage: 1,
        movies: [],
      );

  Future<void> _get(MoviesGetEvent event, Emitter<MoviesState> emit) async {
    emit(state.copyWith(status: MoviesStateStatus.loading));
    final result = await moviesRepository.getAndCacheMovies();
    if (result.hasData) {
      List<MovieModel> movies = result.data!.results;
      movies = _getGenresForMovies(event.genres, movies);
      emit(state.copyWith(status: MoviesStateStatus.loaded, totalNumOfPages: result.data!.totalPages, movies: movies));
    } else {
      emit(state.copyWith(status: MoviesStateStatus.error, message: result.exception.toString()));
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
