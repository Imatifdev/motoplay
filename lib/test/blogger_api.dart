import 'package:blogger_api/blogger_api.dart';
import 'package:flutter/material.dart';
import 'package:motplay/test/pages_view.dart';
import 'package:motplay/test/post_page.dart';

import '../utils/constanst.dart';

class BloggerAPIScreen extends StatefulWidget {
  const BloggerAPIScreen({super.key});

  @override
  State<BloggerAPIScreen> createState() => _BloggerAPIScreenState();
}

class _BloggerAPIScreenState extends State<BloggerAPIScreen> {
  Future<List<BlogsModel>> getAllBlogs() async {
    final res = await BloggerAPI().getAllBlogs(apiKey: key, blogId: blogIds);

    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: FutureBuilder<List<BlogsModel>>(
        future: getAllBlogs(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text('Try Again'),
            );
          } else {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Container(
                        height: 200,
                        padding: const EdgeInsets.all(8.0),
                        width: 200,
                        child: Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                                'Blog ${index + 1} - ${snapshot.data![index].name}'),
                            const SizedBox(
                              height: 20,
                            ),
                            ElevatedButton.icon(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PostPage(
                                              blogId: blogIds[index],
                                              apiKey: key,
                                            )),
                                  );
                                },
                                icon: const Icon(Icons.post_add),
                                label: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('Posts'),
                                )),
                            const SizedBox(
                              height: 20,
                            ),
                            ElevatedButton.icon(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PagesView(
                                              blogId: blogIds[index],
                                              apiKey: key,
                                            )),
                                  );
                                },
                                icon: const Icon(Icons.pages),
                                label: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('Pages'),
                                ))
                          ],
                        ))),
                  );
                });
          }
        }),
      )),
    );
  }
}
