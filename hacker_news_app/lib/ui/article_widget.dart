import 'package:flutter/material.dart';
import 'package:hacker_news_app/model/article.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

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
                  child: Text(DateFormat('dd MMMM, yyyy - hh:mm:ss a')
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