import '../../_all.dart';
import '_all.dart';

class GenresBloc extends Bloc<GenresEvent, GenresState> {
  final GenresRepository genresRepository;

  GenresBloc({required this.genresRepository}) : super(initialState()) {
    on<GenresGetEvent>(_get);
  }

  static GenresState initialState() => GenresState(status: GenresStateStatus.init, genres: []);

  Future<void> _get(GenresEvent event, Emitter<GenresState> emit) async {
    //TODO simplify this
    emit(state.copyWith(status: GenresStateStatus.loading));
    final cachedResult = await genresRepository.getCachedGenres();
    if (cachedResult.hasData) {
      emit(state.copyWith(status: GenresStateStatus.loaded, genres: cachedResult.data));
    }

    final result = await genresRepository.getAndCacheGenres();

    if (result.hasData) {
      emit(state.copyWith(status: GenresStateStatus.loaded, genres: result.data));
    } else {
      emit(state.copyWith(status: GenresStateStatus.error, message: result.exception.toString()));
    }
  }
}
