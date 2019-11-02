import 'dart:convert';

class LiveVideoModel {
  Map<dynamic, dynamic> askAt;
  String id;
  String url;

  LiveVideoModel(this.askAt, this.id, this.url);

  @override
  String toString() {
    return JsonCodec().encode({
      'ask_at': askAt,
      'id': id,
      'url': url,
    });
  }

  static LiveVideoModel stringToObject(String json) {
    var data = JsonCodec().decode(json) as Map<String, dynamic>;
    return LiveVideoModel.fromJson(data);
  }

  LiveVideoModel.fromJson(Map<dynamic, dynamic> json) {
    if (json == null) return;
    askAt = json['ask_at'] == null ? null : json['ask_at'];
    id = json['id'] == null ? null : json['id'];
    url = json['url'] == null ? null : json['url'];
  }
}
