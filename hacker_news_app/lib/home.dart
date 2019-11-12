import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacker_news_app/bloc/bloc.dart';
import 'package:hacker_news_app/ui/article_widget.dart';

class HomePage extends StatefulWidget {
  final ArticleEvent event;

  @override
  _HomePageState createState() => _HomePageState(event: event);

  HomePage({this.event});
}

class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 10.0;
  double maxScrollExtent = 0;
  ArticleBloc _articleBloc;
  final ArticleEvent event;

  _HomePageState({this.event});

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _articleBloc = BlocProvider.of<ArticleBloc>(context);
    _articleBloc.add(event);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArticleBloc, ArticleState>(builder: (context, state) {
      if (state is ArticleUninitialized) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is ArticleError) {
        return Center(
          child: Text("Failed to fetch articles"),
        );
      }
      if (state is ArticleLoaded) {
        return ListView.builder(
          itemBuilder: (context, index) {
            return index >= state.articles.length
                ? ((state.hasReachedMax)
                ? ListTile(
              title: Text("End"),
            )
                : BottomLoader())
                : ArticleWidget(article: state.articles[index]);
          },
          itemCount: state.hasReachedMax
              ? state.articles.length
              : state.articles.length + 1,
          controller: _scrollController,
        );
      }
      return null;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      if (maxScrollExtent != _scrollController.position.maxScrollExtent) {
        maxScrollExtent = _scrollController.position.maxScrollExtent;
        _articleBloc.add(event);
      }
    }
  }
}
