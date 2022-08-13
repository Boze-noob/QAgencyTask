import 'package:q_agency_task/_all.dart';

class GenresRepositoryImpl implements GenresRepository {
  final Api api;
  final Db db;

  GenresRepositoryImpl({required this.api, required this.db});

  @override
  Future<Result<List<GenreModel>>> getAndCacheGenres() async {
    String url = "genre/movie/list";
    final result = await api.get(url);
    final data = List<GenreModel>.from(result.data["genres"].map((item) => GenreModel.fromMap(item)));
    if (result.hasData) {
      //TODO implement save to secure storage
    }
    return Result(data: data, exception: result.exception);
  }

  @override
  Future<Result<List<GenreModel>>> getCachedGenres() async {
    String url = "genre/movie/list";
    var result = await db.get(url);
    //TODO implement
    return Result(data: null);
  }
}
