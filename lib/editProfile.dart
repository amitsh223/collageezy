import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String? name;
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
        elevation: 0,
        title: Text(
          "Profile",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Center(
              child: ClipOval(
                child: Image.asset(
                  "assets/user_avatar.png",
                  width: 130,
                  height: 130,
                  fit: BoxFit.fill,
                ),
              ),
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
            TextField(
              
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
            TextField(),
            SizedBox(
              height: 20,
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Enrollment No",
                  style: GoogleFonts.roboto(color: Colors.grey),
                )),
            TextField(),
            SizedBox(
              height: 20,
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "College Name",
                  style: GoogleFonts.roboto(color: Colors.grey),
                )),
            TextField()
          ],
        ),
      ),
    );
  }
}
