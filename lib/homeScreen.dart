// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:collageezy/models/jobModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<JobModel> jobs = [
    JobModel(
        company: "Amazon",
        jobTitle: "Software Engineer",
        location: "Jaipur",
        isPartTime: false,
        expReq: "1",
        salary: "35000"),
    JobModel(
        company: "Snapdeal",
        jobTitle: "Software Engineer",
        location: "Jaipur",
        isPartTime: true,
        expReq: "1",
        salary: "30000"),
    JobModel(
        company: "Twitter",
        jobTitle: "Research Engineer",
        location: "Jaipur",
        isPartTime: true,
        expReq: "1",
        salary: "40000"),
    JobModel(
        company: "Google",
        jobTitle: "Software Engineer",
        location: "Jaipur",
        isPartTime: false,
        expReq: "1",
        salary: "50000"),
  ];

  

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
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
                  Text("Popular Jobs",
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
                    
                    itemCount: jobs.length,
                    itemBuilder: (BuildContext ctx, int index) {
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        elevation: 8,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(jobs[index].jobTitle ?? "",
                                    style: GoogleFonts.droidSerif(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700)),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.attach_money,
                                    color: Colors.orange,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(jobs[index].salary != null
                                      ? jobs[index].salary! + " per month"
                                      : "")
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Icon(Icons.location_on_outlined,
                                      color: Colors.orange),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(jobs[index].location ?? "")
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Icon(Icons.watch_later_outlined,
                                      color: Colors.orange),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(jobs[index].isPartTime == true
                                      ? "Part Time"
                                      : "Full Time")
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.work_outline_rounded,
                                          color: Colors.orange),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(jobs[index].expReq != null
                                          ? jobs[index].expReq! + " Year"
                                          : "")
                                    ],
                                  ),
                                  Text(jobs[index].company ?? "",
                                      style: GoogleFonts.droidSerif(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
