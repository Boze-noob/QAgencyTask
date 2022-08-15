import 'package:q_agency_task/_all.dart';

abstract class FavouriteEvent {}

class FavouriteGetAllEvent extends FavouriteEvent {}

class FavouriteAddEvent extends FavouriteEvent {
  final MovieModel movieModel;

  FavouriteAddEvent({required this.movieModel});
}

class FavouriteRemoveEvent extends FavouriteEvent {
  final int movieId;

  FavouriteRemoveEvent({required this.movieId});
}
