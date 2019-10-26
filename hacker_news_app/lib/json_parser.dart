import 'dart:convert';

import 'model/Article.dart';

List<int> parseTopStories(String jsonString) {
  final parsed = jsonDecode(jsonString);
  final listOfInts = List<int>.from(parsed);
  return listOfInts;
}

Article parseArticle(String jsonString) {
  return Article.fromJson(jsonString);
}
