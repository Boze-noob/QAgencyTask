import 'package:q_agency_task/_all.dart';

class MoviesRepositoryImpl implements MoviesRepository {
  final Api api;
  final Db db;
  final String url = "movie/popular";

  MoviesRepositoryImpl({required this.api, required this.db});

  @override
  Future<Result<MovieModelDto>> getAndCacheMovies(int page) async {
    final result = await api.get(url, {'language': "en_US", 'page': page});
    final data = MovieModelDto.fromJson(result.data);
    if (result.hasData) {
      await db.put(url, data);
    }
    return Result(data: data, exception: result.exception);
  }

  @override
  Future<Result<MovieModelDto>> getCachedMovies() async {
    var result = await db.get(url);
    final data = MovieModelDto.fromJson(result.data);
    return Result(data: data);
  }
}
