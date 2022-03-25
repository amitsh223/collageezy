import 'package:collageezy/models/announcementModel.dart';
import 'package:collageezy/providers/announcement_post_provider.dart';
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
  @override
  void initState() {
    getAnnouncements();
    // TODO: implement initState
    super.initState();
  }

  getAnnouncements() {
    Provider.of<AnnouncementProvider>(context, listen: false)
        .updateAnnouncemnets();
    announcementList = Provider.of<AnnouncementProvider>(context, listen: false)
        .getAnnouncementList();
  }

  @override
  Widget build(BuildContext context) {
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
                                    setState(() {
                                      announcementList[index].isLiked =
                                          !announcementList[index].isLiked!;
                                    });
                                  },
                                  icon: announcementList[index].isLiked!
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
                              announcementList[index].summary ?? "",
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
