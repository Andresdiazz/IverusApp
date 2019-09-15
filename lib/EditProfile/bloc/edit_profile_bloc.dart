import 'dart:io';

import 'package:cocreacion/EditProfile/model/image_model.dart';
import 'package:cocreacion/Users/model/user.dart';
import 'package:cocreacion/Users/repository/cloud_firestore_repository.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

import '../../SharedPref.dart';

class EditProfileBloc implements Bloc {
  User oldUser;

  EditProfileBloc() {
    isLoadingController.sink.add(false);
    SharedPref().get(SharedPref.user).then((value) {
      oldUser = User.stringToObject(value);

      _nameController.sink.add(oldUser.name);
      _emailController.sink.add(oldUser.email);
      _phoneController.sink.add(oldUser.phone);
      _descController.sink.add(oldUser.desc);
      imageController.sink.add(ImageModel(null, oldUser.photoURL));
      print(value);
    }).catchError((error) {});

    // get user data from shared preferences here to load in screen
  }

  final _cloudFiretoreRepository = CloudFirestoreRepository();
  final _isEditingController = BehaviorSubject<bool>();
  final isLoadingController = BehaviorSubject<bool>();

  final imageController = BehaviorSubject<ImageModel>();

//  name
  final _nameController = BehaviorSubject<String>();

  Observable<String> get name => _nameController.stream;

  Function(String) get changeName => _nameController.sink.add;

//  email

  final _emailController = BehaviorSubject<String>();

  Observable<String> get email => _emailController.stream;

  Function(String) get changeEmail => _emailController.sink.add;

//  phone
  final _phoneController = BehaviorSubject<String>();

  Observable<String> get phone => _phoneController.stream;

  Function(String) get changePhone => _phoneController.sink.add;

//  desc
  final _descController = BehaviorSubject<String>();

  Observable<String> get desc => _descController.stream;

  Function(String) get changeDesc => _descController.sink.add;

  Observable<bool> get isEditing => _isEditingController.stream;

  @override
  void dispose() {
    _isEditingController.close();
    isLoadingController.close();
    _nameController.close();
    _emailController.close();
    _phoneController.close();
    _descController.close();
  }

  updateData() {
    print(oldUser.uid);
    User user = User(
        uid: oldUser.uid,
        name: _nameController.value == null
            ? oldUser.name
            : _nameController.value,
        email: _emailController.value == null
            ? oldUser.email
            : _emailController.value,
        phone: _phoneController.value == null
            ? oldUser.phone
            : _phoneController.value,
        desc: _descController.value == null
            ? oldUser.desc
            : _descController.value,
        points: oldUser.points);

    print(user.toString());

    isLoadingController.sink.add(true);

    if (imageController.value != null) {
      _cloudFiretoreRepository
          .updateImage(user.uid, imageController.value.path,
              imageController.value.path.split("/").last.split(".")[1])
          .then((res) {
        user.photoURL = res.data;
        updateUser(user);
      });
    } else {
      user.photoURL = oldUser.photoURL;

      updateUser(user);
    }
  }

  updateUser(user) {
    _cloudFiretoreRepository.updateUserDataFiretore(user).then((data) {
      isLoadingController.sink.add(false);
      _isEditingController.sink.add(false);

      SharedPref().save(SharedPref.user, user.toString());
    });
  }

  bool validatePhone(String text) {
    Pattern pattern = r'^(?:[+0]9)?[0-9]{10}$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(text))
      return false;
    else
      return true;
  }

  bool validateEmail(String text) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(text))
      return false;
    else
      return true;
  }

  editClicked() {
    _isEditingController.sink.add(true);
  }

  updateImage(File image) {
    imageController.sink.add(ImageModel(image, ""));
  }
}
