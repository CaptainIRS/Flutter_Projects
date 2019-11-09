import 'package:bloc/bloc.dart';
import 'package:hacker_news_app/bloc/article_event.dart';
import 'package:hacker_news_app/bloc/article_state.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final http.Client httpClient;

  ArticleBloc({@required this.httpClient});

  @override
  ArticleState get initialState => ArticleUninitialized();

  @override
  Stream<ArticleState> mapEventToState(ArticleEvent event) async* {
    final currentState = state;
    if (event is Fetch && !_hasReachedMax(currentState)) {}
    yield null;
  }

  bool _hasReachedMax(ArticleState state) =>
      state is ArticleLoaded && state.hasReachedMax;
}
