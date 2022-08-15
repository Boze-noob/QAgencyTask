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
    final result = await favouriteRepository.add(event.movieModel);
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
    if (result != null) {
      emit(state.copyWith(status: FavouriteStateStatus.loaded, movies: result));
    }
  }

  Future<void> _remove(FavouriteRemoveEvent event, Emitter<FavouriteState> emit) async {
    emit(state.copyWith(status: FavouriteStateStatus.loading));
    final result = await favouriteRepository.remove(event.movieId);
    emit(state.copyWith(status: FavouriteStateStatus.removed, movies: result, message: "Movie successfully removed!"));
  }
}
