import 'package:xml/xml.dart';

class Post {
  String? kind;
  String? nextPageToken;
  List<PostItem> items;

  Post({
    required this.kind,
    required this.nextPageToken,
    required this.items,
  });

  factory Post.fromXml(XmlElement element) {
    List<PostItem> items = element.findElements('items').map((item) => PostItem.fromXml(item)).toList();

    return Post(
      kind: element.findElements('kind').first.value,
      nextPageToken: element.findElements('nextPageToken').first.value,
      items: items,
    );
  }
  

  factory Post.fromJson(Map<String?, dynamic> json) {
    List<PostItem> items = (json['items'] as List)
        .map((item) => PostItem.fromJson(item))
        .toList();

    return Post(
      kind: json['kind'],
      nextPageToken: json['nextPageToken'],
      items: items,
    );
  }
}

class PostItem {
  String? kind;
  String? id;
  Blog blog;
  String? published;
  String? updated;
  String? url;
  String? selfLink;
  String? title;
  Author author;
  Replies replies;
  List<String?> labels;
  String? etag;

  PostItem({
    required this.kind,
    required this.id,
    required this.blog,
    required this.published,
    required this.updated,
    required this.url,
    required this.selfLink,
    required this.title,
    required this.author,
    required this.replies,
    required this.labels,
    required this.etag,
  });

  factory PostItem.fromXml(XmlElement element) {
    return PostItem(
      kind: element.findElements('kind').first.value,
      id: element.findElements('id').first.value,
      blog: Blog.fromXml(element.findElements('Blog').first),
      published: element.findElements('published').first.value,
      updated: element.findElements('updated').first.value,
      url: element.findElements('url').first.value,
      selfLink: element.findElements('selfLink').first.value,
      title: element.findElements('title').first.value,
      author: Author.fromXml(element.findElements('author').first),
      replies: Replies.fromXml(element.findElements('replies').first),
      labels: element.findElements('labels').map((label) => label.value).toList(),
      etag: element.findElements('etag').first.value,
    );
  }

  factory PostItem.fromJson(Map<String?, dynamic> json) {
    return PostItem(
      kind: json['kind'],
      id: json['id'],
      blog: Blog.fromJson(json['Blog']),
      published: json['published'],
      updated: json['updated'],
      url: json['url'],
      selfLink: json['selfLink'],
      title: json['title'],
      author: Author.fromJson(json['author']),
      replies: Replies.fromJson(json['replies']),
      labels: List<String?>.from(json['labels']),
      etag: json['etag'],
    );
  }
}

class Blog {
  String? id;

  Blog({required this.id});

  factory Blog.fromXml(XmlElement element) {
    return Blog(
      id: element.findElements('id').first.value,
    );
  }

  factory Blog.fromJson(Map<String?, dynamic> json) {
    return Blog(
      id: json['id'],
    );
  }
}

class Author {
  String? id;
  String? displayName;
  String? url;
  Image imageAuth;

  Author({
    required this.id,
    required this.displayName,
    required this.url,
    required this.imageAuth,
  });

  factory Author.fromXml(XmlElement element) {
    return Author(
      id: element.findElements('id').first.value,
      displayName: element.findElements('displayName').first.value,
      url: element.findElements('url').first.value,
      imageAuth: Image.fromXml(element.findElements('image').first),
    );
  }

  factory Author.fromJson(Map<String?, dynamic> json) {
    return Author(
      id: json['id'],
      displayName: json['displayName'],
      url: json['url'],
      imageAuth: Image.fromJson(json['image']),
    );
  }
}

class Image {
  String? url;

  Image({required this.url});

  factory Image.fromXml(XmlElement element) {
    return Image(
      url: element.findElements('url').first.value,
    );
  }

  factory Image.fromJson(Map<String?, dynamic> json) {
    return Image(
      url: json['url'],
    );
  }
}

class Replies {
  String? totalItems;
  String? selfLink;

  Replies({required this.totalItems, required this.selfLink});

  factory Replies.fromXml(XmlElement element) {
    return Replies(
      totalItems: element.findElements('totalItems').first.value,
      selfLink: element.findElements('selfLink').first.value,
    );
  }

  factory Replies.fromJson(Map<String?, dynamic> json) {
    return Replies(
      totalItems: json['totalItems'],
      selfLink: json['selfLink'],
    );
  }
}
