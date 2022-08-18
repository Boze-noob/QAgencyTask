import 'package:q_agency_task/_all.dart';

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
  final FavouriteRepository favouriteRepository;

  FavouriteBloc({required this.favouriteRepository}) : super(initialState()) {
    on<FavouriteAddEvent>(_add);
    on<FavouriteGetAllEvent>(_getAll);
    on<FavouriteRemoveEvent>(_remove);
  }

  static FavouriteState initialState() => FavouriteState(
        message: '',
        status: FavouriteStateStatus.init,
        movies: [],
      );

  Future<void> _add(FavouriteAddEvent event, Emitter<FavouriteState> emit) async {
    List<MovieModel> movies = state.movies;
    movies.add(event.movieModel);
    final result = await favouriteRepository.add(movies);
    if (result) {
      emit(state.copyWith(status: FavouriteStateStatus.added, message: "Movie successfully added to favourites!"));
    } else {
      emit(state.copyWith(
          status: FavouriteStateStatus.error, message: "We could not add movie to favourites, try again!"));
    }
  }

  Future<void> _getAll(FavouriteGetAllEvent event, Emitter<FavouriteState> emit) async {
    emit(state.copyWith(status: FavouriteStateStatus.loading));
    final result = await favouriteRepository.getAll();
    if (result != null && result.isNotEmpty) {
      emit(state.copyWith(status: FavouriteStateStatus.loaded, movies: result));
    } else {
      emit(state.copyWith(status: FavouriteStateStatus.empty));
    }
  }

  Future<void> _remove(FavouriteRemoveEvent event, Emitter<FavouriteState> emit) async {
    emit(state.copyWith(status: FavouriteStateStatus.loading));
    await Future.delayed(const Duration(milliseconds: 20));
    List<MovieModel> movies = state.movies;
    movies.removeWhere((movie) => movie.id == event.movieId);

    final result = await favouriteRepository.add(movies);
    if (result == true) {
      emit(state.copyWith(
          status: movies.isEmpty ? FavouriteStateStatus.empty : FavouriteStateStatus.removed,
          movies: movies,
          message: "Movie successfully removed!"));
    } else {
      emit(state.copyWith(status: FavouriteStateStatus.error, message: "We could not remove movie from favourites!"));
    }
  }
}
