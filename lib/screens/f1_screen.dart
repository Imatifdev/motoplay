import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as htmlParser;
import 'package:flutter/material.dart';
import 'package:motplay/utils/constanst.dart';

import 'blog_detail_screen.dart';

class F1Screen extends StatefulWidget {
  @override
  State<F1Screen> createState() => _F1ScreenState();
}

class _F1ScreenState extends State<F1Screen> {
  List<Map<String, String?>> f1List = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchPosts(blogIds[0], key);
  }

  Future<void> fetchPosts(String blogId, String apiKey) async {
    setState(() {
      isLoading = true;
    });
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
            isLoading = false;
          });
        }
      } else {
        // Handle invalid API response
        setState(() {
          isLoading = false;
        });
        print('Invalid API response: items not found');
      }
    } else {
      // Handle HTTP request error
      setState(() {
        isLoading = false;
      });
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
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
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
      height: (300 * blogs.length).toDouble(),
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
                width: screenWidth - 10,
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
                        width: screenWidth - 20,
                        height: 60,
                        color: Colors.black.withOpacity(0.5),
                        child: Center(
                          child: Text(
                            post["title"] ?? '',
                            softWrap: true,
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

