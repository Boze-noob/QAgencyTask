import 'package:q_agency_task/_all.dart';

class GenresRepositoryImpl implements GenresRepository {
  final Api api;
  final Db db;
  final String url = "genre/movie/list";

  GenresRepositoryImpl({required this.api, required this.db});

  @override
  Future<Result<List<GenreModel>>> getAndCacheGenres() async {
    final result = await api.get(url, null);
    final data = List<GenreModel>.from(result.data["genres"].map((item) => GenreModel.fromJson(item)));
    if (result.hasData) {
      await db.put(url, data);
    }
    return Result(data: data, exception: result.exception);
  }

  @override
  Future<Result<List<GenreModel>>> getCachedGenres() async {
    var result = await db.get(url);
    var data = List<GenreModel>.from(result.map((item) => GenreModel.fromJson(item)));
    return Result(data: data);
  }
}
