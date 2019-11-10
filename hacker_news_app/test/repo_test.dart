import 'package:flutter_test/flutter_test.dart';
import 'package:hacker_news_app/model/article.dart';
import 'package:hacker_news_app/repositories/repositories.dart';
import 'package:http/http.dart';

void main() {
  test("Testing repositories", () async {
    final client = Client();
    final articleRepository = ArticleRepository(
        hackerNewsApiClient: HackerNewsApiClient(httpClient: client));
    List<Article> articles = await articleRepository.getTopStories(0, 10);
    expect(articles[0].title.split(' ')[0], 'Undercover');
  }, timeout: Timeout(Duration(seconds: 100)));
}
