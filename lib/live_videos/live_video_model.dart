import 'dart:convert';

class LiveVideoModel {
  int askAt;
  String id;
  String name;
  String url;
  Map<dynamic, dynamic> actions;

  LiveVideoModel(this.askAt, this.id, this.name, this.url, this.actions);

  @override
  String toString() {
    return JsonCodec().encode({
      'ask_at': askAt,
      'id': id,
      'name': name,
      'url': url,
      'actions': actions,
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
    name = json['name'] == null ? null : json['name'];
    url = json['url'] == null ? null : json['url'];
    actions = json['actions'] == null ? Map() : json['actions'];
  }
}
