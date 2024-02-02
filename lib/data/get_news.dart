import 'dart:convert';

import 'package:project_news/domains/models/articles_entity.dart';
import 'package:http/http.dart' as http;

class GetNews {
  Future<List<Article>> fetchNews({required String keyword}) async {
    var url =
        'https://newsapi.org/v2/everything?q=$keyword&language=en&apiKey=d5646c6a41fc455abb7a6de16525eb52';
    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);
    List<Article> newsList = [];
    ;
    if (response.statusCode == 200) {
      for (var article in jsonData['articles']) {
        if (article['urlToImage'] != null) {
          Article data = Article.fromJson(article);
          newsList.add(data);
        }
      }
      return newsList;
    } else {
      return newsList;
    }
  }
}
