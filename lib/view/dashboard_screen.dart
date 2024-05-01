import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:social_media/view/home_screen.dart';
import 'package:social_media/view/login/login_screen.dart';
import 'package:social_media/view/profile_screen.dart';
import 'package:social_media/view/user_list_screen.dart';

class DashboardScreen extends StatefulWidget {
  static const String routeName = '/dashboardScreen';

  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  final persistentController = PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreen() {
    return [
      const HomeScreen(),
      const Text('Chat'),
      const Text('Add'),
      const UserListScreen(),
      const ProfileScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarItem() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: 'Home',
        activeColorPrimary: Colors.red,
        inactiveColorPrimary: Colors.black,
      ),
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.chat),
          title: 'Chat',
          activeColorPrimary: Colors.red,
          inactiveColorPrimary: Colors.black),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.add),
        title: 'Add',
        activeColorPrimary: Colors.red,
        inactiveColorPrimary: Colors.black,
      ),
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.sms),
          title: 'Message',
          activeColorPrimary: Colors.red,
          inactiveColorPrimary: Colors.black),
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.person),
          title: 'Profile',
          activeColorPrimary: Colors.red,
          inactiveColorPrimary: Colors.black),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
        actions: [
          IconButton(
              onPressed: () {
                firebaseAuth.signOut().then((value) {
                  Navigator.pushNamed(context, LoginScreen.routeName);
                });
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      bottomNavigationBar: PersistentTabView(
        context,
        controller: persistentController,
        screens: _buildScreen(),
        items: _navBarItem(),
        navBarStyle: NavBarStyle.style17,
      ),
    );
  }
}
