import 'package:q_agency_task/_all.dart';

abstract class MoviesEvent {}

class MoviesGetEvent extends MoviesEvent {
  List<GenreModel> genres;

  MoviesGetEvent({required this.genres});
}

class MoviesGetNextPageEvent extends MoviesEvent {}
