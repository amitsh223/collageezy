// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class ComunityScreen extends StatefulWidget {
  const ComunityScreen({Key? key}) : super(key: key);

  @override
  State<ComunityScreen> createState() => _ComunityScreenState();
}

class _ComunityScreenState extends State<ComunityScreen> {
  void _launchURL(String _url) async {
    if (!await launch(_url)) throw 'Could not launch $_url';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            'Community',
            style: GoogleFonts.workSans(color: Colors.black),
          ),
          // centerTitle: true,
          backgroundColor: Colors.white),
      body: SafeArea(
        child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            InkWell(
              onTap: () {
                _launchURL('https://discord.gg/7Q9YucNN');
              },
              child: Card(
                child: ListTile(
                    title: Text('Discord'),
                    leading: Icon(
                      Icons.discord_rounded,
                      color: Color.fromARGB(255, 132, 100, 245),
                    )),
              ),
            ),
            InkWell(
              onTap: () {
                _launchURL('https://t.me/earnMoneyDealz');
              },
              child: Card(
                child: ListTile(
                  title: Text('Telegram'),
                  leading: Icon(
                    Icons.telegram,
                    color: Colors.blue,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
