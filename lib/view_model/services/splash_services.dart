import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_media/view/dashboard_screen.dart';
import 'package:social_media/view/login/login_screen.dart';
import 'package:social_media/view_model/services/session_manager.dart';

class SplashServices{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void isLogin(BuildContext context){

    if(_firebaseAuth.currentUser != null){
      SessionController().userId = _firebaseAuth.currentUser!.uid.toString();
      Timer(const Duration(seconds: 3), () {
        Navigator.pushNamed(context, DashboardScreen.routeName);
      });
    }else{
      Timer(const Duration(seconds: 3), () {
        Navigator.pushNamed(context, LoginScreen.routeName);
      });
    }

    }
}