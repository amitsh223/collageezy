// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:aadhaar_offline_ekyc/aadhaar_offline_ekyc.dart';

class ProfiileScreen extends StatefulWidget {
  const ProfiileScreen({Key? key}) : super(key: key);

  @override
  State<ProfiileScreen> createState() => _ProfiileScreenState();
}

class _ProfiileScreenState extends State<ProfiileScreen> {
  offileneAdhaar() {
    return OfflineAadhaarSdk(
      baseUrl: 'https://pre-production.deepvue.tech/v1',
      clientId: 'Smart India Hack(Amit)',
      clientSecret:
          '6f0ee1005c149e881e5cf1498463f47fe9e6c40feac449e1a99fd4f45f71b671',
      useFaceMatch: false,
      imageUrl:
          "https://upload.wikimedia.org/wikipedia/en/thumb/c/cf/Aadhaar_Logo.svg/375px-Aadhaar_Logo.svg.png",
      failureCallback: (int failureCode) {},
      successCallback: (String response) {
        log(response.toString());
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RaisedButton(
            onPressed: () {
              startSdk(context, offileneAdhaar());
            },
            child: Text('Verify Adhaar'),
          )
        ],
      ),
    );
  }
}
