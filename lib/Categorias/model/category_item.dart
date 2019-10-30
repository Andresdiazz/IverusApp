import 'dart:convert';

class CategoryItem {
  String image;
  String video;
  String trivia;
  String name;
  String tipo;
  String tree;
  Map<dynamic, dynamic> likes;
  // list of user and no of likes
  List<dynamic> shares;
  String id;

  CategoryItem(this.image, this.likes, this.id, this.shares, this.video ,this.trivia,this.name,this.tipo,this.tree);

  @override
  String toString() {
    return JsonCodec().encode({
      'image': image,
      'video': video,
      'trivia': trivia,
      'name': name,
      'tipo': tipo,
      'tree': tree,
      'likes': likes,
      'shares': shares,
    });
  }

  static CategoryItem stringToObject(String json) {
    var data = JsonCodec().decode(json) as Map<String, dynamic>;
    return CategoryItem.fromJson(data);
  }

  CategoryItem.fromJson(Map<dynamic, dynamic> json) {
    if (json == null) return;
    image = json['image'] == null ? null : json['image'];
    video = json['video'] == null ? null : json['video'];
    name = json['name'] == null ? null : json['name'];
    trivia = json['trivia'] == null ? null : json['trivia'];
    tipo = json['tipo'] == null ? null : json['tipo'];
    tree = json['tree'] == null ? null : json['tree'];
    likes = json['likes'] == null ? Map() : json['likes'];
    shares = json['shares'] == null ? List() : json['shares'];
  }

  Map<String, dynamic> getMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['video'] = this.video;
    data['trivia'] = this.trivia;
    data['name'] = this.name;
    data['tipo'] = this.tipo;
    data['tree'] = this.tree;
    if (this.likes != Map()) data['likes'] = this.likes;
    if (this.shares != List()) data['shares'] = this.shares;
    return data;
  }
}
