import 'dart:convert';

class BookmarkModel {
  final String title;
  final String description;
  final String imageUrl;
  final String url;
  final String source;
  final DateTime publishedAt;

  BookmarkModel({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.url,
    required this.source,
    required this.publishedAt,
  });

  factory BookmarkModel.fromJson(Map<String, dynamic> json) {
    return BookmarkModel(
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      url: json['url'],
      source: json['source'],
      publishedAt: DateTime.parse(json['publishedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'url': url,
      'source': source,
      'publishedAt': publishedAt.toIso8601String(),
    };
  }

  static String encode(List<dynamic> bookmarks) => json.encode(
        bookmarks.map<Map<String, dynamic>>((e) => e.toJson()).toList(),
      );

  static List<BookmarkModel> decode(String bookmarks) =>
      (json.decode(bookmarks) as List<dynamic>)
          .map<BookmarkModel>((item) => BookmarkModel.fromJson(item))
          .toList();
}
