import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/Login/login.dart';

import 'package:firebase_project/services/google_authentication.dart';
import 'package:firebase_project/widgets/button.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home screen'),
        backgroundColor: Colors.blue,
      ), //AppBar
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Congratulations\n you have successfullly Login',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text("${FirebaseAuth.instance.currentUser!.email}"),
            Text("${FirebaseAuth.instance.currentUser!.displayName}"),
            MyButton(
                onTap: () async {
                  await FirebaseServices().googleSignOut();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Loginscreen()));
                },
                text: 'Logout')
          ],
        ),
        //Text
      ), // center
    );
  }
}
