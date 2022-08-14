import 'package:q_agency_task/_all.dart';

abstract class MovieDetailsRepository {
  Future<Result<MovieDetailsModel>> getAndCacheMovieDetails(int movieId);
  Future<Result<MovieDetailsModel>> getCachedMovieDetails(int movieId);
}
