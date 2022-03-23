import 'package:collageezy/splesh_screen.dart';
import 'package:collageezy/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

AppThemeData theme = AppThemeData();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: HexColor('70c4bc'), // status bar color
    ),
  );

  //  theme.init();
  await Firebase.initializeApp();
  // await Firebase.initializeApp(
  //     options: const FirebaseOptions(
  //   apiKey: 'AIzaSyApKEKKagOrxT01UJI-4OXFdlx9EhVjHLs',
  //   appId: '1:122672089783:android:1bf60542f06601b9b45b32',
  //   messagingSenderId: '122672089783',
  //   projectId: 'collegeeasy-28a78',
  // ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Admin',
        home: SplashScreen());
  }
}