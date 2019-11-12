import 'package:bloc/bloc.dart';
import 'package:hacker_news_app/bloc/bloc.dart';
import 'package:hacker_news_app/repositories/repositories.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final http.Client httpClient;
  ArticleRepository _articleRepository;
  Function(int, int) fetch;

  ArticleBloc({@required this.httpClient}) {
    _articleRepository = ArticleRepository(
      hackerNewsApiClient: HackerNewsApiClient(
        httpClient: httpClient,
      ),
    );
  }

  @override
  ArticleState get initialState => ArticleUninitialized();

  @override
  Stream<ArticleState> mapEventToState(ArticleEvent event) async* {
    final currentState = state;
    fetch = (event is FetchTopStories)
        ? _articleRepository.getTopStories
        : (event is FetchNewStories)
        ? _articleRepository.getNewStories
        : null;
    if (fetch != null && !_hasReachedMax(currentState)) {
      try {
        if (currentState is ArticleUninitialized) {
          final articles = await fetch(0, 20);
          yield ArticleLoaded(
            articles: articles,
            hasReachedMax: false,
          );
        }
        if (currentState is ArticleLoaded) {
          final articles = await fetch(
              currentState.articles.length, 20);
          yield (articles.isEmpty)
              ? currentState.copyWith(hasReachedMax: true)
              : ArticleLoaded(
              articles: currentState.articles + articles, hasReachedMax: false);
        }
      } catch (e) {
        print(e.toString());
        yield ArticleError();
      }
    }
  }

  bool _hasReachedMax(ArticleState state) =>
      state is ArticleLoaded && state.hasReachedMax;
}
