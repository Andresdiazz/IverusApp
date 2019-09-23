import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocreacion/Categorias/model/category_item.dart';
import 'package:cocreacion/Users/model/user.dart';
import 'package:cocreacion/Users/repository/cloud_firestore_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

import '../../SharedPref.dart';

class CategoriesBloc extends Bloc {
  List<CategoryItem> items;
  final _categoriesController = BehaviorSubject<List<CategoryItem>>();

  Observable<List<CategoryItem>> get categories => _categoriesController.stream;

  final itemController = BehaviorSubject<CategoryItem>();

  Observable<CategoryItem> get item => itemController.stream;

  final _cloudFirestoreRepository = CloudFirestoreRepository();

  User user;
  String category;

  CategoriesBloc(this.category) {
    SharedPref().get(SharedPref.user).then((value) {
      user = User.stringToObject(value);
    }).catchError((error) {});

    getCategories(category);
  }

  updateLike(String videoId, String table, bool isLike) {
    CategoryItem i = items.lastWhere((q) => q.id == videoId);

    List<String> likes;

    likes = i.likes == null ? List() : List<String>.from(i.likes);

    if (isLike)
      likes.add(user.uid);
    else
      likes.remove(user.uid);

    i.likes = likes;

    itemController.sink.add(i);
    _cloudFirestoreRepository
        .updateLikes(user.uid, videoId, table, isLike)
        .then((res) {
      getCategories(category);
    }).then((error) {});
  }

  updateShare(String videoId, String table) {
    _cloudFirestoreRepository
        .updateShare(user.uid, videoId, table)
        .then((res) {})
        .then((error) {});
  }

  getCategories(String category) {
    _cloudFirestoreRepository.getCategoryData(category).then((res) {
      var result = res.data as List<DocumentSnapshot>;
      items = List();
      result.forEach((data) {
        var item = CategoryItem.fromJson(data.data);
        item.id = data.documentID;
        items.add(item);
      });

      _categoriesController.sink.add(items);
    }).then((error) {});
  }

  @override
  void dispose() {
    _categoriesController.close();
    itemController.close();
  }
}
