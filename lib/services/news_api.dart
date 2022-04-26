import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app_desktop_web/models/article.dart';
import 'package:news_app_desktop_web/models/article_category.dart';

class NewsApi {
  static const baseUrl = 'https://newsapi.org/v2';
  static const apiKey = 'ca0a499abc194582a584f12d25fa8d07';

  Future<List<Article>> fetchArticles(ArticleCategory category) async {
    var url =
        '$baseUrl/top-headlines?apiKey=$apiKey&language=en&category=${categoryName(category)}';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      if (json['status'] == 'ok') {
        final List articlesJson = json['articles'] ?? [];

        final List<Article> articles =
            articlesJson.map((e) => Article.fromJson(e)).toList();
        return articles;
      } else {
        throw Exception(json['message'] ?? 'Failed to load');
      }
    } else {
      throw Exception('Bad Response');
    }
  }

  String categoryName(ArticleCategory category) {
    switch (category) {
      case ArticleCategory.general:
        return 'general';
      case ArticleCategory.business:
        return 'business';
      case ArticleCategory.technology:
        return 'technology';
      case ArticleCategory.entertainment:
        return 'entertainment';
      case ArticleCategory.sports:
        return 'sports';
      case ArticleCategory.science:
        return 'science';
      case ArticleCategory.health:
        return 'health';
    }
  }
}
