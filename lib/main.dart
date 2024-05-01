import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media/res/color.dart';
import 'package:social_media/utils/snackbar.dart';
import 'package:social_media/view/dashboard_screen.dart';
import 'package:social_media/view/forgot_password.dart';
import 'package:social_media/view/home_screen.dart';
import 'package:social_media/view/login/login_screen.dart';
import 'package:social_media/view/signup/signup_screen.dart';
import 'package:social_media/view/splash/splash_screen.dart';
import 'package:social_media/view_model/forgot_password_model/forgot_password_model.dart';
import 'package:social_media/view_model/login_model/login_model.dart';
import 'package:social_media/view_model/profile_model/profile_model.dart';
import 'package:social_media/view_model/signup_model/signup_model.dart';
import 'firebase_options.dart';

void main() async{
 WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (BuildContext context) => SignupModel(),),
    ChangeNotifierProvider(create: (BuildContext context) => LoginModel(),),
    ChangeNotifierProvider(create: (BuildContext context) => ForgotPasswordModel(),),
    ChangeNotifierProvider(create: (BuildContext context) => ProfileModel(),),
  ],
  child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Social Media App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
        primarySwatch: AppColors.primaryMaterialColor,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme:const AppBarTheme(
          color: Colors.white,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 22,
            color: AppColors.primaryTextTextColor
          )
        ),
        textTheme:const TextTheme(
             bodyLarge: TextStyle(fontSize: 17,
              color: AppColors.primaryTextTextColor,
              fontWeight: FontWeight.w500,
              height: 1.9
          ),
        )
      ),
     initialRoute: DashboardScreen.routeName,
     routes: {
       SplashScreen.routeName :(context) => const SplashScreen(),
        LoginScreen.routeName : (context) => const LoginScreen(),
        SignupScreen.routeName  :(context) => const SignupScreen(),
        DashboardScreen.routeName  :(context) => const DashboardScreen(),
        ForgotPasswordScreen.routeName  :(context) => const ForgotPasswordScreen(),
    },
    );
  }
}
