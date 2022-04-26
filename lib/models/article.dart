import 'package:timeago/timeago.dart';

class Article {
  final String title;
  final String uri;
  final DateTime publishedAt;
  final String source;
  final String? urlToImage;

  const Article({
    required this.title,
    required this.uri,
    required this.publishedAt,
    required this.source,
    this.urlToImage,
  });

  String captionText() {
    final formattedPublishedAt = format(publishedAt, locale: 'en_short');
    return '$source $formattedPublishedAt';
  }

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] ?? '',
      uri: json['uri'] ?? '',
      publishedAt: DateTime.tryParse(json['publishedAt']) ?? DateTime.now(),
      source: json['source']['name'] ?? '',
      urlToImage: json['urlToImage'],
    );
  }
}
