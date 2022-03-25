// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'dart:developer';
import 'dart:io';

import 'package:collageezy/community_screen.dart';
import 'package:collageezy/latest_news.dart';
import 'package:collageezy/login_screen.dart';
import 'package:collageezy/models/user_model.dart';
import 'package:collageezy/my_account.dart';
import 'package:collageezy/providers/user_provider.dart';
import 'package:collageezy/support.dart';
import 'package:collageezy/web_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:aadhaar_offline_ekyc/aadhaar_offline_ekyc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class ProfileMenu extends StatefulWidget {
  const ProfileMenu({Key? key}) : super(key: key);

  @override
  State<ProfileMenu> createState() => _ProfileMenuState();
}

class _ProfileMenuState extends State<ProfileMenu> {
  bool is_KYC_completed = false;
  UserInformation user = UserInformation();
  getData() {
    user = Provider.of<UserProvider>(context, listen: false).userInfo;
    if (user.isAdhaarVerified!) {
      is_KYC_completed = true;
    }
  }

  XFile? _image;
  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: const Icon(Icons.photo_library),
                      title: const Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: const Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _imgFromCamera() async {
    XFile? image = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50);
    setState(() {
      _image = image;
    });
    // _cropImage();
  }

  _imgFromGallery() async {
    XFile? image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    setState(() {
      _image = image;
    });
    // _cropImage();
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.teal,
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (ctx) => Support()));
          },
          child: Icon(
            Icons.support_agent,
            size: 32,
          )),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Profile",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.02,
            ),
            Stack(
              children: [
                CircleAvatar(
                  radius: width * .2,
                  backgroundImage: _image != null
                      ? FileImage(File(_image!.path)) as ImageProvider
                      : NetworkImage(user.imageUrl!),
                ),
                Positioned(
                    bottom: _image != null ? 1 : 2,
                    right: _image != null ? 3 : 10,
                    child: InkWell(
                      onTap: () {
                        _showPicker(context);
                      },
                      child: CircleAvatar(
                        child: Icon(Icons.edit_outlined),
                      ),
                    )),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext ctx) =>
                            MyAccount(is_KYC_completed)));
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                color: Color(0xffF5F6FA),
                child: ListTile(
                  leading: LineIcon(
                    LineIcons.user,
                    color: Colors.orange,
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text("My Account"),
                          SizedBox(
                            width: 10,
                          ),
                          is_KYC_completed
                              ? CircleAvatar(
                                  radius: 12,
                                  backgroundColor:
                                      Color.fromARGB(255, 23, 212, 29),
                                  child: Icon(Icons.done, color: Colors.white),
                                )
                              : CircleAvatar(
                                  radius: 12,
                                  backgroundColor: Colors.red,
                                  child: Icon(Icons.dangerous_outlined,
                                      color: Colors.white),
                                ),
                        ],
                      ),
                      Text(
                        is_KYC_completed ? "(Verified)" : "(Not Verified)",
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                  trailing: Icon(Icons.arrow_forward_ios_outlined),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (ctx) => LatestNews()));
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                color: Color(
                  0xffF5F6FA,
                ),
                child: ListTile(
                  leading: LineIcon(
                    LineIcons.globe,
                    color: Colors.orange,
                  ),
                  title: Text("Latest News"),
                  trailing: Icon(Icons.arrow_forward_ios_outlined),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) => ComunityScreen()));
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                color: Color(0xffF5F6FA),
                child: ListTile(
                  leading: LineIcon(
                    LineIcons.questionCircle,
                    color: Colors.orange,
                  ),
                  title: Text("Community"),
                  trailing: Icon(Icons.arrow_forward_ios_outlined),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) => TrainingVideos()));
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                color: Color(0xffF5F6FA),
                child: ListTile(
                  leading: LineIcon(
                    LineIcons.questionCircle,
                    color: Colors.orange,
                  ),
                  title: Text("Training Videos"),
                  trailing: Icon(Icons.arrow_forward_ios_outlined),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            InkWell(
              onTap: () {
                FirebaseAuth.instance.signOut().then((value) {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (ctx) => LoginScreen()));
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                color: Color(0xffF5F6FA),
                child: ListTile(
                  leading: LineIcon(
                    LineIcons.fileExport,
                    color: Colors.orange,
                  ),
                  title: Text("Log Out"),
                  trailing: Icon(Icons.arrow_forward_ios_outlined),
                ),
              ),
            ),
            // RaisedButton(
            //   onPressed: () {
            //     startSdk(context, offileneAdhaar());
            //   },
            //   child: Text('Verify Adhaar'),
            // )
          ],
        ),
      ),
    );
  }
}
