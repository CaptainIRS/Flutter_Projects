import 'dart:developer';

import 'package:flutter_test/flutter_test.dart';
import 'package:hacker_news_app/json_parser.dart';
import 'package:http/http.dart' as http;

void main() {
  test("Parsing topstories json", () {
    const String topStoriesJson = "[21373852,21373931,21356203]";
    expect(parseTopStories(topStoriesJson).first, 21373852);
  });

  test("Parsing article json", () {
    const String articleJson =
        """ {"by":"dhouston","descendants":71,"id":8863,"kids":[9224,8917,8952,8884,8887,8869,8958,8940,8908,9005,8873,9671,9067,9055,8865,8881,8872,8955,10403,8903,8928,9125,8998,8901,8902,8907,8894,8870,8878,8980,8934,8943,8876],"score":104,"time":1175714200,"title":"My YC app: Dropbox - Throw away your USB drive","type":"story","url":"http://www.getdropbox.com/u/2/screencast.html"} """;
    expect(parseArticle(articleJson).by, "dhouston");
  });

  test("Parsing article from network", () async {
    var articleNo = 21373931;
    var url =
        Uri.https("hacker-news.firebaseio.com", "/v0/item/$articleNo.json");
    var response = await http.get(url);
    if (response.statusCode == 200)
      expect(parseArticle(response.body).by, "gcj");
    else
      throw ServiceExtensionResponse.error(response.statusCode, response.body);
  });
}
