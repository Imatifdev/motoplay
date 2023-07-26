// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:motplay/utils/mycolors.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:google_fonts/google_fonts.dart';


class WebTest extends StatefulWidget {
  @override
  State<WebTest> createState() => _WebTestState();
}

class _WebTestState extends State<WebTest> {
  final WebViewController _controller =  WebViewController()
  ..setJavaScriptMode(JavaScriptMode.unrestricted)
  ..setBackgroundColor(const Color(0x00000000))
  ..loadRequest(Uri.parse('https://lu.firstregional.es/'))
  ..setNavigationDelegate(
    NavigationDelegate(
      onProgress: (int progress) {
        // Update loading bar.
      },
      onPageStarted: (String url) {},
      onPageFinished: (String url) {},
      onWebResourceError: (WebResourceError error) {},
      onNavigationRequest: (NavigationRequest request) {
        if (request.url.startsWith('https://www.youtube.com/')) {
          return NavigationDecision.prevent;
        }
        return NavigationDecision.navigate;
      },
    ),
    
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blue,
        leading: const Icon(Icons.menu, color: Colors.white),
        title: Text('MotoPlay', style: TextStyle(color: Colors.white, fontFamily: GoogleFonts.poppins().fontFamily)),
      ),
       body: WebViewWidget(controller: _controller,),
      // withZoom: true,
      // withLocalStorage: true,
      // hidden: true,
      // initialChild: Container(
      //   color: Colors.deepPurple,
      //   child: const Center(
      //     child: CircularProgressIndicator(),
      //   ),
      // ),
    );
  }
}
