import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hacker_news_app/json_parser.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import 'model/article.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<int> _ids = [];
  int flag = 0;

  Future _refreshIds() async {
    var url = Uri.https("hacker-news.firebaseio.com", "/v0/topstories.json");
    var response = await http.get(url);
    if (response.statusCode == 200)
      _ids = List<int>.from(jsonDecode(response.body));
    else
      throw Exception("Response code : ${response.statusCode}");
    return;
  }

  @override
  Widget build(BuildContext context) {
    if (flag == 0) {
      _refreshIds();
      flag++;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int id) {
          return FutureBuilder<Article>(
            builder: (BuildContext context, AsyncSnapshot<Article> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return _buildItem(snapshot.data);
              }
              else
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(child: CircularProgressIndicator()),
                );
            },
            future: _getArticle(id),
          );
        },
      ),
    );
  }

  Future<Article> _getArticle(int id) async {
    int articleNo = _ids.elementAt(id);
    var url = Uri.https(
        "hacker-news.firebaseio.com", "/v0/item/$articleNo.json");
    var response = await http.get(url);
    if (response.statusCode == 200)
      return parseArticle(response.body);
    else
      throw Exception("Response code : ${response.statusCode}");
  }

  Widget _buildItem(Article article) {
    return Card(
      borderOnForeground: true,
      child: ExpansionTile(
        backgroundColor: Color.fromRGBO(230, 255, 230, 100),
        title: Text(article.title),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(article.descendants.toString() + " comments"),
              IconButton(
                onPressed: () async {
                  String url = article.url;
                  if (await canLaunch(url)) await launch(url);
                },
                icon: Icon(Icons.launch),
              )
            ],
          )
        ],
      ),
    );
  }
}
