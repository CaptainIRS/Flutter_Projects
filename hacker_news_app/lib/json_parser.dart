import 'dart:convert';

import 'package:hacker_news_app/model/article.dart';

List<int> parseTopStories(String jsonString) {
  var parsed = jsonDecode(jsonString);
  return List<int>.from(parsed);
}

Article parseArticle(String jsonString) {
  Article article = Article.fromJson(jsonString);
  return article;
}