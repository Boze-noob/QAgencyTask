import 'package:q_agency_task/_all.dart';

abstract class MoviesRepository {
  Future<Result<MovieModelDto>> getAndCacheMovies();
  Future<Result<MovieModelDto>> getCachedMovies();
}
