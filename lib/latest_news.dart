import 'package:collageezy/web_view_container.dart';
import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class LatestNews extends StatelessWidget {
  final _links =
      'https://deccan.news/microsoft-aicte-to-provide-skilled-students-in-next-technologies/';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(child: Expanded(child: WebViewContainer(_links))));
  }
}
