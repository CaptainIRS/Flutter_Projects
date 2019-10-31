import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hacker_news_app/json_parser.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: 376,
        itemBuilder: (BuildContext context, int id) {
          return FutureBuilder<Article>(
            builder: (BuildContext context, AsyncSnapshot<Article> snapshot) {
              if (snapshot.hasData) {
                return _buildItem(snapshot.data);
              } else if (snapshot.hasError)
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    snapshot.error.toString(),
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                );
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
    if (flag == 0) {
      await _refreshIds();
      flag++;
    }
    int articleNo = _ids.elementAt(id);
    var url =
    Uri.https("hacker-news.firebaseio.com", "/v0/item/$articleNo.json");
    var response = await http.get(url);
    if (response.statusCode == 200)
      return parseArticle(response.body);
    else
      throw Exception("Response code : ${response.statusCode}");
  }

  Widget _buildItem(Article article) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(article.time * 1000);
    return Card(
      color: Color.fromRGBO(230, 255, 230, 1),
      borderOnForeground: true,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ExpansionTile(
          leading: Text(
            _ids.indexOf(article.id).toString(),
            style: TextStyle(
              fontSize: 24,
              color: Colors.green,
            ),
          ),
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
