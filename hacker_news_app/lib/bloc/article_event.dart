import 'package:equatable/equatable.dart';

abstract class ArticleEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchTopStories extends ArticleEvent {}

class FetchNewStories extends ArticleEvent {}

class FetchAskHN extends ArticleEvent {}