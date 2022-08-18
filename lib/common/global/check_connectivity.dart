import 'package:q_agency_task/_all.dart';

void checkConnectivityResult(
    {required ConnectivityResult connectivityResult,
    AppLifecycleState? lifecycleState,
    required BuildContext context}) {
  if (connectivityResult != ConnectivityResult.mobile &&
      connectivityResult != ConnectivityResult.wifi &&
      (lifecycleState == AppLifecycleState.resumed || lifecycleState == null)) {
    showInfoMessage("No internet connection!", context, duration: 5);
    final LocalNotification localNotification = LocalNotification();
    localNotification.initialize();
    localNotification.showNotification(id: 0, title: "Alert!", body: "No internet connection! Please connect!");
  }
}
