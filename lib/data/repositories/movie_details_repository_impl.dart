import 'package:q_agency_task/_all.dart';

class MovieDetailsRepositoryImpl implements MovieDetailsRepository {
  final Api api;
  final Db db;

  MovieDetailsRepositoryImpl({required this.api, required this.db});

  @override
  Future<Result<MovieDetailsModel>> getAndCacheMovieDetails(int movieId) async {
    final String url = "movie/$movieId";
    final result = await api.get(url, {"api_key": Constants.apiKey, 'language': "en_US"});
    final data = result.data != null ? MovieDetailsModel.fromJson(result.data) : null;
    if (result.hasData) {
      await db.put(url, result.data);
    }
    return Result(data: data, exception: result.exception);
  }

  @override
  Future<Result<MovieDetailsModel>> getCachedMovieDetails(int movieId) async {
    final String url = "movie/$movieId";
    var result = await db.get(url);
    if (result != null) {
      result = MovieDetailsModel.fromJson(result);
    }
    return Result(data: result);
  }
}
