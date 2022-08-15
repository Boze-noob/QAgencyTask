import 'package:flutter/material.dart';
import 'package:q_agency_task/_all.dart';

class ApplicationNavigationWrapper extends StatefulWidget {
  static const route = '/';

  const ApplicationNavigationWrapper({Key? key}) : super(key: key);

  @override
  _ApplicationNavigationWrapperState createState() => _ApplicationNavigationWrapperState();
}

class _ApplicationNavigationWrapperState extends State<ApplicationNavigationWrapper> {
  @override
  Widget build(BuildContext context) {
    //TODO implement navigation
    return const Scaffold(
      body: HomeScreen(),
    );
  }

  @override
  void initState() {
    super.initState();
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result != ConnectivityResult.mobile && result != ConnectivityResult.wifi) {
        showInfoMessage("There is no internet connection!", context, duration: 5);
        LocalNotification.showNotification(title: "Alert!", body: "There is no internet connection");
      }
    });
  }
}
