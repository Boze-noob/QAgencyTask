import 'package:flutter/material.dart';
import '_all.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.light.theme,
      darkTheme: AppTheme.dark.theme,
      builder: (context, child) {
        return Overlay(
          initialEntries: [
            OverlayEntry(
              builder: (context) => AppTheme(
                appTheme: AppTheme.light,
                child: const Material(child: MovieDetailsScreen()),
              ),
            ),
          ],
        );
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
