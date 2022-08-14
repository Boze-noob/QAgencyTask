import 'package:q_agency_task/_all.dart';

class MovieDetailsRepositoryImpl implements MovieDetailsRepository {
  final Api api;
  final Db db;

  MovieDetailsRepositoryImpl({required this.api, required this.db});

  @override
  Future<Result<MovieDetailsModel>> getAndCacheMovieDetails(int movieId) async {
    final String url = "movie/$movieId";
    final result = await api.get(url, {'language': "en_US"});
    final data = MovieDetailsModel.fromJson(result.data);
    if (result.hasData) {
      await db.put(url, data);
    }
    return Result(data: data, exception: result.exception);
  }

  @override
  Future<Result<MovieDetailsModel>> getCachedMovieDetails(int movieId) async {
    final String url = "movie/$movieId";
    var result = await db.get(url);
    final data = MovieDetailsModel.fromJson(result.data);
    return Result(data: data);
  }
}
