import 'dart:developer';

import 'package:collageezy/models/announcementModel.dart';
import 'package:collageezy/providers/announcement_post_provider.dart';
import 'package:collageezy/providers/user_provider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LikePage extends StatefulWidget {
  const LikePage({Key? key}) : super(key: key);

  @override
  State<LikePage> createState() => _LikePageState();
}

class _LikePageState extends State<LikePage> {
  List<AnnouncementModel> announcementList = [];
  List<AnnouncementModel> likedPost = [];
  @override
  void initState() {
    // getAnnouncements();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    likedPost =
        Provider.of<AnnouncementProvider>(context, listen: true).likedPost;
    final List<String> likedIds =
        Provider.of<AnnouncementProvider>(context, listen: true).likedListIds;
    final user = Provider.of<UserProvider>(context, listen: false).userInfo;
    log(likedPost.length.toString());
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
                Text("Following Annoucements",
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
                  itemCount: likedPost.length,
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
                                Text(likedPost[index].title ?? "",
                                    style: GoogleFonts.droidSerif(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700)),
                                IconButton(
                                  onPressed: () {
                                    FirebaseDatabase.instance
                                        .ref()
                                        .child("Following Announcements")
                                        .child(user.id.toString())
                                        .child(likedPost[index].id!)
                                        .once()
                                        .then((value) {
                                      if (value.snapshot.exists) {
                                        FirebaseDatabase.instance
                                            .ref()
                                            .child("Following Announcements")
                                            .child(user.id.toString())
                                            .child(likedPost[index].id!)
                                            .remove();
                                      } else {
                                        FirebaseDatabase.instance
                                            .ref()
                                            .child("Following Announcements")
                                            .child(user.id.toString())
                                            .update(
                                                {likedPost[index].id!: true});
                                      }
                                    });
                                  },
                                  icon: likedIds.contains(likedPost[index].id)
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
                            Text(
                              likedPost[index].summary ?? "",
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  likedPost[index].dateOfPublish ?? "",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                Text(
                                  likedPost[index].nameOfPublisher ?? "",
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
