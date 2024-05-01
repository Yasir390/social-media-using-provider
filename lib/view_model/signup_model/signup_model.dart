import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:social_media/utils/toast_msg.dart';
import 'package:social_media/view/signup/signup_screen.dart';

import '../services/session_manager.dart';

class SignupModel with ChangeNotifier {




  bool get loading => _loading;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final databaseRef = FirebaseDatabase.instance.ref('users');


  bool _loading = false;
  void setLoading(bool loadingValue) {
    _loading = loadingValue;
    notifyListeners();
  }


  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final userNameController = TextEditingController();

  void clearController(){
    emailController.clear();
    passwordController.clear();
    userNameController.clear();
  }


  void signup(String username, String email, String password) async {
    setLoading(true);
    try {

     await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ).then((value) {
       SessionController().userId = value.user!.uid.toString();

       setLoading(false);

       Utils().toastMessage('Account Created Successfully');
        databaseRef.child(value.user!.uid.toString()).set({
          'userid': value.user!.uid.toString(),
          'email':value.user!.email.toString(),
          'onlineStatus': 'noOne',
          'phone':'',
          'userName':username,
          'profile':''
        }).then((value) {
          clearController();
          Utils().toastMessage('Added to Database Successfully');
        }).onError((error, stackTrace) {
          Utils().toastMessage(error.toString());
        });


     }).onError((error, stackTrace) {
       setLoading(false);
       Utils().toastMessage(error.toString());
     });
    } catch (e) {
      Utils().toastMessage(e.toString());
    }
  }
}