// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:motplay/models/event_model.dart';
import 'package:motplay/models/my_event.dart';
import 'package:motplay/screens/blog_api_detail_screen.dart';
import 'package:motplay/screens/event_api_detail_screen.dart';
import 'package:provider/provider.dart';
import 'package:html/parser.dart' as htmlParser;
import 'package:html/parser.dart' show parse;
import 'package:blogger_api/blogger_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:motplay/screens/exoplyertestapp.dart';
import '../utils/constanst.dart';
import '../utils/custom_drawer.dart';
import '../utils/mycolors.dart';
import 'blog_detail_screen.dart';

class Dashboard extends StatefulWidget {
  static const routeName = "/nextScreen";
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

int selectedButton = 1;

class _DashboardState extends State<Dashboard> {
  List<Map<String, String?>> posts = [];
  List<Map<String, String?>> gpList = [];
  List<Map<String, String?>> f1List = [];
  List<MyEvent> eventsss = []; 

  @override
  void initState() {
    eventsss = [];
    String htmlCode = '''
<div id="em20692y" class="match-event  " data-result='MotoPlay'> 
  <a title="Carrera vs GP Bélgica" id="match-live" href="https://wegettingnoidu.blogspot.com/2023/05/f2-f3.html"> 
    <div id="overlay-match"><div id="watch-match"></div></div> 
  </a> 
  <div class="first-team"> 
    <div class="team-logo"> 
      <img alt="Carrera" height="70" src="https://media.formula1.com/image/upload/content/dam/fom-website/2018-redesign-assets/Track%20icons%204x3/Belgium%20carbon.png.transform/3col/image.png" title="Carrera" width="70"/> 
    </div> 
    <div class="team-name">Carrera</div> 
  </div> 
  <div class="match-time"> 
    <div class="match-timing"> 
      <div id="match-hour">8:30 AM</div> 
      <div id="result-now">MotoPlay</div> 
      <span id="dem6615y" class="match-date  " data-start="2023-07-30T08:30:00+02:00" data-gameends="2023-07-30T09:50:00+02:00"> </span> 
    </div> 
  </div> 
  <div class="left-team"> 
    <div class="team-logo"> 
      <img alt="GP Bélgica" height="70" src="https://i.ibb.co/Wskffkd/f3333.png" title="GP Bélgica" width="70"/> 
    </div> 
    <div class="team-name">GP Bélgica</div> 
  </div> 
  <div class="match-info"> 
    <ul> 
      <li><span>30/07/2023</span></li> 
      <li><span>MotoPlay</span></li> 
      <li><span>Formula 3</span></li> 
    </ul> 
  </div> 
</div>
''';
    parseHTML(htmlCode);
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
  void parseHTML(String htmlContent) {
  // Parse the HTML content
  var document = parse(htmlContent);

  // Find the div with the id "em20692y" (assuming it's unique)
  var matchDiv = document.getElementById('em20692y');

  if (matchDiv != null) {
    // Extract the title attribute from the 'a' element inside the div
    var title = matchDiv.querySelector('a')?.attributes['title'];

    // Extract the link (href) from the 'a' element inside the div
    var link = matchDiv.querySelector('a')?.attributes['href'];

    // Extract the images' 'src' attribute from both team logos
    var teamLogos = matchDiv.querySelectorAll('.team-logo img');
    var firstTeamLogo = teamLogos[0]?.attributes['src'];
    var secondTeamLogo = teamLogos[1]?.attributes['src'];

    // Extract other information such as match time and date
    var matchTime = matchDiv.querySelector('.match-time #match-hour')?.text;
    var matchDate = matchDiv.querySelector('.match-info li span')?.text;

    // Print the extracted information
    print('Title: $title');
    print('Link: $link');
    print('First Team Logo: $firstTeamLogo');
    print('Second Team Logo: $secondTeamLogo');
    print('Match Time: $matchTime');
    print('Match Date: $matchDate');
    setState(() {
      MyEvent eve = MyEvent(title: title as String, link: link as String, firstTeamLogo: firstTeamLogo as String, secondTeamLogo: secondTeamLogo as String, matchTime: matchTime as String, matchDate: matchDate as String);
      eventsss.add(eve);
    });
  } else {
    print('Match div not found');
  }
}

List<String> splitStringWithVs(String inputString) {
  // Find the index of "vs" in the input string
  int vsIndex = inputString.indexOf('vs');

  if (vsIndex != -1) {
    // Split the string into two parts based on the "vs" keyword
    String part1 = inputString.substring(0, vsIndex).trim();
    String part2 = inputString.substring(vsIndex + 2).trim(); // +2 to skip "vs"

    print([part1, part2]);
    return [part1, part2];
  } else {
    // If "vs" is not found, return the original string as the first part and an empty string as the second part
    return [inputString, ''];
  }
}

  Future<Map<String, String?>?> fetchPosts(String blogId, String apiKey) async {
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
    final blogProvider = Provider.of<BlogProvider>(context, listen: false);
    // Adjust font size based on screen width and text scale factor
    //final fontSize = screenWidth * 0.14 * textScaleFactor;
    //final subheading = screenWidth * 0.07 * textScaleFactor;
    final heading = screenWidth * 0.14 * textScaleFactor;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "MotoPlay",
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
        backgroundColor: gradBlue,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        // actions: [
        //   IconButton(onPressed: (){
           
        
        

        

        //   }, icon: Icon(Icons.ac_unit_outlined))
        //],
      ),
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: 150,
            child: Stack(children: [
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Column(
                  children: [
                    Container(
                      height: 100,
                      width: screenWidth * 0.8,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/newbox.png')),
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ],
                ),
              ),
              Positioned(
                  top: 20,
                  left: (screenWidth / 2) - 70,
                  child: Text(
                    "Events",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  )),
              Positioned(
                top: 60,
                left: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CircleAvatar(radius: 40, child: Text("Today")),
                    SizedBox(
                      width: 30,
                    ),
                    CircleAvatar(radius: 40, child: Text("Tomorrow")),
                  ],
                ),
              )
            ]),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              height: 300,
              width: screenWidth,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: eventsss.length,
                  itemBuilder: (context, index) {
                    MyEvent eve = eventsss[index];
                    return EventWidget(screenWidth, eve);
                  }),
            ),
          ),
          // SizedBox(
          //   height: 300,
          //   child: ListView.builder(
          //     itemCount: eventsss.length,
          //     itemBuilder: (BuildContext context, int index) {
          //       MyEvent eve = eventsss[index];
          //       return Container(
          //         padding: EdgeInsets.symmetric(horizontal: 10),
          //         child: Column(
          //           children: [
          //             Text(eve.title),
          //             Text(eve.link),
          //             Text(eve.firstTeamLogo),
          //             Text(eve.secondTeamLogo),
          //             Text(eve.matchTime),
          //             Text(eve.matchDate),
          //           ],
          //         ),
          //       );
          //     },
          //   ),
          // ),
          //ApiEventListWidget(screenWidth),
          Divider(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Latest Updates",
                  style: TextStyle(fontSize: 25),
                )),
          ),
          // blogListWidget(screenWidth, posts),
          ApiblogListWidget(screenWidth, blogProvider.blogs),
        ]),
      ),
    );
  }

  SizedBox EventWidget(double screenWidth, MyEvent event) {
    List<String> oneTwo = [];
    String text1 = "";
    String text2 = "";
    return SizedBox(
      height: 300,
      width: 350,
      child: Column(
        children: [
          SizedBox(
            height: 300,
            child: Stack(children: [
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Column(
                  children: [
                    InkWell(
                      onTap: (){
                        setState(() {
                          oneTwo = splitStringWithVs(event.title);
                          text1 = oneTwo.first;
                          text2 = oneTwo.last;
                        });
                      },
                      child: Text(
                        event.title,
                        style: TextStyle(fontSize: 29, color: gradBlue),
                      ),
                    ),
                    Container(
                      height: 100,
                      width: screenWidth * 0.8,
                      decoration: BoxDecoration(
                          color: gradBlue,
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl: event.firstTeamLogo,
                                        height: 30,
                                        width: 40,
                                        placeholder: (context, url) =>
                CircularProgressIndicator(), // Placeholder widget while loading
            errorWidget: (context, url, error) => Icon(
                Icons.error),
                                      ),
                                      Text(
                                     "Carrera",
                                     // oneTwo.isEmpty?"" :oneTwo[0],  
                                        style: TextStyle(
                                            fontSize: 21, color: Colors.white),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  width: 1, // The thickness of the line
                                  color: Colors.white, // The color of the line
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl: event.secondTeamLogo ,
                                        height: 30,
                                        width: 20,
                                        placeholder: (context, url) =>
                CircularProgressIndicator(), // Placeholder widget while loading
            errorWidget: (context, url, error) => Icon(
                Icons.error),
                                      ),
                                      Text(
                                        "GP Bélgica",
                                        //oneTwo.isEmpty?"" :oneTwo[1],
                                        style: TextStyle(
                                            fontSize: 21, color: Colors.white),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  width: 1, // The thickness of the line
                                  color: Colors.white, // The color of the line
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Image.asset(
                                        "assets/images/txt.png",
                                        height: 20,
                                        width: 60,
                                        color: gradOrange,
                                      ),
                                      const SizedBox(height: 10),
                                      const Text(
                                        "Finalizado",
                                        style: TextStyle(
                                            fontSize: 21, color: Colors.white),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 130,
                left: 10,
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Card(
                      elevation: 10,
                      child: Container(
                        height: 120,
                        width: screenWidth * 0.20,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/handle.png',
                              color: Colors.orangeAccent,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "formula 1",
                              style: TextStyle(fontSize: 15),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Card(
                      elevation: 10,
                      child: Container(
                        height: 120,
                        width: screenWidth * 0.20,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/cup.png',
                              color: Colors.orangeAccent,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "En Vivo",
                              style: TextStyle(fontSize: 15),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Card(
                      elevation: 10,
                      child: Container(
                        height: 120,
                        width: screenWidth * 0.20,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Image.asset(
                                  'assets/images/cal.png',
                                  color: Colors.orangeAccent,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  event.matchDate,
                                  style: TextStyle(fontSize: 15),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              )
            ]),
          )
        ],
      ),
    );
  }

  Widget blogListWidget(double screenWidth, List<Map<String, String?>> blogs) {
    double screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      height: screenHeight / 3,
      width: screenWidth - 5,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: blogs.length,
        itemBuilder: (context, index) {
          Map<String, String?> post =
              blogs[index]; // Explicitly cast to Map<String, String?>
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
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
                  height: 400,
                  width: screenWidth / 1.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: screenHeight / 4.1,
                        width: 330,
                        child: CachedNetworkImage(
                          imageUrl: post["imageLink"] ?? '',
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
                            post["title"] ?? '',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          );
        },
      ),
    );
  }

  Widget ApiblogListWidget(double screenWidth, List<Blog> blogs) {
    double screenHeight = MediaQuery.of(context).size.height;
    final blogProvider = Provider.of<BlogProvider>(context, listen: false);
    return FutureBuilder(
      future: blogProvider.fetchBlogs(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return SizedBox(
            height: screenHeight * .3,
            width: screenWidth - 5,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: blogProvider.blogs.length,
              itemBuilder: (context, index) {
                final blog = blogProvider.blogs[index];
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => BlogApiDetailsScreen(post: blog),
                    ));
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                    child: Container(
                        width: screenWidth / 1.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: screenHeight / 4,
                              // width: screenWidth/2,
                              child: CachedNetworkImage(
                                imageUrl:
                                    "https://moto-play.visualmigration.com/public/uploads/images/${blog.image}",
                                placeholder: (context, url) => const Center(
                                    // height: 50,
                                    // width: 50,
                                    child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                fit: BoxFit.cover,
                              ),
                            ),
                            Expanded(
                              // height: 60,
                              // color: Colors.black.withOpacity(0.7),
                              child: Container(
                                color: Colors.black.withOpacity(0.7),
                                child: Center(
                                  child: Text(
                                    blog.title,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }

  Widget ApiEventListWidget(double screenWidth) {
    double screenHeight = MediaQuery.of(context).size.height;
    final eventProvider = Provider.of<EventProvider>(context, listen: false);
    return FutureBuilder(
      future: eventProvider.fetchEvents(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return SizedBox(
            height: screenHeight / 3,
            width: screenWidth - 5,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: eventProvider.events.length,
              itemBuilder: (context, index) {
                final event = eventProvider.events[index];
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => EventApiDetailScreen(event: event),
                    ));
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                    child: Container(
                        width: screenWidth / 1.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            // SizedBox(
                            //    height: screenHeight / 4,
                            //   // width: screenWidth/2,
                            //   child: CachedNetworkImage(
                            //     imageUrl:
                            //         "https://moto-play.visualmigration.com/public/uploads/images/${blog.image}",
                            //     placeholder: (context, url) => const Center(
                            //         // height: 50,
                            //         // width: 50,
                            //         child: CircularProgressIndicator()),
                            //     errorWidget: (context, url, error) =>
                            //         const Icon(Icons.error),
                            //     fit: BoxFit.cover,
                            //   ),
                            //),
                            Expanded(
                              // height: 60,
                              // color: Colors.black.withOpacity(0.7),
                              child: Container(
                                color: Colors.black.withOpacity(0.7),
                                child: Center(
                                  child: Text(
                                    event.title,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
