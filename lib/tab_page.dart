// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:collageezy/announcement.dart';
import 'package:collageezy/homeScreen.dart';
import 'package:collageezy/liked_page.dart';
import 'package:collageezy/models/jobModel.dart';

import 'package:collageezy/models/user_model.dart';

import 'package:collageezy/profile_menu.dart';
import 'package:collageezy/providers/announcement_post_provider.dart';
import 'package:collageezy/providers/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

import 'homeScreen.dart';

class TabPage extends StatefulWidget {
  final String? adhaarCardNo;
  const TabPage({Key? key, this.title, this.adhaarCardNo}) : super(key: key);

  final String? title;

  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  int selectedIndex = 0;
  List<Color> colors = [
    Colors.purple,
    Colors.pink,
    Colors.amber[600]!,
    Colors.teal,
    Colors.lightBlue
  ];
  // List<Widget> tabs=[
  //   Container(
  //     color: Color,
  //   )
  // ];
  getUserData() async {
    final data = await FirebaseDatabase.instance
        .ref()
        .child('User Information')
        .child(FirebaseAuth.instance.currentUser!.uid)
        .once();
    final userData = data.snapshot.value as Map;
    if (userData.isNotEmpty) {
      UserInformation user = UserInformation(
          percentage10: userData['10Marks'],
          city: userData['city'],
          name: userData['name'],
          // ignore: prefer_if_null_operators
          adhaarNo: userData['adhaarNo'] != null
              ? userData['adhaarNo']
              : 'not Available',
          dateOfBirth: userData['dob'],
          id: userData['uid'],
          imageUrl: userData['imageUrl'],
          phone: userData['phone'],
          state: userData['state'],
          percentage12: userData['12Marks'],
          clgName: userData['nameOfCollege'],
          isRegistrationCompleted: userData['isProfileCompleted'],
          rollNo: userData['rollNo'],
          // ignore: prefer_if_null_operators
          isAdhaarVerified: userData['isAdhaarVerified'] != null
              ? userData['isAdhaarVerified']
              : false);
      Provider.of<UserProvider>(context, listen: false).setUser(user);
    }
  }

  List<JobModel> jobList = [];
  getJobData() {
    FirebaseDatabase.instance.ref().child("Jobs").onValue.listen((event) {
      final data = event.snapshot.value as Map;
      if (data.isNotEmpty) {
        jobList = [];
        print(data.toString());
        data.forEach((key, value) {
          JobModel jobModel = JobModel(
              company: value['companyName'],
              salary: value['salary'],
              jobTitle: value['jobTitle'],
              expReq: 'Fresher',
              location: value['location'],
              isPartTime:
                  value['typeOfJob'] == 'Work from home' ? true : false);
          jobList.add(jobModel);
        });
        setState(() {
          log(jobList.length.toString());
        });
      }
    });
  }

  getAnnouncemets() {
    Provider.of<AnnouncementProvider>(context, listen: false)
        .updateAnnouncemnets();
  }
  getLikedPost(){
    Provider.of<AnnouncementProvider>(context, listen: false).updateLikedPost(FirebaseAuth.instance.currentUser!.uid);
  }

  pushAdhaarCard() {
    FirebaseDatabase.instance
        .ref()
        .child('User Information')
        .child(FirebaseAuth.instance.currentUser!.uid)
        .update({"adhaarNo": "995613926111"});
  }

  @override
  void initState() {
    // if (widget.adhaarCardNo!.isNotEmpty) {
    pushAdhaarCard();
    // }
    // log("Abcdef"+widget.adhaarCardNo.toString());
    getUserData();
    getJobData();
    getAnnouncemets();
    getLikedPost();
    super.initState();
  }

  void _tabChanged(int index) {
    setState(() {
      selectedIndex = index;
    });
    // log("Selected index $selectedIndex");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 14),
            child: GNav(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              duration: Duration(milliseconds: 800),
              gap: 5,
              tabs: [
                GButton(
                  iconActiveColor: Colors.purple,
                  iconColor: Colors.black,
                  textColor: Colors.purple,
                  backgroundColor: Colors.purple.withOpacity(.2),
                  iconSize: 24,
                  icon: LineIcons.home,
                  text: 'Home',
                ),
                GButton(
                  iconActiveColor: Colors.amber[600],
                  iconColor: Colors.black,
                  textColor: Colors.amber[600],
                  backgroundColor: Colors.amber[600]!.withOpacity(.2),
                  iconSize: 24,
                  icon: LineIcons.bullhorn,
                  text: 'Events',
                ),
                GButton(
                  iconActiveColor: Colors.pink,
                  iconColor: Colors.black,
                  textColor: Colors.pink,
                  backgroundColor: Colors.pink.withOpacity(.2),
                  iconSize: 24,
                  icon: LineIcons.heart,
                  text: 'Likes',
                ),
                GButton(
                  iconActiveColor: Colors.teal,
                  iconColor: Colors.black,
                  textColor: Colors.teal,
                  backgroundColor: Colors.teal.withOpacity(.2),
                  iconSize: 24,
                  icon: LineIcons.user,
                  text: 'Profile',
                )
              ],
              selectedIndex: selectedIndex,
              onTabChange: _tabChanged,
            ),
          ),
        ),
        body: AnimatedSwitcher(
          duration: Duration(milliseconds: 800),
          child: selectedIndex != 3
              ? selectedIndex == 0
                  ? HomeScreen(jobList)
                  : selectedIndex == 1
                      ? Announcement()
                      : LikePage()
              : ProfileMenu(),
        ));
  }
}
