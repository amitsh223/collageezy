import 'dart:developer';

import 'package:collageezy/models/announcementModel.dart';
import 'package:collageezy/providers/announcement_post_provider.dart';
import 'package:collageezy/providers/user_provider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Announcement extends StatefulWidget {
  const Announcement({Key? key}) : super(key: key);

  @override
  State<Announcement> createState() => _AnnouncementState();
}

class _AnnouncementState extends State<Announcement> {
  List<AnnouncementModel> announcementList = [];

  @override
  void initState() {
    getAnnouncements();
    // TODO: implement initState
    super.initState();
  }

  getAnnouncements() {
    Provider.of<AnnouncementProvider>(context, listen: false)
        .updateAnnouncemnets();
  }

  @override
  Widget build(BuildContext context) {
    announcementList = Provider.of<AnnouncementProvider>(context, listen: true)
        .announcementsList;
    final List<AnnouncementModel> likedList =
        Provider.of<AnnouncementProvider>(context, listen: true).likedPost;
    final user = Provider.of<UserProvider>(context, listen: false).userInfo;
    final List<String> likedIds =
        Provider.of<AnnouncementProvider>(context, listen: true).likedListIds;
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Row(children: [
              SizedBox(
                  height: 50,
                  width: 50,
                  child: Image.asset("assets/appIcon.png")),
              SizedBox(
                width: 10,
              ),
              Text("Collageezy", style: GoogleFonts.droidSerif(fontSize: 22))
            ]),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: TextField(
                decoration: InputDecoration(
                    hintText: "Search",
                    prefixIcon: Icon(
                      Icons.search,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey))),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Announcements",
                    style: GoogleFonts.droidSerif(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                IconButton(onPressed: () {}, icon: Icon(Icons.tune))
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: announcementList.length,
                  itemBuilder: (BuildContext ctx, int index) {
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      elevation: 8,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(announcementList[index].title ?? "",
                                    style: GoogleFonts.droidSerif(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700)),
                                IconButton(
                                  onPressed: () {
                                    FirebaseDatabase.instance
                                        .ref()
                                        .child("Following Announcements")
                                        .child(user.id.toString())
                                        .child(announcementList[index].id!)
                                        .once()
                                        .then((value) {
                                      if (value.snapshot.exists) {
                                        FirebaseDatabase.instance
                                            .ref()
                                            .child("Following Announcements")
                                            .child(user.id.toString())
                                            .child(announcementList[index].id!)
                                            .remove();
                                      } else {
                                        FirebaseDatabase.instance
                                            .ref()
                                            .child("Following Announcements")
                                            .child(user.id.toString())
                                            .update({
                                          announcementList[index].id!: true
                                        }).then((value) {
                                          setState(() {
                                            announcementList[index].isLiked =
                                                !announcementList[index]
                                                    .isLiked!;
                                          });
                                        });
                                      }
                                    });
                                  },
                                  icon: likedIds
                                          .contains(announcementList[index].id)
                                      ? Icon(
                                          Icons.favorite,
                                          color: Colors.pink,
                                        )
                                      : Icon(
                                          Icons.favorite_border,
                                        ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                announcementList[index].summary ?? "",
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  announcementList[index].dateOfPublish ?? "",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                Text(
                                  announcementList[index].nameOfPublisher ?? "",
                                  style: TextStyle(color: Colors.grey),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    ));
  }
}
