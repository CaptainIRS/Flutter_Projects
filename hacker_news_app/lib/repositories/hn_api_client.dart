import 'dart:convert' as json;

import 'package:hacker_news_app/model/article.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

class HackerNewsApiClient {
  static const baseUrl = "https://hacker-news.firebaseio.com";
  final http.Client httpClient;

  HackerNewsApiClient({@required this.httpClient}) : assert(httpClient != null);

  Future<List<int>> fetchIds(String category) async {
    final url = "$baseUrl/v0/$category.json";
    final response = await this.httpClient.get(url);
    if (response.statusCode != 200)
      throw Exception("${response.statusCode} error when fetching top stories");
    return List<int>.from(json.jsonDecode(response.body));
  }

  Future<List<Article>> fetchArticles(List<int> ids) async {
    List<Article> articles = [];
    for (int id in ids) {
      final url = "$baseUrl/v0/item/$id.json";
      final response = await this.httpClient.get(url);
      if (response.statusCode != 200)
        throw Exception(
            "${response.statusCode} error when fetching top stories");
      Article article = Article.fromJson(response.body);
      articles.add(article);
    }
    return articles;
  }
}
