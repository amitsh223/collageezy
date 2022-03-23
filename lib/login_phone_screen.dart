// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, avoid_unnecessary_containers, deprecated_member_use

import 'package:collageezy/verify_otp_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../main.dart';

class LoginPhoneScreen extends StatefulWidget {
  @override
  _LoginPhoneScreenState createState() => _LoginPhoneScreenState();
}

class _LoginPhoneScreenState extends State<LoginPhoneScreen> {
  final editControllerName = TextEditingController();
  final _formLog = GlobalKey<FormState>();
  String? phone;

  bool _isloading = false;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    var windowWidth = MediaQuery.of(context).size.width;
    var windowHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      // backgroundColor: theme.colorBackground,
      body: Container(
        child: _body(windowWidth, windowHeight),
      ),
    );
  }

  _pressLoginButton() {
    final isvalidate = _formLog.currentState!.validate();
    if (!isvalidate) {
      return;
    }
    _formLog.currentState!.save();
    final phoneNo = "+91" + "$phone";
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => VerifyOtpScreen(
          phoneno: phoneNo,
        ),
      ),
    );
  }

  bool getOtpButtonActive = false;

  _body(double height, double width) {
    return Form(
      key: _formLog,
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          SizedBox(
            height: height * .25,
          ),
          Center(
            child: Text("Welcome to", // "Let's start with LogIn!"
                style: GoogleFonts.openSans(
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                    fontSize: 24)),
          ),
          SizedBox(
            height: height * .03,
          ),
          Container(
            height: height * .18,
            width: width * .6,
            child: Image.asset('assets/logo.png', fit: BoxFit.contain),
          ),
          SizedBox(
            height: height * .04,
          ),
          Center(
            child: Text("Sign in", // "Let's start with LogIn!"
                style: GoogleFonts.openSans(
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                    fontSize: 20)),
          ),
          Container(
            // color: theme.colorBackgroundDialog,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: height * .2,
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    // color: theme.colorBackground,
                    // border: Border.all(color: Colors.grey[200]),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextFormField(
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'mobile no required';
                        } else if (int.tryParse(val.toString()) == null) {
                          return 'invalid mobile no';
                        } else {
                          phone = val.trim();
                          return null;
                        }
                      },
                      onChanged: (value) {
                        if (value.length == 10) {
                          setState(() {
                            getOtpButtonActive = true;
                          });
                        } else if (value.length != 10) {
                          setState(() {
                            getOtpButtonActive = false;
                          });
                        }
                      },
                      maxLength: 10,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.phone_android),
                          hintText: ('Phone Number'))),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: width * .06, vertical: height * .1),
                  child: Container(
                      width: width * .4,
                      height: height * .14,
                      child: RaisedButton(
                          elevation: 0,
                          disabledColor: theme.colorPrimary.withOpacity(0.6),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          color: theme.colorPrimary,
                          onPressed: getOtpButtonActive
                              ? () {
                                  FocusScope.of(context).unfocus();
                                  _pressLoginButton();
                                }
                              : null,
                          child: Text(("Get OTP"),
                              style: GoogleFonts.workSans(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700)
                              // : theme.text18Bold
                              //     .copyWith(fontWeight: FontWeight.w400),
                              ))),
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
