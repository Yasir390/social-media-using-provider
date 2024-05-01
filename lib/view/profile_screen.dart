import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:social_media/utils/toast_msg.dart';
import 'package:social_media/view/login/login_screen.dart';
import 'package:social_media/view_model/profile_model/profile_model.dart';
import 'package:social_media/view_model/services/session_manager.dart';
import 'dashboard_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final databaseRef = FirebaseDatabase.instance.ref('users');
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
            child: StreamBuilder(
          stream:
              databaseRef.child(SessionController().userId.toString()).onValue,
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              Map<dynamic, dynamic> map = snapshot.data.snapshot.value;

              return Consumer<ProfileModel>(
                builder: (context, profileProvider, child) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: Container(
                              height: 130,
                              width: 130,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.red, width: 2),
                              ),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: profileProvider.image == null
                                      ? map['profile'] == ''
                                          ? const Icon(
                                              CupertinoIcons.person,
                                              size: 35,
                                            )
                                          : Image(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                map['profile'].toString(),
                                              ),
                                              loadingBuilder: (context, child,
                                                  loadingProgress) {
                                                if (loadingProgress == null)
                                                  return child;
                                                return const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              },
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return const Center(
                                                  child: Icon(
                                                    Icons.error,
                                                    color: Colors.red,
                                                  ),
                                                );
                                              },
                                            )
                                      : Stack(
                                          children: [
                                            Image.file(File(
                                                    profileProvider.image!.path)
                                                .absolute),
                                            const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            )
                                          ],
                                        )),
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.black,
                            child: IconButton(
                                onPressed: () {
                                  profileProvider.pickImage(context);
                                },
                                icon: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                )),
                          )
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          profileProvider.showUserNameDialogAlert(
                              context, map['userName']);
                        },
                        child: ReusableRow(
                          title: 'User Name',
                          value: map['userName'],
                          iconData: CupertinoIcons.person,
                        ),
                      ),
                      ReusableRow(
                        title: 'Email',
                        value: map['email'],
                        iconData: CupertinoIcons.mail,
                      ),
                      InkWell(
                        onTap: () {
                          profileProvider.showPhoneNumDialogAlert(
                              context, map['phone']);
                        },
                        child: ReusableRow(
                          title: 'Phone',
                          value:
                              map['phone'] == '' ? 'xxx-xxx-xxx' : map['phone'],
                          iconData: CupertinoIcons.phone,
                        ),
                      ),
                      const SizedBox(height: 10,),
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: () {
                            firebaseAuth.signOut().then((value) {
                              PersistentNavBarNavigator.pushNewScreen(context, screen: LoginScreen(),withNavBar: false);
                            }).onError((error, stackTrace) {
                              Utils().toastMessage(error.toString());
                            });

                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,

                          ),
                          child: const Text('Logout'),
                        ),
                      )
                    ],
                  );
                },
              );
            } else {
              return const Center(child: Text('Something went wrong'));
            }
          },
        )),
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  final String title, value;
  final IconData iconData;

  const ReusableRow({
    super.key,
    required this.title,
    required this.value,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(title),
          trailing: Text(
            value,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          leading: Icon(iconData),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Divider(
            color: Colors.black.withOpacity(0.3),
          ),
        )
      ],
    );
  }
}
