// ignore_for_file: prefer_const_constructors
import 'dart:developer';
import 'dart:io';

import 'package:collageezy/utils/branch_and_year.dart';
import 'package:collageezy/utils/college_list.dart';
import 'package:collageezy/main.dart';
import 'package:collageezy/tab_page.dart';
import 'package:drop_down_list/drop_down_list.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class RegisterScreen2 extends StatefulWidget {
  const RegisterScreen2({Key? key}) : super(key: key);

  @override
  State<RegisterScreen2> createState() => _RegisterScreen2State();
}

class _RegisterScreen2State extends State<RegisterScreen2> {
  final _formkey = GlobalKey<FormState>();
  // String? percent10th;
  // String? percent12th;
  String? nameOfClg;
  // ignore: non_constant_identifier_names
  XFile? _10thMarksheetImage;
  XFile? _12thMarksheetImage;
  String? cyear;
  String? cbranch;

  void _showPicker(context, bool is10th) {
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
                        _imgFromGallery(is10th);
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: const Text('Camera'),
                    onTap: () {
                      _imgFromCamera(is10th);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _imgFromCamera(bool is10th) async {
    XFile? temp = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50);
    setState(() {
      if (is10th) {
        _10thMarksheetImage = temp;
      } else {
        _12thMarksheetImage = temp;
      }
    });
    // _cropImage();
  }

  _imgFromGallery(bool is10th) async {
    XFile? temp = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    setState(() {
      if (is10th) {
        _10thMarksheetImage = temp;
      } else {
        _12thMarksheetImage = temp;
      }
    });
    // _cropImage();
  }

  TextEditingController _searchTextEditingController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController branchController = TextEditingController();

  void onTextFieldTap() {
    DropDownState(
      DropDown(
        submitButtonText: 'Done',
        submitButtonColor: const Color.fromRGBO(70, 76, 222, 1),
        searchHintText: 'Type..',
        bottomSheetTitle: 'Search',
        searchBackgroundColor: Colors.black12,
        dataList: collegeList.map((e) => SelectedListItem(false, e)).toList(),
        selectedItems: (List<dynamic> selectedList) {
          // showSnackBar(selectedList.toString());
        },
        selectedItem: (String selected) {
          textEditingController.text = selected;
          // showSnackBar(selected);
          // widget.textEditingController.text = selected;
        },
        enableMultipleSelection: false,
        searchController: _searchTextEditingController,
      ),
    ).showModal(context);
  }

  void yearDropDown() {
    DropDownState(
      DropDown(
        submitButtonText: 'Done',
        submitButtonColor: const Color.fromRGBO(70, 76, 222, 1),
        searchHintText: 'Type..',
        bottomSheetTitle: 'Search',
        searchBackgroundColor: Colors.black12,
        dataList: year.map((e) => SelectedListItem(false, e)).toList(),
        selectedItems: (List<dynamic> selectedList) {
          // showSnackBar(selectedList.toString());
        },
        selectedItem: (String selected) {
          yearController.text = selected;
          // showSnackBar(selected);
          // widget.textEditingController.text = selected;
        },
        enableMultipleSelection: false,
        searchController: _searchTextEditingController,
      ),
    ).showModal(context);
  }

  void branchDropDown() {
    DropDownState(
      DropDown(
        submitButtonText: 'Done',
        submitButtonColor: const Color.fromRGBO(70, 76, 222, 1),
        searchHintText: 'Type..',
        bottomSheetTitle: 'Search',
        searchBackgroundColor: Colors.black12,
        dataList: branch.map((e) => SelectedListItem(false, e)).toList(),
        selectedItems: (List<dynamic> selectedList) {
          // showSnackBar(selectedList.toString());
        },
        selectedItem: (String selected) {
          branchController.text = selected;
          // showSnackBar(selected);
          // widget.textEditingController.text = selected;
        },
        enableMultipleSelection: false,
        searchController: _searchTextEditingController,
      ),
    ).showModal(context);
  }

  String? rollNo;
  bool isLoading = false;
  TextEditingController textEditingController = TextEditingController();
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
              onPressed: () async {
                if (_formkey.currentState!.validate()) {
                  setState(() {
                    isLoading = true;
                  });
                  final uid = FirebaseAuth.instance.currentUser!.uid;
                  // final ref = FirebaseStorage.instance
                  //     .ref()
                  //     .child("CustomerDP")
                  //     .child(uid)
                  //     .child("12Marksheet" ".jpg");
                  // await ref.putFile(File(_12thMarksheetImage!.path));
                  // final image12 = await ref.getDownloadURL();
                  // final ref2 = FirebaseStorage.instance
                  //     .ref()
                  //     .child("CustomerDP")
                  //     .child(uid)
                  //     .child("10Marksheet" ".jpg");
                  // await ref2.putFile(File(_10thMarksheetImage!.path));
                  // final image10 = await ref.getDownloadURL();
                  FirebaseDatabase.instance
                      .ref()
                      .child("User Information")
                      .child(uid)
                      .update({
                    // "12Marks": percent12th,
                    // "10Marks": percent10th,
                    "cYear": yearController.text,
                    "cBranch": branchController.text,
                    "nameOfCollege": textEditingController.text,
                    "rollNo": rollNo,
                    "isProfileCompleted": true
                  }).then((value) {
                    setState(() {
                      isLoading = false;
                    });
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext ctx) => TabPage()));
                  }).catchError((e) {
                    setState(() {
                      isLoading = false;
                    });
                    Fluttertoast.showToast(msg: e.toString());
                  });
                }
                //  else if (_formkey.currentState!.validate() &&
                //     (_10thMarksheetImage == null ||
                //         _12thMarksheetImage == null)) {
                //   Fluttertoast.showToast(msg: "Please upload marksheet photos");
                // }
              },
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(theme.colorPrimary),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)))),
              child: isLoading
                  ? SizedBox(
                      height: height * .04,
                      child: SpinKitThreeBounce(
                        size: 20,
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      "Submit",
                      style: TextStyle(fontSize: 18),
                    )),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Text('College Details'),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    // Text("Upload 10th Marksheet"),
                    // const SizedBox(
                    //   height: 15,
                    // ),
                    // InkWell(
                    //     onTap: () {
                    //       _showPicker(context, true);
                    //     },
                    //     child: _10thMarksheetImage == null
                    //         ? Container(
                    //             child: Center(
                    //               child: Icon(
                    //                 Icons.image,
                    //                 size: 50,
                    //               ),
                    //             ),
                    //             width: 350,
                    //             height: 200,
                    //             color: Colors.grey[350],
                    //           )
                    //         : Image.file(
                    //             File(_10thMarksheetImage!.path),
                    //             width: 350,
                    //             height: 200,
                    //             fit: BoxFit.contain,
                    //           )),
                    // const SizedBox(
                    //   height: 15,
                    // ),
                    // TextFormField(
                    //   keyboardType: TextInputType.number,
                    //   validator: (val) {
                    //     if (val!.isEmpty) {
                    //       return 'required';
                    //     } else if (double.tryParse(val) == null) {
                    //       return "Inavalid value";
                    //     } else if (double.tryParse(val) != null &&
                    //         double.parse(val) > 100) {
                    //       return "can't be greater than 100";
                    //     } else {
                    //       percent10th = val;
                    //       return null;
                    //     }
                    //   },
                    //   decoration: const InputDecoration(
                    //       floatingLabelBehavior: FloatingLabelBehavior.auto,
                    //       hintText: '10th Percentage (%)',
                    //       labelText: '10th Percentage (%)',
                    //       border: OutlineInputBorder()),
                    //   obscureText: false,
                    // ),
                    // const SizedBox(
                    //   height: 15,
                    // ),
                    // Text("Upload 12th Marksheet"),
                    // const SizedBox(
                    //   height: 15,
                    // ),
                    // InkWell(
                    //   onTap: () {
                    //     _showPicker(context, false);
                    //   },
                    //   child: Container(
                    //     child: _12thMarksheetImage == null
                    //         ? Container(
                    //             child: Center(
                    //               child: Icon(
                    //                 Icons.image,
                    //                 size: 50,
                    //               ),
                    //             ),
                    //             width: 350,
                    //             height: 200,
                    //             color: Colors.grey[350],
                    //           )
                    //         : Image.file(
                    //             File(_12thMarksheetImage!.path),
                    //             width: 350,
                    //             height: 200,
                    //             fit: BoxFit.contain,
                    //           ),
                    //   ),
                    // ),
                    // const SizedBox(
                    //   height: 15,
                    // ),
                    // TextFormField(
                    //   keyboardType: TextInputType.number,
                    //   validator: (val) {
                    //     if (val!.isEmpty) {
                    //       return 'required';
                    //     } else if (double.tryParse(val) == null) {
                    //       return "Inavalid value";
                    //     } else if (double.tryParse(val) != null &&
                    //         double.parse(val) > 100) {
                    //       return "can't be greater than 100";
                    //     } else {
                    //       percent12th = val;
                    //       return null;
                    //     }
                    //   },
                    //   decoration: const InputDecoration(
                    //       floatingLabelBehavior: FloatingLabelBehavior.auto,
                    //       hintText: '12th Percentage (%)',
                    //       labelText: '12th Percentage (%)',
                    //       border: OutlineInputBorder()),
                    //   obscureText: false,
                    // ),
                    // const SizedBox(
                    //   height: 15,
                    // ),
                    InkWell(
                      onTap: () {
                        onTextFieldTap();
                      },
                      child: TextFormField(
                        enabled: false,
                        controller: textEditingController,
                        onTap: () {},
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "required";
                          } else {
                            nameOfClg = val;
                            return null;
                          }
                        },
                        decoration: const InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            hintText: 'Name of College/Unversity',
                            labelText: 'Name of College/Unversity',
                            border: OutlineInputBorder()),
                        obscureText: false,
                      ),
                    ),
                    SizedBox(
                      height: height * .02,
                    ),
                    TextFormField(
                      textCapitalization: TextCapitalization.characters,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "required";
                        } else {
                          rollNo = val;
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          hintText: 'Roll no of College/Unversity',
                          labelText: 'Roll no of College/Unversity',
                          border: OutlineInputBorder()),
                      obscureText: false,
                    ),
                    SizedBox(
                      height: height * .02,
                    ),
                    InkWell(
                      onTap: () {
                        yearDropDown();
                      },
                      child: TextFormField(
                        enabled: false,
                        controller: yearController,
                        onTap: () {},
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "required";
                          } else {
                            cyear = val;
                            return null;
                          }
                        },
                        decoration: const InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            hintText: 'Year',
                            labelText: 'Year',
                            border: OutlineInputBorder()),
                        obscureText: false,
                      ),
                    ),
                    SizedBox(
                      height: height * .02,
                    ),
                    InkWell(
                      onTap: () {
                        branchDropDown();
                      },
                      child: TextFormField(
                        enabled: false,
                        controller: branchController,
                        textCapitalization: TextCapitalization.characters,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "required";
                          } else {
                            cbranch = val;
                            return null;
                          }
                        },
                        decoration: const InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            hintText: 'Branch',
                            labelText: 'Branch',
                            border: OutlineInputBorder()),
                        obscureText: false,
                      ),
                    ),
                  ],
                )),
          )),
        ),
      ),
    );
  }
}
