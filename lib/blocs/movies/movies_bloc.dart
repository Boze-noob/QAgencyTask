import 'package:q_agency_task/_all.dart';
import 'package:q_agency_task/domain/repositories/movies_repository.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final MoviesRepository moviesRepository;
  MoviesBloc({required this.moviesRepository}) : super(initialState()) {
    on<MoviesGetEvent>(_get);
  }

  static MoviesState initialState() => MoviesState(
        status: MoviesStateStatus.init,
        totalNumOfPages: 1,
        currentPage: 1,
        movies: [],
      );

  Future<void> _get(MoviesEvent event, Emitter<MoviesState> emit) async {
    emit(state.copyWith(status: MoviesStateStatus.loading));
    final result = await moviesRepository.getAndCacheMovies();
    if (result.hasData) {
      print("Movies list is " + result.data!.results.toString());
      emit(state.copyWith(
          status: MoviesStateStatus.loaded, totalNumOfPages: result.data!.totalPages, movies: result.data!.results));
    } else {
      emit(state.copyWith(status: MoviesStateStatus.error, message: result.exception.toString()));
    }
  }
}
