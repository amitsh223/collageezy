import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class AppThemeData extends ChangeNotifier {
  Color colorPrimary = HexColor("#ffa83c");
  Color colorCompanion = HexColor('F31654');
  Color colorCompanion2 = HexColor('7E4288');
  Color colorCompanion3 = HexColor('7E4288');
  Color colorCompanion4 = HexColor('B760C8');
  Color chatsend = HexColor('D9F8C4');
  Color chatrevieve = HexColor('E8E8E8');
  Color chatbg = HexColor('B760C8');
  Color status = HexColor('00eaff');
}
