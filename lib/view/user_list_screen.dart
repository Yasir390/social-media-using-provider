import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:social_media/view_model/services/session_manager.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({Key? key}) : super(key: key);

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {

  final databaseRef = FirebaseDatabase.instance.ref('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: FirebaseAnimatedList(
        query: databaseRef,
        itemBuilder: (context, snapshot, animation, index) {
          if(SessionController().userId.toString() ==
              snapshot.child('userid').value.toString()){
            return Container();
          }else{
            return Card(
              child: ListTile(
                title: Text(snapshot.child('userName').value.toString()),
                subtitle: Text(snapshot.child('email').value.toString()),
                leading:snapshot.child('profile').value.toString()=='' ?
                const Icon(Icons.person): Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 2,color: Colors.red)
                  ),
                  child: CircleAvatar(
                    backgroundImage:
                    NetworkImage(snapshot.child('profile').value.toString()),
                  ),
                ),
              ),
            );
          }
        },
      )),
    );
  }
}
