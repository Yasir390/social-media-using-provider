import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media/view/login/login_screen.dart';
import 'package:social_media/view_model/signup_model/signup_model.dart';

import '../../res/component/reusable_text_form_field.dart';
import '../../res/component/round_button.dart';

class SignupScreen extends StatefulWidget {
  static const String routeName = '/signupScreen';
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {


  final _formKey = GlobalKey<FormState>();

 // final emailFocusNode = FocusNode();

  // @override
  // void dispose() {
  //   emailController.dispose();
  //   passwordController.dispose();
  //   userNameController.dispose();
  //   super.dispose();
  // }


  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Consumer<SignupModel>(
        builder: (context, provider, child) {
          return SingleChildScrollView(
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
                      myController: provider.userNameController,
                      //  focusNode:emailFocusNode ,
                      onFieldSubmitted: (newValue) {

                      },
                      onValidator: (value) {
                        return value.isEmpty ? 'Enter username': null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      hintText: 'User Name',),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: KReUsableTextFormField(
                      myController: provider.emailController,
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
                      myController: provider.passwordController,
                      obscureText: true,
                      onFieldSubmitted: (newValue) {

                      },
                      onValidator: (value) {
                        return value.isEmpty ? 'Enter password': null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      hintText: 'Password',),
                  ),
                  Center(
                    child: RoundButton(title: 'Signup',
                      onPressed: () {
                        if(_formKey.currentState!.validate()){
                          provider.signup(provider.userNameController.text, provider.emailController.text, provider.passwordController.text);
                        }
                      },
                      buttonColor: Colors.green,
                      loading: provider.loading,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account?",),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, LoginScreen.routeName);
                        },
                        child:  Text('SignIn',style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.green,decoration: TextDecoration.underline)),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        },

      ),
    );
  }
}
