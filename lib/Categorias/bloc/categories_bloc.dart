import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocreacion/Categorias/model/category_item.dart';
import 'package:cocreacion/Users/model/user.dart';
import 'package:cocreacion/Users/repository/cloud_firestore_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

import '../../SharedPref.dart';

class CategoriesBloc extends Bloc {
  final _categoriesController = BehaviorSubject<List<CategoryItem>>();

  Observable<List<CategoryItem>> get categories => _categoriesController.stream;

  final _cloudFiretoreRepository = CloudFirestoreRepository();
  User user;

  CategoriesBloc() {
    SharedPref().get(SharedPref.user).then((value) {
      user = User.stringToObject(value);
    }).catchError((error) {});

    getCategories();
  }

  updateLike(String videoId, String table, bool isLike) {
    _cloudFiretoreRepository
        .updateLikes(user.uid, videoId, table, isLike)
        .then((res) {})
        .then((error) {});
  }

  getCategories() {
    _cloudFiretoreRepository.getCategoryData("belleza").then((res) {
      var result = res.data as List<DocumentSnapshot>;
      List<CategoryItem> items = List();
      result.forEach((data) {
        var item = CategoryItem.fromJson(data.data);
        item.id = data.documentID;
        items.add(item);
      });

      _categoriesController.sink.add(items);
    }).then((error) {});
  }

  @override
  void dispose() {}
}
