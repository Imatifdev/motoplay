import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:motplay/screens/exoplyertestapp.dart';
import 'package:html_parser_plus/html_parser_plus.dart';

class BlogApiDetailsScreen extends StatelessWidget {
  final Blog post;

  BlogApiDetailsScreen({required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(post.title),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
            height: 900,
            width: 400,
            child: ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: [HtmlWidget(post.description)])),
      ),
    );
  }
}
