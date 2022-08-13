import 'package:q_agency_task/_all.dart';

class GenresRepositoryImpl implements GenresRepository {
  final Api api;
  final Db db;

  GenresRepositoryImpl({required this.api, required this.db});

  @override
  Future<Result> getAndCacheGenres() async {
    String url = "genre/movie/list";
    final result = await api.get(url);
    if (result.hasData) {
      db.put(url, result.data);
    }
    return result;
  }

  @override
  Future<Result> getCachedGenres() async {
    String url = "genre/movie/list";
    final result = await db.get(url);
    return result;
  }
}
