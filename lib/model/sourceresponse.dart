import 'package:news_app/model/source.dart';

class SourcesResponse {
  String? status;
  List<Source>? sources;

  SourcesResponse({this.status, this.sources});

  SourcesResponse.fromJson(dynamic json) {
    status = json['status'];
    if (json['sources'] != null) {
      sources = <Source>[];
      json['sources'].forEach((v) {
        sources!.add(new Source.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.sources != null) {
      data['sources'] = this.sources!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}