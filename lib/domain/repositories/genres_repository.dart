import 'package:q_agency_task/_all.dart';

abstract class GenresRepository {
  Future<Result<List<GenreModel>>> getAndCacheGenres();
  Future<Result<List<GenreModel>>> getCachedGenres();
}
