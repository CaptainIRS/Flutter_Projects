import 'package:bloc/bloc.dart';
import 'package:hacker_news_app/bloc/bloc.dart';
import 'package:hacker_news_app/repositories/repositories.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final http.Client httpClient;
  ArticleRepository _articleRepository;

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
    if (event is Fetch && !_hasReachedMax(currentState)) {
      try {
        if (currentState is ArticleUninitialized) {
          final articles = await _articleRepository.getTopStories(0, 20);
          print("articles length : " + articles.length.toString());
          yield ArticleLoaded(
            articles: articles,
            hasReachedMax: false,
          );
        }
        if (currentState is ArticleLoaded) {
          print("articles length : " + currentState.articles.length.toString());
          final articles = await _articleRepository.getTopStories(
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
