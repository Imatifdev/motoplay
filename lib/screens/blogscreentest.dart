import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../utils/constanst.dart';

class BlogPostsScreen extends StatefulWidget {
  @override
  _BlogPostsScreenState createState() => _BlogPostsScreenState();
}

class _BlogPostsScreenState extends State<BlogPostsScreen> {
  List<dynamic> _posts = [];

  @override
  void initState() {
    super.initState();
    fetchBlogPosts();
  }

  Future<void> fetchBlogPosts() async {
    for (var blogId in blogIds) {
      final url =
          'https://www.googleapis.com/blogger/v3/blogs/$blogId/posts?key=$key';

      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _posts.addAll(data['items']);
        });
      } else {
        throw Exception('Failed to load blog posts');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blogger Posts'),
      ),
      body: ListView.builder(
        itemCount: _posts.length,
        itemBuilder: (context, index) {
          final post = _posts[index];
          return ListTile(
            title: Text(post['title']),
            subtitle: Text(post['published']),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlogPostDetailScreen(post: post),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class BlogPostDetailScreen extends StatelessWidget {
  final dynamic post;

  BlogPostDetailScreen({required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(post['title']),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Published: ${post['published']}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Image.network(
              post['images'][0]['url'], // Assuming there's at least one image
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 10),
            Text(
              post['content'], // This contains the HTML content of the post
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 10),
            Text('URL: ${post['url']}'),
            Text('Author: ${post['author']['displayName']}'),
            Text('Labels: ${post['labels'].join(', ')}'),
            Text('Replies: ${post['replies']['totalItems']}'),
          ],
        ),
      ),
    );
  }
}
