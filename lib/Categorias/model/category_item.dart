import 'dart:convert';

class CategoryItem {
  String image;
  List<dynamic> likes;
  String id;

  CategoryItem(this.image, this.likes, this.id);

  @override
  String toString() {
    return JsonCodec().encode({
      'image': image,
      'likes': likes,
    });
  }

  static CategoryItem stringToObject(String json) {
    var data = JsonCodec().decode(json) as Map<String, dynamic>;
    return CategoryItem.fromJson(data);
  }

  CategoryItem.fromJson(Map<dynamic, dynamic> json) {
    if (json == null) return;
    image = json['image'] == null ? null : json['image'];
    likes = json['likes'] == null ? List() : json['likes'];
  }

  Map<String, dynamic> getMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    if (this.likes != List()) data['likes'] = this.likes;
    return data;
  }
}
