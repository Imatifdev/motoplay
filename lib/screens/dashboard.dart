// ignore_for_file: prefer_const_constructors

import 'package:blogger_api/blogger_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:motplay/screens/configration.dart';
import 'package:motplay/screens/dmca.dart';
import 'package:motplay/screens/donation.dart';
import 'package:motplay/screens/privacy-policy.dart';
import 'package:xml/xml.dart';
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
  Future<PostModel> getAllpost() async {
    final res = await BloggerAPI().getAllPostFromBlog(
      includeComment: true,
      blogId: blogIds[0],
      apiKey: key,
    );
    return res;
  }

  Future<List<Map<String, String?>>> fetchPosts(
      String blogId, String apiKey) async {
    print("test 1");
    String url =
        'https://www.googleapis.com/blogger/v3/blogs/$blogId/posts?key=$apiKey';
    //'https://www.googleapis.com/blogger/v3/blogs/$blogId/posts?key=$apiKey';
    http.Response response = await http.get(Uri.parse(url));
    print("test 2");
    // Wrap the XML response with a root element
    String wrappedXml = '<root>${response.body}</root>';
    XmlDocument xmlDocument = XmlDocument.parse(wrappedXml);
    print("test 3");
    //List<Map<String, String?>> posts = [];
    Iterable<XmlElement> entries = xmlDocument.findAllElements('entry');
    print("test 4");
    entries.forEach((entry) {
      String? title = entry.findElements('title').first.value;
      String? content = entry.findElements('content').first.value;
      String? published = entry.findElements('published').first.value;
      String? updated = entry.findElements('updated').first.value;
      String? img = entry.findElements('image').first.getAttribute('url');
      String url =
          entry.findElements('link').first.getAttribute('href') as String;
      Map<String, String?> post = {
        'title': title,
        'content': content,
        'published': published,
        'updated': updated,
        'url': url,
        'img': img
      };
      setState(() {
        posts.add(post);
        print(post["title"]);
      });
    });
    print("test 5");
    print(response.body);
    print("test 6");
    return posts;
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
              await fetchPosts(blogIds[0], key);
              //for(Map post in posts){
              print(posts);
              //}
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
                  Text(
                    "MOTOPLAY",
                    style: TextStyle(fontSize: 31, color: Colors.black),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
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
            ListTile(
              leading: Icon(Icons.home),
              title: Text(
                "Home",
                style: TextStyle(fontSize: 23, color: blue),
              ),
            ),
            Divider(
              height: 0,
              thickness: 0.5,
            ),
            ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (ctx) => Configration()));
              },
              leading: Icon(Icons.settings),
              title: Text(
                "Configration",
                style: TextStyle(fontSize: 23, color: blue),
              ),
            ),
            Divider(
              height: 0,
              thickness: 0.5,
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (ctx) => Donation()));
              },
              leading: ImageIcon(AssetImage("assets/images/icons7.png")),
              title: Text(
                "Donación",
                style: TextStyle(fontSize: 23, color: blue),
              ),
            ),
            Divider(
              height: 0,
              thickness: 0.5,
            ),
            ListTile(
              leading: ImageIcon(AssetImage("assets/images/icon3.png")),
              title: Text(
                "Repeticiones f1ss",
                style: TextStyle(fontSize: 23, color: blue),
              ),
            ),
            Divider(
              height: 0,
              thickness: 0.5,
            ),
            ListTile(
              leading: ImageIcon(AssetImage("assets/images/icon3.png")),
              title: Text(
                "Repeticiones  MotoGP",
                style: TextStyle(fontSize: 23, color: blue),
              ),
            ),
            Divider(
              height: 0,
              thickness: 0.5,
            ),
            ListTile(
              leading: Icon(Icons.restore_outlined),
              title: Text(
                "Últimas Actualizaciones",
                style: TextStyle(fontSize: 23, color: blue),
              ),
            ),
            Divider(
              height: 0,
              thickness: 0.5,
            ),
            ListTile(
              leading: ImageIcon(AssetImage("assets/images/icon1.png")),
              title: Text(
                "Redes Sociales",
                style: TextStyle(fontSize: 23, color: blue),
              ),
            ),
            Divider(
              height: 0,
              thickness: 0.5,
            ),
            ListTile(
              leading: Icon(Icons.notification_important_outlined),
              title: Text(
                "Configurar las Notificaciones",
                style: TextStyle(fontSize: 23, color: blue),
              ),
            ),
            Divider(
              height: 0,
              thickness: 0.5,
            ),
            ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (ctx) => PrivacyPolicyScreen()));
              },
              leading: ImageIcon(AssetImage("assets/images/icon2.png")),
              title: Text(
                "Politicas de Privacidad",
                style: TextStyle(fontSize: 23, color: blue),
              ),
            ),
            Divider(
              height: 0,
              thickness: 0.5,
            ),
            ListTile(
              leading: Icon(Icons.screen_share_rounded),
              title: Text(
                "Comparitir App",
                style: TextStyle(fontSize: 23, color: blue),
              ),
            ),
            Divider(
              height: 0,
              thickness: 0.5,
            ),
            ListTile(
              leading: ImageIcon(AssetImage("assets/images/icon5.png")),
              title: Text(
                "Acerca de la App",
                style: TextStyle(fontSize: 23, color: blue),
              ),
            ),
            Divider(
              height: 0,
              thickness: 0.5,
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (ctx) => DMCA()));
              },
              leading: ImageIcon(AssetImage("assets/images/icon4.png")),
              title: Text(
                "DMCA ",
                style: TextStyle(fontSize: 23, color: blue),
              ),
            ),
          ],
        ),
      ),
      body: Column(children: [
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // setState(() {
                //   selectedButton = 1;
                // });
              },
              child: const Text('Button 1'),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                // setState(() {
                //   selectedButton = 2;
                // });
              },
              child: const Text('Button 2'),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                // setState(() {
                //   selectedButton = 3;
                // });
              },
              child: const Text('Button 3'),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            color: Colors.blue.shade100,
            width: double.infinity,
            height: screenHeight / 3.5,
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
                    width: screenWidth / 3.1,
                    child: Card(
                      color: Colors.blue.shade300,
                    )),
                SizedBox(
                    height: 130,
                    width: 130,
                    child: Card(
                      color: Colors.blue.shade300,
                    )),
                SizedBox(
                    height: 130,
                    width: 130,
                    child: Card(
                      color: Colors.blue.shade300,
                    )),
              ])
            ]),
          ),
        ),
        FutureBuilder(
            future: getAllpost(),
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
                return Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data!.items!.length,
                      itemBuilder: (ctx, index) {
                        return Center(
                          child: Card(
                              child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HTMLVIew(
                                          data: snapshot.data!.items![index],
                                        )),
                              );
                            },
                            child: Container(
                                height: 200,
                                width: double.infinity,
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // CachedNetworkImage(
                                    //   imageUrl:snapshot.data!.items![index]. ,
                                    // ),
                                    Text(snapshot.data!.items![index].title!),
                                  ],
                                )),
                          )),
                        );
                      }),
                );
              }
            })),
      ]),
    );
  }
}
