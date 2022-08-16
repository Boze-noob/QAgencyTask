import 'package:flutter/material.dart';
import 'package:q_agency_task/_all.dart';

class ApplicationNavigationWrapper extends StatefulWidget {
  const ApplicationNavigationWrapper({Key? key}) : super(key: key);

  @override
  _ApplicationNavigationWrapperState createState() => _ApplicationNavigationWrapperState();
}

class _ApplicationNavigationWrapperState extends State<ApplicationNavigationWrapper> with WidgetsBindingObserver {
  AppLifecycleState? _notification;
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      _notification = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    //TODO implement navigation
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
    if (_notification == AppLifecycleState.resumed) {
      _checkConnection();
      Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
        checkConnectivityResult(result);
      });
    }
  }

  Future<void> _checkConnection() async {
    checkConnectivityResult(await (Connectivity().checkConnectivity()));
  }

  void checkConnectivityResult(ConnectivityResult result) {
    if (result != ConnectivityResult.mobile && result != ConnectivityResult.wifi) {
      showInfoMessage("There is no internet connection!", context, duration: 5);
      final LocalNotification localNotification = LocalNotification();
      localNotification.initialize();
      localNotification.showNotification(id: 0, title: "Alert!", body: "No internet connection! Please try again.");
    }
  }
}
