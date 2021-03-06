import 'package:collageezy/main.dart';
import 'package:collageezy/models/user_model.dart';
import 'package:collageezy/providers/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'models/chat_model.dart';

class Support extends StatefulWidget {
  @override
  _SupportState createState() => _SupportState();
}

class _SupportState extends State<Support> {
  List<ChatModel> list = [];
  var key;
  ChatModel? data;
  TextEditingController messageController = TextEditingController();
  String? uid;

  void stream() {
    final user = FirebaseAuth.instance.currentUser;

    final ref = FirebaseDatabase.instance
        .reference()
        .child("ChatRoom")
        .child(user!.uid)
        .onValue;
    ref.listen((event) {
      if (event.snapshot.value == null) {
        return;
      }
      final chatdata = event.snapshot.value as Map;

      list = [];
      chatdata.forEach((key, value) {
        list.add(
          ChatModel(
            uid: value['uid'],
            message: value['message'],
            dateTime: DateTime.parse(
              value['timeStamp'],
            ),
          ),
        );
      });
      setState(() {
        list.sort((a, b) => a.dateTime!.compareTo(b.dateTime!));
        final temp = list.reversed;
        list = [];
        temp.forEach((element) {
          list.add(element);
        });
      });
    });
  }

  UserInformation userInfo = UserInformation();
  @override
  initState() {
    userInfo = Provider.of<UserProvider>(context, listen: false).userInfo;
    // uid = userInfo.id;
    stream();
    super.initState();
  }

  sendMessage() async {
    final ref = FirebaseDatabase.instance
        .reference()
        .child("ChatRoom")
        .child(userInfo.id!);
    final key = ref.push().key;
    ref.child(key!).update({
      'message': messageController.text,
      "uid": userInfo.id,
      "timeStamp": DateTime.now().toIso8601String(),
      'Name': userInfo.name,
      "DpURL": userInfo.imageUrl,
    });
    messageController.text = '';
  }

  Widget chatMessageList() {
    return list != null
        ? Container(
            // height: MediaQuery.of(context).size.height * 0.9,
            child: ListView.builder(
                reverse: true,
                itemCount: list.length,
                itemBuilder: (context, index) => MessageTile(
                      message: list[index].message,
                      isSendByMe: list[index].uid == userInfo.id,
                    )),
          )
        : Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // bottomNavigationBar:
        // backgroundColor: Colors.blue[900],

        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.teal,
          ),
          backgroundColor: Colors.teal,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          centerTitle: true,
          title: Text(
            "Chat with us",
            style: GoogleFonts.workSans(),
          ),
          // backgroundColor: theme.colorBackground,
          elevation: 0.0,
        ),
        body: Column(
          children: [
            Expanded(
              child: chatMessageList(),
            ),
            Container(
              color: Colors.teal,
              child: Row(
                // mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * .75,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      child: TextField(
                        style: GoogleFonts.workSans(),
                        controller: messageController,
                        onChanged: (val) {
                          setState(() {});
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          hintText: 'Start Typing....',
                          hintStyle: GoogleFonts.workSans(),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  RawMaterialButton(
                    onPressed: () {
                      if (messageController.text == null ||
                          messageController.text == "") {
                        Fluttertoast.showToast(
                            msg: "Write some message!",
                            gravity: ToastGravity.BOTTOM);
                        return;
                      }
                      return sendMessage();
                    },
                    child: messageController.text == null ||
                            messageController.text == ""
                        ? Text('Send',
                            style: GoogleFonts.workSans(color: Colors.white))
                        : Icon(
                            Icons.send,
                            // color: theme.colorBackground,
                          ),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}

class MessageTile extends StatelessWidget {
  final bool? isSendByMe;
  final String? message;

  // ignore: prefer_const_constructors_in_immutables
  MessageTile({this.isSendByMe, this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: isSendByMe! ? MediaQuery.of(context).size.width * .2 : 24,
          right: isSendByMe! ? 24 : MediaQuery.of(context).size.width * .2),
      width: MediaQuery.of(context).size.width,
      alignment: isSendByMe! ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Container(
          decoration: BoxDecoration(
            color: theme.colorCompanion2,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
                bottomLeft:
                    isSendByMe! ? Radius.circular(50) : Radius.circular(0),
                bottomRight:
                    isSendByMe! ? Radius.circular(0) : Radius.circular(50)),
          ),
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Text(message!,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.white,
                )),
          ),
        ),
      ),
    );
  }
}
