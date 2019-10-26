import 'dart:convert';

class CategoryItem {
  String image;
  String video;
  Map<dynamic, dynamic> likes;

  // list of user and no of likes
  List<dynamic> shares;
  String id;

  CategoryItem(this.image, this.likes, this.id, this.shares, this.video);

  @override
  String toString() {
    return JsonCodec().encode({
      'image': image,
      'video': video,
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
    likes = json['likes'] == null ? Map() : json['likes'];
    shares = json['shares'] == null ? List() : json['shares'];
  }

  Map<String, dynamic> getMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['video'] = this.video;
    if (this.likes != Map()) data['likes'] = this.likes;
    if (this.shares != List()) data['shares'] = this.shares;
    return data;
  }
}
