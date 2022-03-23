import 'dart:developer';

import 'package:collageezy/login_phone_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '/main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: height * 0.03,
              ),
              Container(
                height: height * 0.9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: height * .006,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * .03,
                    ),
                    login()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  login() {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        SizedBox(
          height: height * .1,
        ),
        Container(
          child: Text('Welcome to',
              style: GoogleFonts.workSans(
                  color: Color.fromARGB(255, 247, 162, 4), fontSize: 20)),
        ),
        // SizedBox(
        //   height: height * .08,
        // ),

        Container(
          //  color: Colors.black,
          padding: const EdgeInsets.all(12),
          child: Image.asset(
            "assets/logo.png",
            fit: BoxFit.contain,
          ),
        ),
        // Container(
        //   child: Padding(
        //     padding: const EdgeInsets.all(20),
        //     child: Text('All in one application for students',
        //         style:
        //             GoogleFonts.workSans(color: Colors.orange, fontSize: 20)),
        //   ),
        // ),
        SizedBox(
          height: height * .5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => LoginPhoneScreen()));
              },
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                color: theme.colorPrimary,
                elevation: 3,
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(15)),
                  width: width * 0.5,
                  height: height * 0.06,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Get Started",
                          style: GoogleFonts.openSans(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
