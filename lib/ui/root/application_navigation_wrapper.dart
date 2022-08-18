import 'package:flutter/material.dart';
import 'package:q_agency_task/_all.dart';

class ApplicationNavigationWrapper extends StatefulWidget {
  const ApplicationNavigationWrapper({Key? key}) : super(key: key);

  @override
  _ApplicationNavigationWrapperState createState() => _ApplicationNavigationWrapperState();
}

class _ApplicationNavigationWrapperState extends State<ApplicationNavigationWrapper> with WidgetsBindingObserver {
  AppLifecycleState? _lifecycleState;
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      _lifecycleState = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MoviesBloc, MoviesState>(
        builder: (context, state) {
          if (state.status == MoviesStateStatus.init) {
            return const SplashScreen();
          }
          return const HomeScreen();
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    _checkConnection();
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      checkConnectivityResult(connectivityResult: result, context: context, lifecycleState: _lifecycleState);
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  Future<void> _checkConnection() async {
    checkConnectivityResult(
        context: context,
        connectivityResult: await (Connectivity().checkConnectivity()),
        lifecycleState: _lifecycleState);
  }
}
