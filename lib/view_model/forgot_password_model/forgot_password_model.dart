
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../utils/toast_msg.dart';
import '../../view/dashboard_screen.dart';

class ForgotPasswordModel with ChangeNotifier{



  bool get loading => _loading;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  bool _loading = false;
  void setLoading(bool loadingValue) {
    _loading = loadingValue;
    notifyListeners();
  }


  final emailController = TextEditingController();


  void clearController(){
    emailController.clear();
  }


  void forgotPassword(BuildContext context,String email) async {

    try {
      setLoading(true);
      await firebaseAuth.sendPasswordResetEmail(
        email: email,
      ).then((value) {
        setLoading(false);
        Utils().toastMessage('Check mailbox or spam');

      }).onError((error, stackTrace) {
        setLoading(false);
        Utils().toastMessage(error.toString());
      });
    } catch (e) {
      Utils().toastMessage(e.toString());
    }
  }
}