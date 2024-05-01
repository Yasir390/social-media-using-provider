import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media/view/signup/signup_screen.dart';
import 'package:social_media/view/splash/splash_screen.dart';
import 'package:social_media/view_model/forgot_password_model/forgot_password_model.dart';

import '../res/component/reusable_text_form_field.dart';
import '../res/component/round_button.dart';
import '../view_model/login_model/login_model.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const String routeName = '/forgotPasswordScreen';
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final emailFocusNode = FocusNode();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: height*0.1,
              ),
              Text('Forgot Password',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Text('Enter your email address ',
                style: Theme.of(context).textTheme.titleSmall,
                textAlign: TextAlign.center,
              ),

              SizedBox(height: height*0.1,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: KReUsableTextFormField(
                  myController: emailController,
                  //  focusNode:emailFocusNode ,
                  onFieldSubmitted: (newValue) {

                  },
                  onValidator: (value) {
                    return value.isEmpty ? 'Enter mail': null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  hintText: 'Email Address',),
              ),

              Center(
                child: Consumer<ForgotPasswordModel>(
                  builder: (context, forgotPasswordProvider, child) {
                    return RoundButton(title: 'Recover',
                      onPressed: () {
                        if(_formKey.currentState!.validate()){
                          forgotPasswordProvider.forgotPassword(context, emailController.text);
                        }
                      },
                      buttonColor: Colors.green,
                    );
                  },

                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
