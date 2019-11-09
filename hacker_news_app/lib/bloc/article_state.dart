import 'package:equatable/equatable.dart';
import 'package:hacker_news_app/model/article.dart';

abstract class ArticleState extends Equatable {
  const ArticleState();

  @override
  List<Object> get props => [];
}

class ArticleUninitialized extends ArticleState {}

class ArticleError extends ArticleState {}

class ArticleLoaded extends ArticleState {
  final List<Article> articles;
  final bool hasReachedMax;

  const ArticleLoaded({this.articles, this.hasReachedMax});

  @override
  List<Object> get props => [articles];

  ArticleLoaded copyWith({List<Article> articles, bool hasReachedMax}) {
    return ArticleLoaded(articles: articles, hasReachedMax: hasReachedMax);
  }

  @override
  String toString() {
    return "ArticleState {\n\tarticles : ${articles.length}\n\thasReachedMax : $hasReachedMax\n}";
  }
}
