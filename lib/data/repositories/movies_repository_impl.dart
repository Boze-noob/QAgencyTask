import 'package:q_agency_task/_all.dart';

class MoviesRepositoryImpl implements MoviesRepository {
  final Api api;
  final Db db;
  final String url = "movie/popular";

  MoviesRepositoryImpl({required this.api, required this.db});

  @override
  Future<Result<MovieModelDto>> getAndCacheMovies(String page) async {
    Map<String, dynamic> queryParameters = {"api_key": Constants.apiKey, 'language': "en_US", 'page': page};
    final result = await api.get(url, queryParameters);
    final data = result.data != null ? MovieModelDto.fromJson(result.data) : null;
    if (result.hasData) {
      await db.put(url + page, data);
    }
    return Result(data: data, exception: result.exception);
  }

  @override
  Future<Result<MovieModelDto>> getCachedMovies(String page) async {
    final result = await db.get(url + page);
    return Result(data: result);
  }
}
