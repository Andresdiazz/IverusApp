import 'dart:convert';

class Likes {
  List<String> cpersonal;
  List<String> belleza;

  Likes({this.cpersonal, this.belleza});

  Likes.fromJson(Map<dynamic, dynamic> json) {
    cpersonal = json['cpersonal'].cast<String>();
    belleza = json['belleza'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cpersonal'] = this.cpersonal;
    data['belleza'] = this.belleza;
    return data;
  }

  @override
  String toString() {
    return JsonCodec().encode({'cpersonal': cpersonal, 'belleza': belleza});
  }
}
