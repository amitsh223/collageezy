import 'dart:developer';

import 'package:collageezy/models/announcementModel.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

class AnnouncementProvider with ChangeNotifier {
  List<AnnouncementModel> announcementsList = [];
  List<AnnouncementModel> likedPost = [];
  List<AnnouncementModel> tempList = [
    AnnouncementModel(
        title: "Upcoming: SIH Prelim Rounds",
        dateOfPublish: "15-March-2022",
        summary:
            "This March, Team JECRC presents Smart India Hackathon 5.0 which brings the opportunity to innovate your coding skills and create a better future. Embrace yourself for the coding event on the 25th and 26th of March.",
        nameOfPublisher: "Amit Upadhay",
        isLiked: true,
        description:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
    AnnouncementModel(
        title: "Upcoming: SIH Prelim Rounds",
        dateOfPublish: "1-March-2022",
        summary:
            "This March, Team JECRC presents Smart India Hackathon 5.0 which brings the opportunity to innovate your coding skills and create a better future. Embrace yourself for the coding event on the 25th and 26th of March.",
        nameOfPublisher: "Anurag Toshniwal",
        isLiked: false,
        description:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
    AnnouncementModel(
        title: "Upcoming: SIH Prelim Rounds",
        dateOfPublish: "15-Feb-2022",
        summary:
            "This March, Team JECRC presents Smart India Hackathon 5.0 which brings the opportunity to innovate your coding skills and create a better future. Embrace yourself for the coding event on the 25th and 26th of March.",
        nameOfPublisher: "Amit Tiwari",
        isLiked: false,
        description:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
  ];

  updateAnnouncemnets() {
    FirebaseDatabase.instance
        .ref()
        .child("Announcement")
        .onValue
        .listen((event) {
      final data = event.snapshot.value as Map;
      if (data.isNotEmpty) {
        log(data.toString());
        data.forEach((key, value) {
          log(value.toString());
        });
        // jobList = [];
        // print(data.toString());
        // data.forEach((key, value) {
        //   JobModel jobModel = JobModel(
        //       company: value['companyName'],
        //       salary: value['salary'],
        //       jobTitle: value['jobTitle'],
        //       expReq: 'Fresher',
        //       location: value['location'],
        //       isPartTime:
        //           value['typeOfJob'] == 'Work from home' ? true : false);
        //   jobList.add(jobModel);
        // });
        // setState(() {
        //   log(jobList.length.toString());
        // });
      }
    });
  }

  addLikedPost(AnnouncementModel announcement) {
    if (!likedPost.contains(announcement)) {
      likedPost.add(announcement);
    }
    notifyListeners();
  }

  removeLikedPost(AnnouncementModel announcement) {
    if (!likedPost.contains(announcement)) {
      if (!likedPost.contains(announcement)) {
        likedPost.add(announcement);
      }
    }

    notifyListeners();
  }

  getAnnouncementList() {
    return announcementsList;
  }
}
