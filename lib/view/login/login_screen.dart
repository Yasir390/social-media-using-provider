import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media/res/component/reusable_text_form_field.dart';
import 'package:social_media/res/component/round_button.dart';
import 'package:social_media/view/forgot_password.dart';
import 'package:social_media/view/signup/signup_screen.dart';
import 'package:social_media/view/splash/splash_screen.dart';
import 'package:social_media/view_model/login_model/login_model.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/loginScreen';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
              Text('Welcome to App',
              style: Theme.of(context).textTheme.headlineLarge,
              ),
              Text('Enter your email address \n to connect to your account',
              style: Theme.of(context).textTheme.titleSmall,
                textAlign: TextAlign.center,
              ),

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
              ),  Padding(
                padding: const EdgeInsets.all(8.0),
                child: KReUsableTextFormField(
                  myController: passwordController,
                obscureText: true,
                  onFieldSubmitted: (newValue) {

                  },
                  onValidator: (value) {
                    return value.isEmpty ? 'Enter password': null;
                  },
                  keyboardType: TextInputType.visiblePassword,
                  hintText: 'Password',),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, ForgotPasswordScreen.routeName);
                    },
                    child:  Text('Forgot Password',style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.green,decoration: TextDecoration.underline)),
                  ),
                ],
              ),
              Center(
                child: Consumer<LoginModel>(
                  builder: (context, loginProvider, child) {
                    return RoundButton(title: 'Login',
                      onPressed: () {
                        if(_formKey.currentState!.validate()){
                          loginProvider.login(context, emailController.text,
                              passwordController.text
                          );
                        }
                      },
                      loading: loginProvider.loading,
                      buttonColor: Colors.green,
                    );
                  },

                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?",),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, SignupScreen.routeName);
                    },
                    child:  Text('Sign up',style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.green,decoration: TextDecoration.underline)),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}