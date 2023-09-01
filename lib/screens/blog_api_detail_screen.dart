import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:motplay/screens/exoplyertestapp.dart';

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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 8),
              CachedNetworkImage(imageUrl: "https://moto-play.visualmigration.com/public/uploads/images/${post.image}"),
              HtmlWidget(post.description),
            ],
          ),
        ),
      ),
    );
  }
}
