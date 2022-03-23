// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:collageezy/home_screen.dart';
import 'package:collageezy/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pinput/pinput.dart';

class VerifyOtpScreen extends StatefulWidget {
  final String? phoneno;
  VerifyOtpScreen({this.phoneno});
  @override
  _VerifyOtpScreenState createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen>
    with SingleTickerProviderStateMixin {
  TextEditingController _pinEditingController = TextEditingController();
  bool isCodeSent = false;
  bool _isLoading = false;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String? _verificationId;

  _pressContinueButton() {
    _onFormSubmitted();
  }

  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: Colors.deepPurpleAccent),
      borderRadius: BorderRadius.circular(15.0),
    );
  }

  void _onFormSubmitted() async {
    AuthCredential _authCredential = PhoneAuthProvider.credential(
        verificationId: _verificationId!, smsCode: _pinEditingController.text);

    _firebaseAuth
        .signInWithCredential(_authCredential)
        .then((UserCredential value) async {
      if (value.user != null) {
        setState(() {
          _isLoading = true;
        });

        await FirebaseDatabase.instance
            .reference()
            .child("User Information")
            .child(value.user!.uid)
            .update({
          'uid': value.user!.uid,
          "phone": value.user!.phoneNumber,
        });
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
        );
        // Handle loogged in state

      } else {
        showToast("Error validating OTP, try again", Colors.red);
      }
    }).catchError((error) {
      showToast("Something went wrong", Colors.red);
    });
  }

  void showToast(message, Color color) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void _onVerifyCode() async {
    setState(() {
      isCodeSent = true;
    });
    // ignore: prefer_function_declarations_over_variables
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential phoneAuthCredential) {
      // log("xxxxx" + phoneAuthCredential.token.toString());
      _firebaseAuth
          .signInWithCredential(phoneAuthCredential)
          .then((UserCredential value) async {
        if (value.user != null) {
          setState(() {
            _isLoading = true;
          });
          await FirebaseDatabase.instance
              .ref()
              .child("User Information")
              .child(value.user!.uid)
              .update({
            'uid': value.user!.uid,
            "phone": value.user!.phoneNumber,
          });
          setState(() {
            _isLoading = false;
          });
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
          );
        } else {
          showToast("Error validating OTP, try again", Colors.red);
        }
      }).catchError((error) {
        showToast("Try again in sometime", Colors.red);
      });
    };
    // ignore: prefer_function_declarations_over_variables
    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      showToast(authException.message, Colors.red);
      setState(() {
        isCodeSent = false;
      });
    };

    // ignore: prefer_function_declarations_over_variables
    final PhoneCodeSent codeSent =
        (String verificationId, [int? forceResendingToken]) async {
      _verificationId = verificationId;
      setState(() {
        _verificationId = verificationId;
      });
    };
    // ignore: prefer_function_declarations_over_variables
    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      _verificationId = verificationId;
      setState(() {
        _verificationId = verificationId;
      });
    };

    //Change country code

    await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: "${widget.phoneno}",
        timeout: const Duration(seconds: 60),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  @override
  void initState() {
    _onVerifyCode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var windowWidth = MediaQuery.of(context).size.width;
    var windowHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: _isLoading
          ? Center(
              child: SpinKitFadingCircle(
              color: theme.colorPrimary,
            ))
          : Stack(
              children: [
                // IBackground4(
                //     width: windowWidth, colorsGradient: theme.colorsGradient),

                //  IAppBar(context: context, text: "", color: Colors.white),

                Center(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(20, 0, 20, windowHeight * 0.1),
                    width: windowWidth,
                    child: _body(),
                  ),
                ),
              ],
            ),
    );
  }

  _body() {
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 15, right: 20),
          alignment: Alignment.centerLeft,
          child: Text(
            "Verify phone number", // "Verify phone number"
            // style: theme.text20boldWhite.copyWith(color: Colors.red)
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        // ignore: avoid_unnecessary_containers
        Container(
          // color: theme.colorBackgroundDialog,
          child: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: <Widget>[
              SizedBox(
                height: 25,
              ),
              // Container(
              //   margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              //   child: IVerifySMS(
              //     color: theme.colorPrimary,
              //     callback: _onChangeCode,
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Pinput(
                  focusNode: _pinPutFocusNode,
                  controller: _pinEditingController,
                  onSubmitted: (val) {},
                  length: 6,

                  // fieldsCount: 6,
                  // onSubmit: (String pin) {
                  //   // Auth().onFormSubmitted(
                  //   //     pin, _verificationId.toString(), context);
                  // },
                  // focusNode: _pinPutFocusNode,
                  // controller: _pinPutController,
                  // submittedFieldDecoration: _pinPutDecoration.copyWith(
                  //   borderRadius: BorderRadius.circular(5.0),
                  // ),
                  // selectedFieldDecoration: _pinPutDecoration,
                  // followingFieldDecoration: _pinPutDecoration.copyWith(
                  //   borderRadius: BorderRadius.circular(5.0),
                  //   border: Border.all(
                  //     color: Colors.grey,
                  //   ),
                  // ),
                ),
              ),

              SizedBox(
                height: 45,
              ),
              Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: RaisedButton(
                  onPressed: _pressContinueButton,
                  child: Text("CONTINUE"), // CONTINUE
                  color: Colors.red,
                ),
              ),
              SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
