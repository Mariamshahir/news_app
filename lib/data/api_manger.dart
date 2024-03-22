import 'dart:convert';
import 'package:http/http.dart';
import 'package:news_app/model/sourceresponse.dart';

abstract class ApiManger {
  static Future<SourcesResponse> loadTabsList() async {
    try {
      Uri url = Uri.parse(
          "https://newsapi.org/v2/top-headlines/sources?apiKey=33b14b5ea9f741c09675d37a14d1ad31");
      Response response = await get(url);
      print("v2/top-headlines/sources(Body)-> ${response.body}");
      Map mapBody = jsonDecode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        SourcesResponse sourcesResponse = SourcesResponse.fromJson(mapBody);
        return sourcesResponse;
      } else {
        throw "Something went wrong please try again later";
      }
    } catch (e) {
      rethrow;
    }
  }
}
