import 'package:hacker_news_app/model/article.dart';
import 'package:meta/meta.dart';

import 'hn_api_client.dart';

class ArticleRepository {
  final HackerNewsApiClient hackerNewsApiClient;
  List<int> _topStoriesIds = [];
  List<int> _newStoriesIds = [];

  ArticleRepository({@required this.hackerNewsApiClient})
      : assert(hackerNewsApiClient != null);

  Future<List<Article>> getTopStories(int startIndex, int count) async {
    if (_topStoriesIds.isEmpty)
      _topStoriesIds = await hackerNewsApiClient.fetchIds("topstories");
    return await hackerNewsApiClient.fetchArticles(
        _topStoriesIds.sublist(startIndex, startIndex + count));
  }

  Future<List<Article>> getNewStories(int startIndex, int count) async {
    if (_newStoriesIds.isEmpty)
      _newStoriesIds = await hackerNewsApiClient.fetchIds("newstories");
    return await hackerNewsApiClient.fetchArticles(
        _newStoriesIds.sublist(startIndex, startIndex + count));
  }
}
