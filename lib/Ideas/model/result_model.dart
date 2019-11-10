import 'dart:convert';

class ResultModel {
  String id;
  String time;
  Map<dynamic, dynamic> ranks;

  ResultModel({this.id, this.time, this.ranks});

  @override
  String toString() {
    return JsonCodec().encode({
      'id': id,
      'time': time,
      'ranks': ranks,
    });
  }

  static ResultModel stringToObject(String json) {
    var data = JsonCodec().decode(json) as Map<String, dynamic>;
    return ResultModel.fromJson(data);
  }

  ResultModel.fromJson(Map<dynamic, dynamic> json) {
    if (json == null) return;
    id = json['id'] == null ? null : json['id'];
    ranks = json['ranks'] == null ? null : json['ranks'];
    time = json['time'] == null ? null : json['time'];
  }

  Map<String, dynamic> getMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.ranks != null) data['ranks'] = this.ranks;
    if (this.time != null) data['time'] = this.time;
    return data;
  }
}
