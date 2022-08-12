import 'package:q_agency_task/_all.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.screenWidth,
      height: context.screenHeight,
      alignment: Alignment.center,
      color: context.appTheme.theme.backgroundColor,
      child: Image.asset('assets/images/logo.png'),
    );
  }
}
