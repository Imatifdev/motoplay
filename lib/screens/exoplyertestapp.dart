import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class BlogProvider extends ChangeNotifier {
  List<Blog> _blogs = [];
  List<Blog> get blogs => _blogs;

  Future<void> fetchBlogs() async {
    final response = await http.get(
        Uri.parse('https://moto-play.visualmigration.com/public/api/blogs'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body)['data'];
      _blogs = jsonData.map((json) => Blog.fromJson(json)).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load blogs');
    }
  }
}

class BlogListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final blogProvider = Provider.of<BlogProvider>(context, listen: false);
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Blogs'),
      ),
      body: FutureBuilder(
        future: blogProvider.fetchBlogs(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return SizedBox(
              height: screenHeight / 3,
              width: screenWidth - 5,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: blogProvider.blogs.length,
                itemBuilder: (context, index) {
                  final blog = blogProvider.blogs[index];
                  return Container(
                      height: 400,
                      width: screenWidth / 1.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: screenHeight / 4.1,
                            width: screenWidth * .1,
                            child: CachedNetworkImage(
                              imageUrl:
                                  "https://moto-play.visualmigration.com/public/uploads/images/${blog.image}" ??
                                      '',
                              placeholder: (context, url) => SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: const CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            width: screenWidth / 1.5,
                            height: 60,
                            color: Colors.black.withOpacity(0.7),
                            child: Center(
                              child: Text(
                                blog.title ?? '',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                        ],
                      ));
                },
              ),
            );
          }
        },
      ),
    );
  }
}

class Blog {
  final int id;
  final String image;
  final String title;
  final String label;
  final String publishDate;
  final String location;
  final String? permalink;
  final String commentAllow;
  final String description;
  final String createdAt;
  final String updatedAt;

  Blog({
    required this.id,
    required this.image,
    required this.title,
    required this.label,
    required this.publishDate,
    required this.location,
    required this.permalink,
    required this.commentAllow,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
      id: json['id'],
      image: json['image'],
      title: json['title'],
      label: json['label'],
      publishDate: json['publish_date'],
      location: json['location'],
      permalink: json['Permalink'],
      commentAllow: json['comment_allow'],
      description: json['description'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
