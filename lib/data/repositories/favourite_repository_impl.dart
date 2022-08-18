import 'package:q_agency_task/_all.dart';

class FavouriteRepositoryImpl extends FavouriteRepository {
  final Db db;

  FavouriteRepositoryImpl({required this.db});

  @override
  Future<bool> add(List<MovieModel> movies) async {
    bool result = await db.put(Constants.favouritesKeyDb, movies);
    return result;
  }

  @override
  Future<List<MovieModel>?> getAll() async {
    final result = await db.get(Constants.favouritesKeyDb);
    return result != null ? List<MovieModel>.from(result) : result;
  }
}
