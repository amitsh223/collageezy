import 'package:collageezy/models/user_model.dart';
import 'package:collageezy/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String? name = "Mahesh Kumar";
  String? contact = "9876543210";
  String? enrollmentNo = "19EJCCS023";
  String? collegeName = "Jaipur Engineering College And Research Center";
  String? adhaarNo = "123412341234";

  late UserInformation user;
  @override
  void initState() {
    user = Provider.of<UserProvider>(context, listen: false).userInfo;
    name = user.name;
    contact = user.phone;
    enrollmentNo = user.rollNo;
    collegeName = user.clgName;
    adhaarNo = user.adhaarNo;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
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
        elevation: 0,
        title: Text(
          "Profile",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              CircleAvatar(
                radius: width * .2,
                backgroundImage: NetworkImage(user.imageUrl!),
              ),
              SizedBox(
                height: 30,
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Name",
                    style: GoogleFonts.roboto(color: Colors.grey),
                  )),
              TextFormField(
                enabled: false,
                initialValue: name,
              ),
              SizedBox(
                height: 20,
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Contact",
                    style: GoogleFonts.roboto(color: Colors.grey),
                  )),
              TextFormField(
                enabled: false,
                initialValue: contact,
              ),
              SizedBox(
                height: 20,
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Enrollment No",
                    style: GoogleFonts.roboto(color: Colors.grey),
                  )),
              TextFormField(
                enabled: false,
                initialValue: enrollmentNo,
              ),
              // ignore: prefer_const_constructors
              SizedBox(
                height: 20,
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "College Name",
                    style: GoogleFonts.roboto(color: Colors.grey),
                  )),
              TextFormField(
                enabled: false,
                initialValue: collegeName,
              ),
              // ignore: prefer_const_constructors
              SizedBox(
                height: 20,
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Adhaar Number",
                    style: GoogleFonts.roboto(color: Colors.grey),
                  )),
              TextFormField(
                enabled: false,
                initialValue: adhaarNo,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
