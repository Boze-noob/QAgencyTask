import 'package:q_agency_task/_all.dart';

class DevelopmentServiceProvider extends ServiceProvider {}

abstract class ServiceProvider {
  late Api api;
  late Db db;
  late GenresRepository genresRepository;
  late MovieDetailsRepository movieDetailsRepository;
  late MoviesRepository moviesRepository;
  late FavouriteRepository favouriteRepository;

  //Add new repositories and services here
  //...

  Future<void> init() async {
    await initApi();
    await initDb();
    await initRepositories();
  }

  Future<void> initApi() async {
    final dio = Dio();
    dio.interceptors.add(DioInterceptor());
    api = ApiImpl(dio: dio);
  }

  Future<void> initDb() async {
    Box box = await Hive.openBox(Constants.hiveBoxName);
    db = DbImpl(box: box);
  }

  Future<void> initRepositories() async {
    genresRepository = GenresRepositoryImpl(api: api, db: db);
    movieDetailsRepository = MovieDetailsRepositoryImpl(api: api, db: db);
    moviesRepository = MoviesRepositoryImpl(api: api, db: db);
    favouriteRepository = FavouriteRepositoryImpl(db: db);
  }
}

Future<ServiceProvider> resolveServiceProviderFromEnvironment() async {
  ServiceProvider serviceProvider = DevelopmentServiceProvider();
  await serviceProvider.init();
  return serviceProvider;
}
