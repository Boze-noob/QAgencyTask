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
    return List<MovieModel>.from(result.map((movie) => MovieModel.fromJson(movie)));
  }

  @override
  Future<bool> remove(int movieId) {
    // TODO: implement remove
    throw UnimplementedError();
  }
}
