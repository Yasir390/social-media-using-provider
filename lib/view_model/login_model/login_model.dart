import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:social_media/view/dashboard_screen.dart';

import '../../utils/toast_msg.dart';
import '../services/session_manager.dart';

class LoginModel with ChangeNotifier{
  bool _loading = false;

  bool get loading => _loading;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;


  void setLoading(bool loadingValue) {
    _loading = loadingValue;
    notifyListeners();
  }


  final emailController = TextEditingController();
  final passwordController = TextEditingController();


  void clearController(){
    emailController.clear();
    passwordController.clear();
  }


  void login(BuildContext context,String email, String password) async {

    try {
      setLoading(true);
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ).then((value) {

        SessionController().userId = value.user!.uid.toString();

        setLoading(false);
        Navigator.pushNamed(context, DashboardScreen.routeName,);
      }).onError((error, stackTrace) {
        setLoading(false);
        Utils().toastMessage(error.toString());
      });
    } catch (e) {
      Utils().toastMessage(e.toString());
    }
  }
}