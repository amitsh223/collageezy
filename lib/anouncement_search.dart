// ignore_for_file: prefer_const_constructors

import 'package:collageezy/models/announcementModel.dart';
import 'package:collageezy/models/jobModel.dart';
import 'package:collageezy/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../main.dart';

class AnouncementSearch extends SearchDelegate<String> {
  final List<AnnouncementModel> lb;
  AnouncementSearch({required this.lb});

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

  AnnouncementModel? resultChoosen;
  @override
  Widget buildResults(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return resultChoosen == null
        ? Center(
            child: Text("No Result Found"),
          )
        : Card(
            // ignore: prefer_const_constructors
            margin: EdgeInsets.symmetric(vertical: 10),
            elevation: 8,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(resultChoosen!.title ?? "",
                          style: GoogleFonts.droidSerif(
                              fontSize: 15, fontWeight: FontWeight.w700)),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      resultChoosen!.summary ?? "",
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        resultChoosen!.dateOfPublish ?? "",
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(
                        resultChoosen!.nameOfPublisher ?? "",
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  )
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
                element.title!.toLowerCase().contains(query.toLowerCase()))
            .toList();
    return suggestionList.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // ignore: prefer_const_literals_to_create_immutables
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
                          .title!
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
                              .title!
                              .substring(
                                  query.length,
                                  suggestionList
                                      .elementAt(index)
                                      .title!
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
