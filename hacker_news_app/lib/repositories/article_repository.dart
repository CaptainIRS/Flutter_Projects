import 'package:hacker_news_app/model/article.dart';
import 'package:meta/meta.dart';

import 'hn_api_client.dart';

class ArticleRepository {
  final HackerNewsApiClient hackerNewsApiClient;
  List<int> _topStoriesIds = [];

  ArticleRepository({@required this.hackerNewsApiClient})
      : assert(hackerNewsApiClient != null);

  Future<List<Article>> getTopStories(int startIndex, int count) async {
    if (_topStoriesIds.isEmpty)
      _topStoriesIds = await hackerNewsApiClient.fetchIds("topstories");
    return await hackerNewsApiClient.fetchArticles(
        _topStoriesIds.sublist(startIndex, startIndex + count));
  }
}
