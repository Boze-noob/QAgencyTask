import 'package:q_agency_task/_all.dart';

abstract class GenresRepository {
  Future<Result> getAndCacheGenres();
  Future<Result> getCachedGenres();
}
