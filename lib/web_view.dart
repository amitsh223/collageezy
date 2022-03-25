import 'package:collageezy/web_view_container.dart';
import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class TrainingVideos extends StatelessWidget {
  final _links = 'https://www.aicte-india.org/news-video';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child:  Expanded(child: WebViewContainer(_links))));
  }
}
