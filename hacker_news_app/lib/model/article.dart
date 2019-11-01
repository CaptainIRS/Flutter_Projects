import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:hacker_news_app/model/serializers.dart';

part 'article.g.dart';

abstract class Article implements Built<Article, ArticleBuilder> {
  int get id;

  @nullable
  bool get deleted;

  ArticleType get type;

  String get by;

  int get time;

  @nullable
  String get text;

  @nullable
  bool get dead;

  @nullable
  int get parent;

  @nullable
  int get poll;

  @nullable
  BuiltList<int> get kids;

  @nullable
  String get url;

  @nullable
  int get score;

  @nullable
  String get title;

  @nullable
  BuiltList<int> get parts;

  @nullable
  int get descendants;

  Article._();

  factory Article([void Function(ArticleBuilder) updates]) = _$Article;

  String toJson() {
    return jsonEncode(serializers.serializeWith(Article.serializer, this));
  }

  static Article fromJson(String jsonString) {
    return standardSerializers.deserializeWith(
        Article.serializer, jsonDecode(jsonString));
  }

  static Serializer<Article> get serializer => _$articleSerializer;

}

class ArticleType extends EnumClass {
  static const ArticleType job = _$job;
  static const ArticleType story = _$story;
  static const ArticleType comment = _$comment;
  static const ArticleType poll = _$poll;
  static const ArticleType pollopt = _$pollopt;

  const ArticleType._(String name) : super(name);

  static BuiltSet<ArticleType> get values => _$values;

  static ArticleType valueOf(String name) => _$valueOf(name);

  static Serializer<ArticleType> get serializer => _$articleTypeSerializer;
}
