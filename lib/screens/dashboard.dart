import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as htmlParser;
import 'package:blogger_api/blogger_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motplay/screens/configration.dart';
import 'package:motplay/screens/dmca.dart';
import 'package:motplay/screens/privacy-policy.dart';
import '../test/html_view.dart';
import '../utils/constanst.dart';
import '../utils/mycolors.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

int selectedButton = 1;

class _DashboardState extends State<Dashboard> {
  List<Map<String, String?>> posts = [];
  List<Map<String, String?>> gpList = [];
  List<Map<String, String?>> f1List = [];

  @override
  void initState() {
    super.initState();
    fetchPosts(blogIds[0], key);
  }

  Future<PostModel> getAllpost() async {
    final res = await BloggerAPI().getAllPostFromBlog(
      includeComment: true,
      blogId: blogIds[0],
      apiKey: key,
    );
    return res;
  }

  Future<Map<String, String?>?> fetchPosts(String blogId, String apiKey) async {
  String url = 'https://www.googleapis.com/blogger/v3/blogs/$blogId/posts?key=$apiKey';
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
          posts.add(post);
        });
      }
      for (var post in posts) {
        String? title = post['title'];
               if (title != null) {
                  if (title.contains('GP')) {
                   setState(() {
                     gpList.add(post);
                   });
                  }
                  if (title.contains('F1')) {
                    setState(() {
                      f1List.add(post);
                    });
                  }
                }
      }
      return posts[1];
    } else {
      // Handle invalid API response
      print('Invalid API response: items not found');
    }
  } else {
    // Handle HTTP request error
    print('HTTP request failed with status code: ${response.statusCode}');
  }

  // Return null in case of an error
  return null;
}
  
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    // Adjust font size based on screen width and text scale factor
    //final fontSize = screenWidth * 0.14 * textScaleFactor;
    //final subheading = screenWidth * 0.07 * textScaleFactor;
    final heading = screenWidth * 0.14 * textScaleFactor;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: blue,
        elevation: 0,
        title: ElevatedButton(
            onPressed: () async {
             Map? map = await fetchPosts(blogIds[0], key); 
             print(map!['imageLink']); 
             print(posts);
              //for(Map post in posts){
              //print(posts);
              //}
              //imgLink();
            },
            child: const Text("API Call")),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "MOTOPLAY",
                    style: TextStyle(fontSize: 31, color: Colors.black),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      CupertinoIcons.left_chevron,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: blue,
              height: 20,
            ),
            const ListTile(
              leading: Icon(Icons.home),
              title: Text(
                "Home",
                style: TextStyle(fontSize: 23, color: blue),
              ),
            ),
            const Divider(
              height: 0,
              thickness: 0.5,
            ),
            ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (ctx) => const Configration()));
              },
              leading: const Icon(Icons.settings),
              title: const Text(
                "Configration",
                style: TextStyle(fontSize: 23, color: blue),
              ),
            ),
            const Divider(
              height: 0,
              thickness: 0.5,
            ),
            const ListTile(
              leading: ImageIcon(AssetImage("assets/images/icons7.png")),
              title: Text(
                "Donación",
                style: TextStyle(fontSize: 23, color: blue),
              ),
            ),
            const Divider(
              height: 0,
              thickness: 0.5,
            ),
            const ListTile(
              leading: ImageIcon(AssetImage("assets/images/icon3.png")),
              title: Text(
                "Repeticiones f1ss",
                style: TextStyle(fontSize: 23, color: blue),
              ),
            ),
            const Divider(
              height: 0,
              thickness: 0.5,
            ),
            const ListTile(
              leading: ImageIcon(AssetImage("assets/images/icon3.png")),
              title: Text(
                "Repeticiones  MotoGP",
                style: TextStyle(fontSize: 23, color: blue),
              ),
            ),
            const Divider(
              height: 0,
              thickness: 0.5,
            ),
            const ListTile(
              leading: Icon(Icons.restore_outlined),
              title: Text(
                "Últimas Actualizaciones",
                style: TextStyle(fontSize: 23, color: blue),
              ),
            ),
            const Divider(
              height: 0,
              thickness: 0.5,
            ),
            const ListTile(
              leading: ImageIcon(AssetImage("assets/images/icon1.png")),
              title: Text(
                "Redes Sociales",
                style: TextStyle(fontSize: 23, color: blue),
              ),
            ),
            const Divider(
              height: 0,
              thickness: 0.5,
            ),
            const ListTile(
              leading: Icon(Icons.notification_important_outlined),
              title: Text(
                "Configurar las Notificaciones",
                style: TextStyle(fontSize: 23, color: blue),
              ),
            ),
            const Divider(
              height: 0,
              thickness: 0.5,
            ),
            ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (ctx) => PrivacyPolicyScreen()));
              },
              leading: const ImageIcon(AssetImage("assets/images/icon2.png")),
              title: const Text(
                "Politicas de Privacidad",
                style: TextStyle(fontSize: 23, color: blue),
              ),
            ),
            const Divider(
              height: 0,
              thickness: 0.5,
            ),
            const ListTile(
              leading: Icon(Icons.screen_share_rounded),
              title: Text(
                "Comparitir App",
                style: TextStyle(fontSize: 23, color: blue),
              ),
            ),
            const Divider(
              height: 0,
              thickness: 0.5,
            ),
            const ListTile(
              leading: ImageIcon(AssetImage("assets/images/icon5.png")),
              title: Text(
                "Acerca de la App",
                style: TextStyle(fontSize: 23, color: blue),
              ),
            ),
            const Divider(
              height: 0,
              thickness: 0.5,
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (ctx) => DMCA()));
              },
              leading: const ImageIcon(AssetImage("assets/images/icon4.png")),
              title: const Text(
                "DMCA ",
                style: TextStyle(fontSize: 23, color: blue),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(children: [
            Container(
              width: screenWidth,
              height: screenHeight * 0.12,
              decoration: BoxDecoration(color: blue, boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 10.0,
                  spreadRadius: 2.0,
                  offset: const Offset(0, 3),
                ),
              ]),
              child: Column(
                children: [
                  Text(
                    "MOTOPLAY",
                    style: TextStyle(fontSize: heading, color: Colors.white),
                  )
                ],
              ),
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Container(
              width: screenWidth,
              height: screenHeight * 0.03,
              decoration: BoxDecoration(color: blue, boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 10.0,
                  spreadRadius: 2.0,
                  offset: const Offset(0, 3), // Horizontal and vertical offset
                ),
              ]),
              child: const Column(
                children: [],
              ),
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     ElevatedButton(
            //       onPressed: () {
            //         // setState(() {
            //         //   selectedButton = 1;
            //         // });
            //       },
            //       child: const Text('Button 1'),
            //     ),
            //     const SizedBox(width: 10),
            //     ElevatedButton(
            //       onPressed: () {
            //         // setState(() {
            //         //   selectedButton = 2;
            //         // });
            //       },
            //       child: const Text('Button 2'),
            //     ),
            //     const SizedBox(width: 10),
            //     ElevatedButton(
            //       onPressed: () {
            //         // setState(() {
            //         //   selectedButton = 3;
            //         // });
            //       },
            //       child: const Text('Button 3'),
            //     ),
            //   ],
            // ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(5)
                ),
                width: double.infinity,
                height: screenHeight / 3.5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: 15.0, horizontal: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 70,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset("assets/images/f1.png"),
                                const Text(
                                  "GB Hungria",
                                  style: TextStyle(fontSize: 21),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 70,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Image.asset("assets/images/txt.png"),
                                const SizedBox(height: 10),
                                const Text(
                                  "Finalizado",
                                  style: TextStyle(fontSize: 21),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 70,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset("assets/images/gun.png"),
                                const Text(
                                  "Carrera",
                                  style: TextStyle(fontSize: 21),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      SizedBox(
                          height: screenHeight / 6.9,
                          width: screenWidth / 3.3,
                          child: Card(
                            color: Colors.blue.shade300,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset("assets/images/cup.png"),
                                const Text("Formula 1", style: TextStyle(fontSize: 18),)
                                ]
                            ),
                          )),
                      SizedBox(
                          height: screenHeight / 6.9,
                          width: screenWidth / 3.3,
                          child: Card(
                            color: Colors.blue.shade300,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset("assets/images/handle.png"),
                                const Text("ENV VIVO", style: TextStyle(fontSize: 18),)
                                ]
                            ),
                          )),
                      SizedBox(
                          height: screenHeight / 6.9,
                          width: screenWidth / 3.3,
                          child: Card(
                            color: Colors.blue.shade300,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset("assets/images/cal.png"),
                                Text(" ${DateTime.now().day} / ${DateTime.now().month} / ${DateTime.now().year}", style: const TextStyle(fontSize: 18),)
                                ]
                            ),
                          )),
                    ])
                  ]),
                ),
              ),
            ),
            const Padding(
              padding:  EdgeInsets.all(8.0),
              child:  Align(
                alignment: Alignment.centerLeft,
                child: Text("Latest Updates", style: TextStyle(fontSize: 20),)),
            ),
            blogListWidget(screenWidth, posts),
            const Padding(
              padding:  EdgeInsets.all(8.0),
              child:  Align(
                alignment: Alignment.centerLeft,
                child: Text("Moto GP", style: TextStyle(fontSize: 20),)),
            ),
            blogListWidget(screenWidth, gpList),
            const Padding(
              padding:  EdgeInsets.all(8.0),
              child:  Align(
                alignment: Alignment.centerLeft,
                child: Text("F1 (R)", style: TextStyle(fontSize: 20),)),
            ),
            blogListWidget(screenWidth, f1List),
          //   SizedBox(
          //   height: 300,
          //   width: screenWidth-20,
          //   child: ListView.builder(
          //     //physics: const NeverScrollableScrollPhysics(),
          //     scrollDirection: Axis.horizontal,
          //     itemCount: f1List.length,
          //     itemBuilder: (context, index) { 
          //       Map post = f1List[index];
          //       return Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: FutureBuilder(
          //            future:getAllpost(),
          //           builder: ((context, snapshot){
          //       if (snapshot.connectionState == ConnectionState.waiting) {
          //         return const Padding(
          //           padding: EdgeInsets.all(8.0),
          //           child: Center(
          //             child: CircularProgressIndicator(),
          //           ),
          //         );
          //       }
          //       if (snapshot.hasError) {
          //         return const Padding(
          //           padding: EdgeInsets.all(8.0),
          //           child: Center(
          //             child: Text('Try Again'),
          //           ),
          //         );
          //       } else {
          //         return InkWell(
          //             onTap: () {
          //                         Navigator.push(
          //                           context,
          //                           MaterialPageRoute(
          //                               builder: (context) => HTMLVIew(
          //                                     data: snapshot.data!.items![index],
          //                                   )),
          //                         );
          //                       },
          //             child: Container(
          //               height: 300,
          //               width: screenWidth-10,
          //               decoration: BoxDecoration(
          //                 borderRadius: BorderRadius.circular(10)
          //               ),
          //               child: Stack(
          //                 children: [
          //                   Positioned(
          //                     top: 0,
          //                     child: SizedBox(
          //                       height: 300,
          //                       width: screenWidth,
          //                       child: Image.network(post["imageLink"],fit: BoxFit.cover, )),
          //                   ),
          //                   Positioned(
          //                     bottom: 0,
          //                     child: Container(
          //                     width: screenWidth,
          //                     height: 60,
          //                     color: Colors.black.withOpacity(0.5),
          //                     child: Center(child: Text(post["title"], textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 20),)) ))
          //                 ],
          //               ),
          //             ),
          //           ); 
          //       }
          //           }),
          //         ),
          //       );
          //       }),
          // )
            
          ]),
        ),
      ),
    );
  }

  SizedBox blogListWidget(double screenWidth, List<Map<String, String?>> blogs) {
  return SizedBox(
    height: 300,
    width: screenWidth - 30,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: blogs.length,
      itemBuilder: (context, index) {
        Map post = blogs[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
            future: getAllpost(), // Use the existing API call
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              if (snapshot.hasError) {
                return const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: Text('Try Again'),
                  ),
                );
              } else {
                // Use 'post' directly from 'blogs' list, no need for snapshot.data
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HTMLVIew(
                          data: snapshot.data!.items![index], // Pass the selected 'post' directly
                        ),
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
                              post["imageLink"],
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
                                post["title"],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ))),
                        )
                      ],
                    ),
                  ),
                );
              }
            }),
          ),
        );
      },
    ),
  );
}
}
