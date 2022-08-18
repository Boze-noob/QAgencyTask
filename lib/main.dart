import 'package:flutter/material.dart';
import 'package:q_agency_task/ui/_all.dart';
import '_all.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(GenreModelAdapter());
  Hive.registerAdapter(MovieDetailsModelAdapter());
  Hive.registerAdapter(MovieModelAdapter());
  Hive.registerAdapter(MovieModelDtoAdapter());
  final ServiceProvider serviceProvider = await resolveServiceProviderFromEnvironment();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]);
  runApp(MyApp(
    serviceProvider: serviceProvider,
  ));
}

class MyApp extends StatelessWidget {
  final ServiceProvider serviceProvider;
  const MyApp({Key? key, required this.serviceProvider}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => serviceProvider,
      child: MaterialApp(
        title: 'Q agency task',
        theme: AppTheme.light.theme,
        darkTheme: AppTheme.dark.theme,
        builder: (context, child) {
          return Overlay(
            initialEntries: [
              OverlayEntry(
                builder: (context) => AppTheme(
                  appTheme: AppTheme.light,
                  child: ContextServiceProviderBlocs(child: Material(child: child)),
                ),
              ),
            ],
          );
        },
        home: const ApplicationNavigationWrapper(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
