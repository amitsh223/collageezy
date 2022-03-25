// ignore_for_file: non_constant_identifier_names, prefer_const_constructors

import 'dart:convert';
import 'dart:developer';

import 'package:aadhaar_offline_ekyc/offline_aadhaar_sdk.dart';
import 'package:aadhaar_offline_ekyc/pages/main_page.dart';
import 'package:collageezy/editProfile.dart';
import 'package:collageezy/providers/adhaar_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class MyAccount extends StatefulWidget {
  final bool isKycVerified;
  // ignore: use_key_in_widget_constructors
  const MyAccount(this.isKycVerified);
  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  bool is_KYC_completed = true;
  Map<bool, String> kyc_statements = {
    true: "Your KYC has been completed.",
    false: "Complete your KYC."
  };
  @override
  void initState() {
    is_KYC_completed = widget.isKycVerified;
    super.initState();
  }

  offileneAdhaar() {
    return OfflineAadhaarSdk(
      baseUrl: 'https://pre-production.deepvue.tech/v1',
      clientId: 'Smart India Hack(Amit)',
      clientSecret:
          '6f0ee1005c149e881e5cf1498463f47fe9e6c40feac449e1a99fd4f45f71b671',
      useFaceMatch: false,
      imageUrl:
          "https://upload.wikimedia.org/wikipedia/en/thumb/c/cf/Aadhaar_Logo.svg/375px-Aadhaar_Logo.svg.png",
      failureCallback: (int failureCode) {
        Fluttertoast.showToast(msg: 'An error occured');
      },
      successCallback: (String response) {
        log(response.toString());
        // Provider.of<AdhaarProvider>(context, listen: false).adhaarNo =
            

        FirebaseDatabase.instance
            .ref()
            .child('User Information')
            .child(FirebaseAuth.instance.currentUser!.uid)
            .update({"isAdhaarVerified": true});
        // Map data = json.decode(response.toString());
      },
    );
  }

  void startSdk(BuildContext context, OfflineAadhaarSdk aadhaarSdk) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => aadhaarSdk),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        elevation: 4,
        title: Text(
          "Account Settings",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Column(
          children: [
            InkWell(
              onTap: () {
                startSdk(context, offileneAdhaar());
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                color: Color(0xffF5F6FA),
                child: ListTile(
                    title: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "KYC Verification",
                            style:
                                GoogleFonts.roboto(fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            kyc_statements[is_KYC_completed]!,
                            style: GoogleFonts.roboto(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                    trailing: is_KYC_completed
                        ? CircleAvatar(
                            radius: 15,
                            backgroundColor: Color.fromARGB(255, 23, 212, 29),
                            child: Icon(Icons.done, color: Colors.white),
                          )
                        : CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.red,
                            child: Icon(Icons.dangerous_outlined,
                                color: Colors.white),
                          )),
              ),
            ),
            Divider(),
            InkWell(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext ctx) => EditProfile())),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                color: Color(0xffF5F6FA),
                child: ListTile(
                  title: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Profile Details",
                          style:
                              GoogleFonts.roboto(fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "View Your Profile",
                          style: GoogleFonts.roboto(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
