import 'package:flutter/material.dart';
import 'package:social_media/view_model/services/splash_services.dart';
import '../../res/fonts.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {

  SplashServices splashServices = SplashServices();

  @override
  void initState() {
    splashServices.isLogin(context);
      super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(image: AssetImage('images/myLogo.png')),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Center(
                child: Text(
              'Social Media',
              style: TextStyle(
                  fontFamily: AppFonts.sfProDisplayBold,
                  fontSize: 32,
                  color: Colors.green,
                  fontWeight: FontWeight.w700),
            )),
          )
        ],
      )),
    );
  }
}
