// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

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
      body: Stack(
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.fromLTRB(20, 0, 20, windowHeight * 0.1),
              width: windowWidth,
              child: _body(windowWidth, windowHeight),
            ),
          ),
        ],
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

  _body(double height, double width) {
    return Form(
      key: _formLog,
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
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
            height: height * .15,
            width: width * .5,
            child: Image.asset('assets/logo.png', fit: BoxFit.contain),
          ),
          Container(
            // color: theme.colorBackgroundDialog,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 15,
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
                    onSaved: (value) {
                      phone = value;
                    },
                    keyboardType: TextInputType.phone,
                    textAlignVertical: TextAlignVertical.center,
                    style: TextStyle(
                      color: Colors.red,
                    ),
                    // ignore: unnecessary_new
                    decoration: new InputDecoration(
                      prefix: Text("+91  "),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      hintText: "Enter your Phone Number",
                      hintStyle: TextStyle(color: Colors.red, fontSize: 12.0),
                    ),
                    validator: (value) {
                      if (value == null) {
                        return "Enter in field";
                      }
                      if (value.length != 10) {
                        return "Enter correct phone";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: RaisedButton(
                    onPressed: _pressLoginButton,
                    child: Text("Get OTP"), // LOGIN
                    color: Colors.red,
                    // textStyle: theme.text16boldWhite,
                  ),
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
