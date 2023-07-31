class Post {
  late String kind;
  late String id;
  late Blog? blog;
  late String published;
  late String updated;
  late String url;
  late String selfLink;
  late String title;
  late String content;
  late Author? author;
  late Replies? replies;
  late String etag;

  Post({
    required this.kind,
    required this.id,
    required this.blog,
    required this.published,
    required this.updated,
    required this.url,
    required this.selfLink,
    required this.title,
    required this.content,
    required this.author,
    required this.replies,
    required this.etag,
  });

  Post.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    id = json['id'];
    blog = json['blog'] != null ? Blog.fromJson(json['blog']) : null;
    published = json['published'];
    updated = json['updated'];
    url = json['url'];
    selfLink = json['selfLink'];
    title = json['title'];
    content = json['content'];
    author = json['author'] != null ? Author.fromJson(json['author']) : null;
    replies = json['replies'] != null ? Replies.fromJson(json['replies']) : null;
    etag = json['etag'];
  }
}

class Blog {
  late String id;

  Blog({required this.id});

  Blog.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }
}

class Author {
  late String id;
  late String displayName;
  late String url;
  late Image image;

  Author({required this.displayName, required this.url, required this.image});

  Author.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    displayName = json['displayName'];
    url = json['url'];
    image = json['image'] != null ? Image.fromJson(json['image']) : Image();
  }
}

class Image {
  late String url;

  Image();

  Image.fromJson(Map<String, dynamic> json) {
    url = json['url'] ?? '';
  }
}

class Replies {
  late String totalItems;
  late String selfLink;

  Replies({required this.totalItems, this.selfLink = ''});

  factory Replies.fromJson(Map<String, dynamic> json) {
    return Replies(
      totalItems: json['totalItems'],
      selfLink: json['selfLink'] ?? '',
    );
  }
}
