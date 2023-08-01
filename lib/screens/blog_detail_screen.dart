import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class BlogDetailsScreen extends StatelessWidget {
  final Map<String, String?> post;

  BlogDetailsScreen({required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(post["title"] ?? ''),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 8),
              HtmlWidget(post["content"] ??
                  ''), // Use HtmlWidget to render HTML content
            ],
          ),
        ),
      ),
    );
  }
}
