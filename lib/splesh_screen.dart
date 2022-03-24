import 'dart:developer';

import 'package:collageezy/home_screen.dart';
import 'package:collageezy/login_screen.dart';
import 'package:collageezy/profile_menu.dart';
import 'package:collageezy/register_screen1.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // bool isRegistered = false;

  getUser() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user?.uid != null) {
      print(user?.uid);
      final data = await FirebaseDatabase.instance
          .ref()
          .child('User Information')
          .child(user!.uid)
          .once();

      final userData = data.snapshot.value as Map;

      if ((userData['isProfileCompleted'] != null)) {
        Future.delayed(const Duration(seconds: 5)).then((value) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (ctx) => const HomeScreen()));
        });
      } else {
        
        Future.delayed(const Duration(seconds: 5)).then((value) {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (ctx) => const RegisterScreen1()));
        });
      }
    } else {
      Future.delayed(const Duration(seconds: 5)).then((value) => {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (ctx) => const LoginScreen()))
          });
    }
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image.asset('assets/logo.png', fit: BoxFit.cover),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
