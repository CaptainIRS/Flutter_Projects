import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacker_news_app/bloc/bloc.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:url_launcher/url_launcher.dart';

import 'model/article.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _scrollController = ScrollController();
  final _scrollThreshold = 10.0;
  double maxScrollExtent = 0;
  ArticleBloc _articleBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _articleBloc = BlocProvider.of<ArticleBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArticleBloc, ArticleState>(
        builder: (context, state) {
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
                    ? BottomLoader()
                    : ArticleWidget(article: state.articles[index]);
              },
              itemCount: state.hasReachedMax
                  ? state.articles.length
                  : state.articles.length + 1,
              controller: _scrollController,
            );
          }
          return null;
        }
    );
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
        _articleBloc.add(Fetch());
      }
    }
  }

}

class BottomLoader extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: 33,
          height: 33,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
          ),
        ),
      ),
    );
  }

}

class ArticleWidget extends StatelessWidget {

  final Article article;

  const ArticleWidget({Key key, @required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(article.time * 1000);
    return Card(
      color: Color.fromRGBO(230, 255, 230, 1),
      borderOnForeground: true,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ExpansionTile(
          backgroundColor: Color.fromRGBO(230, 255, 230, 100),
          title: Text(
            article.title ?? 'null',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 0, 0, 0),
                  child: Text(DateFormat('dd MMMM, yyyy - h:m:s a')
                      .format(time)
                      .toString()),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 0.0, 8.0, 0.0),
                      child: Text(article.descendants.toString() + " comments"),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 0.0),
                      child: IconButton(
                        onPressed: () async {
                          String url = article.url;
                          if (await canLaunch(url)) await launch(url);
                        },
                        icon: Icon(Icons.launch),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}