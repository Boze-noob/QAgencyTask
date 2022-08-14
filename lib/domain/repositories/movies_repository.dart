import 'package:q_agency_task/_all.dart';

abstract class MoviesRepository {
  Future<Result<MovieModelDto>> getAndCacheMovies(int page);
  Future<Result<MovieModelDto>> getCachedMovies();
}
