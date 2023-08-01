import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as htmlParser;
import 'package:blogger_api/blogger_api.dart';
import 'package:flutter/material.dart';
import 'package:motplay/utils/constanst.dart';

class MotoGp extends StatefulWidget {
  @override
  State<MotoGp> createState() => _MotoGpState();
}

class _MotoGpState extends State<MotoGp> {
  List<Map<String, String?>> f1List = [];

  @override
  void initState() {
    super.initState();
    fetchPosts(blogIds[0], key);
  }

  Future<void> fetchPosts(String blogId, String apiKey) async {
    String url =
        'https://www.googleapis.com/blogger/v3/blogs/$blogId/posts?key=$apiKey';
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = jsonDecode(response.body);

      if (jsonData.containsKey('items') && jsonData['items'] is List) {
        List<dynamic> items = jsonData['items'];
        for (var item in items) {
          String? title = item['title'];
          String? content = item['content'];
          String? published = item['published'];
          String? updated = item['updated'];

          // Use the html package to parse the HTML content
          final document = htmlParser.parse(content);
          final imageElement = document.querySelector('img');
          String? imageLink = imageElement?.attributes['src'];

          Map<String, String?> post = {
            'title': title,
            'content': content,
            'published': published,
            'updated': updated,
            'imageLink': imageLink, // Add the image link to the map
          };

          setState(() {
            if (title != null && title.contains('F1')) {
              f1List.add(post);
            }
          });
        }
      } else {
        // Handle invalid API response
        print('Invalid API response: items not found');
      }
    } else {
      // Handle HTTP request error
      print('HTTP request failed with status code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('F1 Blogs'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            blogListWidget(screenWidth, f1List),
          ],
        ),
      ),
    );
  }

  // ... (previous code)

  Widget blogListWidget(double screenWidth, List<Map<String, String?>> blogs) {
    return SizedBox(
      height: 1000,
      width: screenWidth - 5,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: blogs.length,
        itemBuilder: (context, index) {
          Map<String, String?> post =
              blogs[index]; // Explicitly cast to Map<String, String?>
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlogDetailsScreen(post: post),
                  ),
                );
              },
              child: Container(
                height: 300,
                width: screenWidth - 5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      child: SizedBox(
                        height: 300,
                        width: screenWidth,
                        child: Image.network(
                          post["imageLink"] ?? '',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        width: screenWidth,
                        height: 60,
                        color: Colors.black.withOpacity(0.5),
                        child: Center(
                          child: Text(
                            post["title"] ?? '',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
// ... (rest of the code)

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
              if (post["imageLink"] != null)
                Image.network(
                  post["imageLink"]!,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              SizedBox(height: 16),
              Text(
                post["title"] ?? '',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(post["content"] ?? ''),
            ],
          ),
        ),
      ),
    );
  }
}
