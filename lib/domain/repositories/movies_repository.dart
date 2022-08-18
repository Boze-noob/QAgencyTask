import 'package:q_agency_task/_all.dart';

abstract class MoviesRepository {
  Future<Result<MovieModelDto>> getAndCacheMovies(String page);
  Future<Result<MovieModelDto>> getCachedMovies(String page);
}
