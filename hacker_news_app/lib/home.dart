import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hacker_news_app/model/Article.dart';
import 'package:url_launcher/url_launcher.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Article> _articles = articles;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: null,
        ),
        title: Text(widget.title),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(Duration(seconds: 2));
          setState(() {
            _articles.removeAt(0);
          });
          return;
        },
        child: Center(
          child: ListView(
            padding: EdgeInsets.all(8.0),
            children:
                _articles.map((article) => _getArticleTile(article)).toList(),
          ),
        ),
      ),
    );
  }

  ExpansionTile _getArticleTile(Article a) {
    return ExpansionTile(
      key: Key(Random().nextInt(10000).toString()),
      title: Text(a.title),
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(a.descendants.toString() + " comments"),
            IconButton(
              onPressed: () async {
                String url = a.url;
                if (await canLaunch(url)) await launch(url);
              },
              icon: Icon(Icons.launch),
            )
          ],
        )
      ],
    );
  }
}
