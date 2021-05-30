import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:world_news/models/article.dart';
import 'package:world_news/secret.dart';

class News {
  List<Article> news = [];
  // var country;

  String url;

  // get countr =>country;

  Future<void> getNews(String country) async {
    if (country != null) {
      url =
          "http://newsapi.org/v2/top-headlines?country=$country&excludeDomains=stackoverflow.com&sortBy=publishedAt&apiKey=$apiKey";
    } else {
      url =
          "http://newsapi.org/v2/top-headlines?country='in'&excludeDomains=stackoverflow.com&sortBy=publishedAt&apiKey=$apiKey";
    }
    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          Article article = Article(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            publshedAt: DateTime.parse(element['publishedAt']),
            content: element["content"],
            articleUrl: element["url"],
          );
          news.add(article);
        }
      });
    }
  }
}

class NewsForCategorie {
  List<Article> news = [];
  String url;
  Future<void> getNewsForCategory(String category, String country) async {
    if (country != null) {
      url =
          "http://newsapi.org/v2/top-headlines?country=$country&category=$category&apiKey=$apiKey";
    } else {
      url =
          "http://newsapi.org/v2/top-headlines?country='in'&category=$category&apiKey=$apiKey";
    }
    /*String url = "http://newsapi.org/v2/everything?q=$category&apiKey=${apiKey}";*/

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          Article article = Article(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            publshedAt: DateTime.parse(element['publishedAt']),
            content: element["content"],
            articleUrl: element["url"],
          );
          news.add(article);
        }
      });
    }
  }
}
