import 'package:hacker_news_app/model/article.dart';
import 'package:meta/meta.dart';

import 'hn_api_client.dart';

class ArticleRepository {
  final HackerNewsApiClient hackerNewsApiClient;
  List<int> _topStoriesIds = [];
  List<int> _newStoriesIds = [];
  List<int> _bestStoriesIds = [];
  List<int> _askHnStoriesIds = [];
  List<int> _showHnStoriesIds = [];
  List<int> _jobStoriesIds = [];

  ArticleRepository({@required this.hackerNewsApiClient})
      : assert(hackerNewsApiClient != null);

  Future<List<Article>> getTopStories(int startIndex, int count) async {
    if (_topStoriesIds.isEmpty)
      _topStoriesIds = await hackerNewsApiClient.fetchIds("topstories");
    if (startIndex >= _topStoriesIds.length) return [];
    if (startIndex + count > _topStoriesIds.length)
      count = _topStoriesIds.length - startIndex;
    return await hackerNewsApiClient.fetchArticles(
        _topStoriesIds.sublist(startIndex, startIndex + count));
  }

  Future<List<Article>> getNewStories(int startIndex, int count) async {
    if (_newStoriesIds.isEmpty)
      _newStoriesIds = await hackerNewsApiClient.fetchIds("newstories");
    if (startIndex >= _newStoriesIds.length) return [];
    if (startIndex + count > _newStoriesIds.length)
      count = _newStoriesIds.length - startIndex;
    return await hackerNewsApiClient.fetchArticles(
        _newStoriesIds.sublist(startIndex, startIndex + count));
  }

  Future<List<Article>> getBestStories(int startIndex, int count) async {
    if (_bestStoriesIds.isEmpty)
      _bestStoriesIds = await hackerNewsApiClient.fetchIds("beststories");
    if (startIndex >= _bestStoriesIds.length) return [];
    if (startIndex + count > _bestStoriesIds.length)
      count = _bestStoriesIds.length - startIndex;
    return await hackerNewsApiClient.fetchArticles(
        _bestStoriesIds.sublist(startIndex, startIndex + count));
  }

  Future<List<Article>> getAskHnStories(int startIndex, int count) async {
    if (_askHnStoriesIds.isEmpty)
      _askHnStoriesIds = await hackerNewsApiClient.fetchIds("askstories");
    if (startIndex >= _askHnStoriesIds.length) return [];
    if (startIndex + count >= _askHnStoriesIds.length)
      count = _askHnStoriesIds.length - startIndex;
    return await hackerNewsApiClient.fetchArticles(
        _askHnStoriesIds.sublist(startIndex, startIndex + count));
  }

  Future<List<Article>> getShowHnStories(int startIndex, int count) async {
    if (_showHnStoriesIds.isEmpty)
      _showHnStoriesIds = await hackerNewsApiClient.fetchIds("showstories");
    if (startIndex >= _showHnStoriesIds.length) return [];
    if (startIndex + count > _showHnStoriesIds.length)
      count = _showHnStoriesIds.length - startIndex;
    return await hackerNewsApiClient.fetchArticles(
        _showHnStoriesIds.sublist(startIndex, startIndex + count));
  }

  Future<List<Article>> getJobStories(int startIndex, int count) async {
    if (_jobStoriesIds.isEmpty)
      _jobStoriesIds = await hackerNewsApiClient.fetchIds("jobstories");
    if (startIndex >= _jobStoriesIds.length) return [];
    if (startIndex + count > _jobStoriesIds.length)
      count = _jobStoriesIds.length - startIndex;
    return await hackerNewsApiClient.fetchArticles(
        _jobStoriesIds.sublist(startIndex, startIndex + count));
  }
}
