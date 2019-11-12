import 'package:equatable/equatable.dart';

abstract class ArticleEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchTopStories extends ArticleEvent {}

class FetchBestStories extends ArticleEvent {}

class FetchNewStories extends ArticleEvent {}

class FetchAskHnStories extends ArticleEvent {}

class FetchShowHnStories extends ArticleEvent {}

class FetchJobStories extends ArticleEvent {}