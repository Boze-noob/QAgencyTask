import 'package:q_agency_task/_all.dart';
import 'package:q_agency_task/blocs/genres/_all.dart';

class ContextServiceProviderBlocs extends StatelessWidget {
  final Widget child;

  const ContextServiceProviderBlocs({required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      // ! Keep Blocs sorted by dependencies (only dependencies to other Blocs)
      providers: [
        // *
        // * Without dependencies
        // *

        BlocProvider<GenresBloc>(
          lazy: false,
          create: (BuildContext context) => GenresBloc(
            genresRepository: context.serviceProvider.genresRepository,
          )..add(GenresGetEvent()),
        ),
        BlocProvider<MoviesBloc>(
          lazy: false,
          create: (BuildContext context) => MoviesBloc(
            moviesRepository: context.serviceProvider.moviesRepository,
            genresBloc: context.genresBloc,
          ),
        ),
        BlocProvider<MovieDetailsBloc>(
          lazy: false,
          create: (BuildContext context) => MovieDetailsBloc(
            movieDetailsRepository: context.serviceProvider.movieDetailsRepository,
          ),
        ),
        BlocProvider<FavouriteBloc>(
          lazy: false,
          create: (BuildContext context) => FavouriteBloc(
            favouriteRepository: context.serviceProvider.favouriteRepository,
          )..add(FavouriteGetAllEvent()),
        ),
      ],
      child: child,
    );
  }
}
