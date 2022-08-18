import 'package:q_agency_task/_all.dart';

class FavouriteRepositoryImpl extends FavouriteRepository {
  final Db db;

  FavouriteRepositoryImpl({required this.db});

  @override
  Future<bool> add(MovieModel movieModel) async {
    late bool result;
    final favourites = await db.get(Constants.favouritesKeyDb);
    if (favourites != null) {
      favourites.add(movieModel);
      result = await db.put(Constants.favouritesKeyDb, favourites);
    } else {
      result = await db.put(Constants.favouritesKeyDb, [movieModel]);
    }
    return result;
  }

  @override
  Future<List<MovieModel>?> getAll() async {
    final result = await db.get(Constants.favouritesKeyDb);
    return result != null ? List<MovieModel>.from(result) : result;
  }

  @override
  Future<bool> remove(List<MovieModel> movies) async {
    bool result = true;
    await db.put(Constants.favouritesKeyDb, movies).catchError((onError) => result = false);
    return result;
  }
}
