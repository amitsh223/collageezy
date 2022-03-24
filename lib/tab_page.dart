import 'dart:developer';

import 'package:collageezy/profile_menu.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class TabPage extends StatefulWidget {
  const TabPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  int selectedIndex = 0;
  List<Color> colors = [
    Colors.purple,
    Colors.pink,
    Colors.amber[600]!,
    Colors.teal,
    Colors.lightBlue
  ];
  // List<Widget> tabs=[
  //   Container(
  //     color: Color,
  //   )
  // ];
  @override
  void initState() {
    super.initState();
  }

  void _tabChanged(int index) {
    setState(() {
      selectedIndex = index;
    });
    log("Selected index $selectedIndex");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 14),
            child: GNav(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              duration: Duration(milliseconds: 800),
              gap: 8.5,
              tabs: [
                GButton(
                  iconActiveColor: Colors.purple,
                  iconColor: Colors.black,
                  textColor: Colors.purple,
                  backgroundColor: Colors.purple.withOpacity(.2),
                  iconSize: 24,
                  icon: LineIcons.home,
                  text: 'Home',
                ),
                GButton(
                  iconActiveColor: Colors.pink,
                  iconColor: Colors.black,
                  textColor: Colors.pink,
                  backgroundColor: Colors.pink.withOpacity(.2),
                  iconSize: 24,
                  icon: LineIcons.heart,
                  text: 'Likes',
                ),
                GButton(
                  iconActiveColor: Colors.amber[600],
                  iconColor: Colors.black,
                  textColor: Colors.amber[600],
                  backgroundColor: Colors.amber[600]!.withOpacity(.2),
                  iconSize: 24,
                  icon: LineIcons.search,
                  text: 'Search',
                ),
                GButton(
                  iconActiveColor: Colors.teal,
                  iconColor: Colors.black,
                  textColor: Colors.teal,
                  backgroundColor: Colors.teal.withOpacity(.2),
                  iconSize: 24,
                  icon: LineIcons.user,
                  text: 'Profile',
                )
              ],
              selectedIndex: selectedIndex,
              onTabChange: _tabChanged,
            ),
          ),
        ),
        body: AnimatedSwitcher(
          duration: Duration(milliseconds: 800),
          child: selectedIndex != 3
              ? AnimatedContainer(
                  duration: Duration(milliseconds: 800),
                  color: colors[selectedIndex],
                  child: Center(child: Text("Hello")),
                )
              : ProfileMenu(),
        ));
  }
}
