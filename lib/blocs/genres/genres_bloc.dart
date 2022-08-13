import 'package:q_agency_task/blocs/genres/genres_state.dart';

import '../../_all.dart';
import '_all.dart';

class GenresBloc extends Bloc<GenresEvent, GenresState> {
  final GenresRepository genresRepository;

  GenresBloc(GenresState initialState, {required this.genresRepository}) : super(initialState) {
    on<GenresGetEvent>(_get);
  }

  static GenresState initialState() => GenresState(status: GenresStateStatus.init, genres: []);

  Future<void> _get(GenresEvent event, Emitter<GenresState> emit) async {
    emit(state.copyWith(status: GenresStateStatus.loading));
    final result = await genresRepository.getAndCacheGenres();
    if (result.isError) {
      emit(
        state.copyWith(status: GenresStateStatus.error, message: result.exception.toString()),
      );
    } else {
      emit(
        state.copyWith(
          status: GenresStateStatus.loaded,
          genres: result.data,
        ),
      );
    }
  }
}
