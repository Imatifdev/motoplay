import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';

class Post {
  final String title;
  final String content;
  final DateTime date;

  Post({
    required this.title,
    required this.content,
    required this.date,
  });
}

class PostListScreen extends StatefulWidget {
  @override
  _PostListScreenState createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  List<Post> posts = [];

  void _addPost(String title, String content) {
    final newPost = Post(
      title: title,
      content: content,
      date: DateTime.now(),
    );

    setState(() {
      posts.add(newPost);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Posts')),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (index == 0 || post.date.day != posts[index - 1].date.day)
                Container(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Text(
                    _formatDate(post.date),
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ListTile(
                title: Text(post.title),
                subtitle: Html(
                  data: post.content,
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToAddPostScreen();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  String _formatDate(DateTime date) {
    if (date.day == DateTime.now().day) {
      return 'Today';
    } else if (date.day == DateTime.now().day - 1) {
      return 'Yesterday';
    } else if (date.day == DateTime.now().day + 1) {
      return 'Tomorrow';
    } else {
      return date.toString();
    }
  }

  void _navigateToAddPostScreen() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddPostScreen()),
    );

    if (result != null && result is Map<String, String>) {
      _addPost(result['title']!, result['content']!);
    }
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class AddPostScreen extends StatefulWidget {
  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Post')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _contentController,
              maxLines: 5,
              decoration: InputDecoration(labelText: 'Content (HTML)'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _savePost();
              },
              child: Text('Save Post'),
            ),
          ],
        ),
      ),
    );
  }

  void _savePost() {
    final title = _titleController.text;
    final content = _contentController.text;

    if (title.isNotEmpty && content.isNotEmpty) {
      Navigator.pop(context, {'title': title, 'content': content});
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }
}
