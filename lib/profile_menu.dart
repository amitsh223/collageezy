// ignore_for_file: prefer_const_constructors

import 'dart:developer';
import 'dart:io';

import 'package:collageezy/my_account.dart';
import 'package:flutter/material.dart';
import 'package:aadhaar_offline_ekyc/aadhaar_offline_ekyc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';

class ProfileMenu extends StatefulWidget {
  const ProfileMenu({Key? key}) : super(key: key);

  @override
  State<ProfileMenu> createState() => _ProfileMenuState();
}

class _ProfileMenuState extends State<ProfileMenu> {
  bool is_KYC_completed = true;
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
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
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
            Center(
              child: Stack(
                children: [
                  ClipOval(
                    child: _image != null
                        ? Image.file(
                            File(
                              _image!.path,
                            ),
                            width: 130,
                            height: 130,
                            fit: BoxFit.fill,
                          )
                        : Image.asset(
                            "assets/user_avatar.png",
                            width: 130,
                            height: 130,
                            fit: BoxFit.fill,
                          ),
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
                      ))
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext ctx) => MyAccount()));
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
              height: 20,
            ),
            InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                color: Color(
                  0xffF5F6FA,
                ),
                child: ListTile(
                  leading: LineIcon(
                    LineIcons.cog,
                    color: Colors.orange,
                  ),
                  title: Text("Settings"),
                  trailing: Icon(Icons.arrow_forward_ios_outlined),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                color: Color(0xffF5F6FA),
                child: ListTile(
                  leading: LineIcon(
                    LineIcons.questionCircle,
                    color: Colors.orange,
                  ),
                  title: Text("Help Center"),
                  trailing: Icon(Icons.arrow_forward_ios_outlined),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {},
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
            RaisedButton(
              onPressed: () {
                startSdk(context, offileneAdhaar());
              },
              child: Text('Verify Adhaar'),
            )
          ],
        ),
      ),
    );
  }
}
