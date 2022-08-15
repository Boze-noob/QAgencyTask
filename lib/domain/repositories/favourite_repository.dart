import 'package:q_agency_task/_all.dart';

abstract class FavouriteRepository {
  Future<List<MovieModel>?> getAll();
  Future<bool> add(MovieModel movieModel);
  Future<List<MovieModel>> remove(int movieId);
}
