import 'package:flutter/foundation.dart'
    show debugDefaultTargetPlatformOverride;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacker_news_app/bloc/article_bloc.dart';
import 'package:hacker_news_app/bloc/article_event.dart';
import 'package:http/http.dart' as http;

import 'home.dart';

void main() {
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hacker News',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Hacker News"),
        ),
        body: BlocProvider<ArticleBloc>(
          builder: (context) =>
          ArticleBloc(httpClient: http.Client())
            ..add(Fetch()),
          child: HomePage(),
        ),
      ),
    );
  }
}
