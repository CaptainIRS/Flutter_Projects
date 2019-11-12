import 'package:flutter/foundation.dart'
    show debugDefaultTargetPlatformOverride;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacker_news_app/bloc/bloc.dart';
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
      home: ArticlesPage(
        event: FetchTopStories(),
      ),
    );
  }
}

class ArticlesPage extends StatelessWidget {
  final ArticleEvent event;

  ArticlesPage({this.event});

  @override
  Widget build(BuildContext context) {
    String title =
    (event is FetchTopStories) ? "Top Stories"
        : (event is FetchNewStories) ? "New Stories"
        : (event is FetchBestStories) ? "Best Stories"
        : (event is FetchAskHnStories) ? "Ask HN"
        : (event is FetchShowHnStories) ? "Show HN"
        : (event is FetchJobStories) ? "Job Stories"
        : null;
    return Scaffold(
      appBar: AppBar(
        title: Text(title ?? 'null'),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Container(
                alignment: Alignment.bottomLeft,
                child: ListTile(
                  title: Text(
                    "Not Logged in",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.green,
              ),
            ),
            ListTile(
              title: Text(
                "Top Stories",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        ArticlesPage(
                          event: FetchTopStories(),
                        ),
                  ),
                );
              },
            ),
            ListTile(
              title: Text(
                "Best Stories",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        ArticlesPage(
                          event: FetchBestStories(),
                        ),
                  ),
                );
              },
            ),
            ListTile(
              title: Text(
                "New Stories",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        ArticlesPage(
                          event: FetchNewStories(),
                        ),
                  ),
                );
              },
            ),
            ListTile(
              title: Text(
                "Ask HN",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        ArticlesPage(
                          event: FetchAskHnStories(),
                        ),
                  ),
                );
              },
            ),
            ListTile(
              title: Text(
                "Show HN",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        ArticlesPage(
                          event: FetchShowHnStories(),
                        ),
                  ),
                );
              },
            ),
            ListTile(
              title: Text(
                "Job Stories",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        ArticlesPage(
                          event: FetchJobStories(),
                        ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: BlocProvider<ArticleBloc>(
        builder: (context) => ArticleBloc(httpClient: http.Client()),
        child: HomePage(
          event: event,
        ),
      ),
    );
  }
}
