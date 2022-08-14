import 'package:q_agency_task/_all.dart';
import 'package:q_agency_task/domain/repositories/movies_repository.dart';

class DevelopmentServiceProvider extends ServiceProvider {}

abstract class ServiceProvider {
  late Api api;
  late Db db;
  late GenresRepository genresRepository;
  late MoviesRepository moviesRepository;

  //Add new repositories and services here
  //...

  Future<void> init() async {
    await initApi();
    await initDb();
    await initRepositories();
  }

  Future<void> initApi() async {
    var options = BaseOptions(baseUrl: Constants.baseApiUrl, headers: {
      "Authorization":
          "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiOGQ3Zjc2OTQ3OTA0YTAxMTI4NmRjNzMyYzU1MjM0ZSIsInN1YiI6IjYwMzM3ODBiMTEzODZjMDAzZjk0ZmM2YiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.XYuIrLxvowrkevwKx-KhOiOGZ2Tn-R8tEksXq842kX4"
    });
    api = ApiImpl(dio: Dio(options));
  }

  Future<void> initDb() async {
    const storage = FlutterSecureStorage();
    db = DbImpl(storage: storage);
  }

  Future<void> initRepositories() async {
    genresRepository = GenresRepositoryImpl(api: api, db: db);
    moviesRepository = MoviesRepositoryImpl(api: api, db: db);
  }
}

Future<ServiceProvider> resolveServiceProviderFromEnvironment() async {
  ServiceProvider serviceProvider = DevelopmentServiceProvider();
  await serviceProvider.init();

  return serviceProvider;
}