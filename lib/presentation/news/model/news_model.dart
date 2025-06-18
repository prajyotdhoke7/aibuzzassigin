class NewsModel {
  final String title;
  final String description;
  final String imageUrl;
  final String url;
  final String source;
  final DateTime publishedAt;

  NewsModel({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.url,
    required this.source,
    required this.publishedAt,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      title: json['title'] ?? 'No Title',
      description: json['description'] ?? 'No Description',
      imageUrl: json['image_url'] ?? '',
      url: json['link'] ?? '',
      source: json['source_name'] ?? '',
      publishedAt: DateTime.tryParse(json['pubDate'] ?? '') ?? DateTime.now(),
    );
  }
}
