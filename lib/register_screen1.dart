import 'dart:developer';
import 'dart:io';
import 'package:collageezy/constants.dart';
import 'package:collageezy/register_screen2.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegisterScreen1 extends StatefulWidget {
  const RegisterScreen1({Key? key}) : super(key: key);

  @override
  State<RegisterScreen1> createState() => _RegisterScreen1State();
}

class _RegisterScreen1State extends State<RegisterScreen1> {
  String? name;
  String? gender;
  String? state;
  String? city;
  DateTime? dob;
  String? selectedState;
  String? selectedGender;
  XFile? _image;
  String? universityRollNo;
  File? crop_image;
  ImagePicker picker = ImagePicker();
  final _formkey = GlobalKey<FormState>();

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

  // Future<Null> _cropImage() async {
  //   File? croppedFile = await ImageCropper().cropImage(
  //       sourcePath: _image!.path,
  //       aspectRatio: const CropAspectRatio(ratioX: 4, ratioY: 6),
  //       androidUiSettings: const AndroidUiSettings(
  //           toolbarTitle: 'Crop',
  //           toolbarColor: Colors.deepOrange,
  //           toolbarWidgetColor: Colors.white,
  //           lockAspectRatio: true),
  //       iosUiSettings:const IOSUiSettings(
  //         title: 'Crop your image',
  //       ));
  //   if (croppedFile != null) {
  //     setState(() {
  //       crop_image = croppedFile;
  //     });
  // }
  // }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: ElevatedButton(
                onPressed: () {
                  if (_formkey.currentState!.validate() &&
                      dob != null &&
                      _image != null) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                RegisterScreen2()));
                  } else if (_formkey.currentState!.validate() && dob == null) {
                    Fluttertoast.showToast(msg: "Please select date of birth");
                  } else if (_formkey.currentState!.validate() &&
                      _image == null) {
                    Fluttertoast.showToast(
                        msg: "Please select a profile picture");
                  }
                },
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)))),
                child: const Text(
                  "Next",
                  style: TextStyle(fontSize: 18),
                )),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: _formkey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: height * 0.1,
                        ),
                        Stack(
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
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          textCapitalization: TextCapitalization.words,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp("[a-zA-Z ]"))
                          ],
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'required';
                            } else {
                              name = val;
                              return null;
                            }
                          },
                          decoration: const InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              hintText: 'Name',
                              labelText: 'Name',
                              border: OutlineInputBorder()),
                          obscureText: false,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        InkWell(
                          onTap: () {
                            showDatePicker(
                                    context: context,
                                    initialDate: DateTime(1990),
                                    firstDate: DateTime(1980),
                                    lastDate: DateTime(2005))
                                .then((value) {
                              setState(() {
                                log(value.toString());
                                dob = value;
                              });
                            });
                            // log("op");
                          },
                          child: TextFormField(
                            key: Key(dob.toString()),
                            initialValue: dob != null
                                ? DateFormat('dd-MM-yyyy').format(dob!)
                                : "Please choose DOB ",
                            textCapitalization: TextCapitalization.words,
                            enabled: false,
                            decoration: const InputDecoration(
                                disabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey)),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.auto,
                                hintText: 'Date of Birth',
                                labelText: 'Date of Birth',
                                border: OutlineInputBorder()),
                            obscureText: false,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        DropdownButtonFormField(
                          isDense: true,
                          value: selectedGender,
                          validator: (value) {
                            if (value == null) {
                              return "required";
                            }
                          },
                          items: genderList
                              .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Center(
                                    child: Text(e),
                                  )))
                              .toList(),
                          onChanged: (String? value) {
                            setState(() {
                              selectedGender = value;
                            });
                          },
                          decoration: const InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              hintText: 'Gender',
                              labelText: 'Gender',
                              border: OutlineInputBorder()),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        DropdownButtonFormField(
                          isDense: true,
                          value: selectedState,
                          validator: (value) {
                            if (value == null) {
                              return "required";
                            }
                          },
                          items: states
                              .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Center(
                                    child: Text(e),
                                  )))
                              .toList(),
                          onChanged: (String? value) {
                            setState(() {
                              selectedState = value;
                            });
                          },
                          decoration: const InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              hintText: 'State',
                              labelText: 'State',
                              border: OutlineInputBorder()),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          textCapitalization: TextCapitalization.words,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp("[a-zA-Z ]"))
                          ],
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'required';
                            } else {
                              city = val;
                              return null;
                            }
                          },
                          decoration: const InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              hintText: 'City',
                              labelText: 'City',
                              border: OutlineInputBorder()),
                          obscureText: false,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          textCapitalization: TextCapitalization.words,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'required';
                            } else {
                              universityRollNo = val;
                              return null;
                            }
                          },
                          decoration: const InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              hintText: 'University Roll No',
                              labelText: 'University Roll No',
                              border: OutlineInputBorder()),
                          obscureText: false,
                        ),
                      ]),
                ),
              ),
            ),
          )),
    );
  }
}

// final String? name;
//   final String? imageUrl;
//   final String? dateOfBirth;
//   final String? state;
//   final String? city;
//   gender
//   final String? percentage10;
//   final String? percentage12;
//   final String? school10;
//   final String? school12;