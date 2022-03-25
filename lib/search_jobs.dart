import 'package:collageezy/models/jobModel.dart';
import 'package:collageezy/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../main.dart';

class searchLabourer extends SearchDelegate<String> {
  final List<JobModel> lb;
  searchLabourer({required this.lb});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext contexntext) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.of(contexntext).pop();
      },
    );
  }

  JobModel? resultChoosen;
  @override
  Widget buildResults(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return resultChoosen == null
        ? Center(
            child: Text("No Result Found"),
          )
        : Card(
            margin: EdgeInsets.symmetric(vertical: 10),
            elevation: 16,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(resultChoosen!.jobTitle ?? "",
                        style: GoogleFonts.droidSerif(
                            fontSize: 15, fontWeight: FontWeight.w700)),
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
                      Text(resultChoosen!.salary != null
                          ? resultChoosen!.salary! + " per month"
                          : "")
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined, color: Colors.orange),
                      SizedBox(
                        width: 5,
                      ),
                      Text(resultChoosen!.location ?? "")
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Icon(Icons.watch_later_outlined, color: Colors.orange),
                      SizedBox(
                        width: 5,
                      ),
                      Text(resultChoosen!.isPartTime == true
                          ? "Part Time"
                          : "Full Time")
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.work_outline_rounded,
                              color: Colors.orange),
                          SizedBox(
                            width: 5,
                          ),
                          Text(resultChoosen!.expReq != null
                              ? resultChoosen!.expReq!
                              : "")
                        ],
                      ),
                      Text(resultChoosen!.company ?? "",
                          style: GoogleFonts.droidSerif(
                              fontSize: 14, fontWeight: FontWeight.w700)),
                    ],
                  ),
                ],
              ),
            ),
          );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? lb
        : lb
            .where((element) =>
                element.jobTitle!.toLowerCase().contains(query.toLowerCase()))
            .toList();
    return suggestionList.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.warning,
                  size: 65,
                ),
                Center(
                  child: Text(
                    "No result found.\nCheck spelling and try again.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          )
        : ListView.builder(
            itemCount: suggestionList.length,
            itemBuilder: (context, index) => Card(
              child: ListTile(
                onTap: () {
                  resultChoosen = suggestionList.elementAt(index);
                  showResults(context);
                },
                title: RichText(
                  text: TextSpan(
                      text: suggestionList
                          .elementAt(index)
                          .jobTitle!
                          .substring(0, query.length),
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      children: [
                        TextSpan(
                          text: suggestionList
                              .elementAt(index)
                              .jobTitle!
                              .substring(
                                  query.length,
                                  suggestionList
                                      .elementAt(index)
                                      .jobTitle!
                                      .length),
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 20,
                          ),
                        )
                      ]),
                ),
              ),
            ),
          );
  }
}
