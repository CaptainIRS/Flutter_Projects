import 'package:hacker_news_app/model/article.dart';
import 'package:meta/meta.dart';

import 'hn_api_client.dart';

class ArticleRepository {
  final HackerNewsApiClient hackerNewsApiClient;

  ArticleRepository({@required this.hackerNewsApiClient})
      : assert(hackerNewsApiClient != null);

  Future<List<Article>> getTopStories() async {
    final List<int> listOfIds =
        await hackerNewsApiClient.fetchIds("topstories");
    return await hackerNewsApiClient.fetchArticles(listOfIds.sublist(0, 20));
  }
}
