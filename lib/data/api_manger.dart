import 'dart:convert';
import 'package:http/http.dart';
import 'package:news_app/model/articlesresponse.dart';
import 'package:news_app/model/sourceresponse.dart';

abstract class ApiManger {
  static const String defaultErrorMessage = "Something went please again later";
  static const String baseUrl = "https://newsapi.org";
  static const String apiKey = "6af14948fd6745599c51cba10ef9b859";

  static Future<SourcesResponse> loadTabsList(String categoryId) async {
    try {
      Uri url = Uri.parse(
          "$baseUrl/v2/top-headlines/sources?apiKey=$apiKey&category=$categoryId");
      Response response = await get(url);
      //print("v2/top-headlines/sources(Body)-> ${response.body}");
      Map mapBody = jsonDecode(response.body);
      SourcesResponse sourcesResponse = SourcesResponse.fromJson(mapBody);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return sourcesResponse;
      } else {
        throw sourcesResponse.message ?? defaultErrorMessage;
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<ArticlesResponse> loadArticlesList(String sourceId,
      {language = 'en'}) async {
    try {
      Uri url = Uri.parse(
          "$baseUrl/v2/everything?apiKey=$apiKey&sources=$sourceId&language=$language");
      Response apiResponse = await get(url);
      ArticlesResponse articlesResponse =
          ArticlesResponse.fromJson(jsonDecode(apiResponse.body));
      if (apiResponse.statusCode >= 200 && apiResponse.statusCode < 300) {
        return articlesResponse;
      } else {
        throw articlesResponse.message ?? defaultErrorMessage;
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<ArticlesResponse> loadSearchArticles(String query,{language = 'en'}) async {
    try {
      Uri url = Uri.parse(
          "$baseUrl/v2/everything?q=$query &apiKey=$apiKey&language=$language");
      Response apiResponse = await get(url);
      ArticlesResponse articlesResponse =
          ArticlesResponse.fromJson(jsonDecode(apiResponse.body));
      if (apiResponse.statusCode >= 200 && apiResponse.statusCode < 300) {
        return articlesResponse;
      } else {
        throw articlesResponse.message ?? defaultErrorMessage;
      }
    } catch (e) {
      rethrow;
    }
  }
}
