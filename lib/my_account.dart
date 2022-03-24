import 'package:collageezy/editProfile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({Key? key}) : super(key: key);

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
              onTap: () {},
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
