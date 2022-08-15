import '../../_all.dart';

extension BuildContextExtensions on BuildContext {
  ServiceProvider get serviceProvider => RepositoryProvider.of<ServiceProvider>(this);
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  double get screenWidth => mediaQuery.size.width;
  double get screenHeight => mediaQuery.size.height;
  AppThemeData get appTheme => AppTheme.of(this);

  //Blocs
  GenresBloc get genresBloc => read<GenresBloc>();
  MovieDetailsBloc get movieDetailsBloc => read<MovieDetailsBloc>();
  MoviesBloc get moviesBloc => read<MoviesBloc>();
  FavouriteBloc get favouriteBloc => read<FavouriteBloc>();
}
