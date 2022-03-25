import 'dart:developer';

import 'package:collageezy/models/announcementModel.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class AnnouncementProvider with ChangeNotifier {
  List<AnnouncementModel> announcementsList = [];
  List<AnnouncementModel> likedPost = [];
  List<String> likedListIds=[];

  updateLikedPost(String userId) {
    FirebaseDatabase.instance
        .ref()
        .child("Following Announcements")
        .child(userId)
        .onValue
        .listen((event) {
      final data = event.snapshot.value as Map;
      if (data.isNotEmpty) {
        likedPost = [];
        likedListIds=[];
        data.forEach((key, value) {
          likedListIds.add(key);
          FirebaseDatabase.instance
              .ref()
              .child("Announcement")
              .child(key)
              .once()
              .then((val) {
            if (val.snapshot.exists) {
              final Map announcementData = val.snapshot.value as Map;
              AnnouncementModel announcementModel = AnnouncementModel(
                id: key,
              title: announcementData['title'],
              summary: announcementData['summary'],
              description: announcementData['description'],
              nameOfPublisher: announcementData['creator'],
              dateOfPublish: DateFormat('dd-MM-yyyy')
                  .format(DateTime.parse(announcementData['date']))
              );
              // log(announcementModel.toString());
              likedPost.add(announcementModel);
            }
          });
          // likedPost.add(Fri)
        });

        notifyListeners();
      }
    });
  }

  updateAnnouncemnets() {
    // announcementsList=[];
    FirebaseDatabase.instance
        .ref()
        .child("Announcement")
        .onValue
        .listen((event) {
      final data = event.snapshot.value as Map;
      if (data.isNotEmpty) {
        announcementsList = [];
        data.forEach((key, value) {
          announcementsList.add(AnnouncementModel(
              id: key,
              title: value['title'],
              summary: value['summary'],
              description: value['description'],
              nameOfPublisher: value['creator'],
              dateOfPublish: DateFormat('dd-MM-yyyy')
                  .format(DateTime.parse(value['date']))
                  ));
        });

        notifyListeners();
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
