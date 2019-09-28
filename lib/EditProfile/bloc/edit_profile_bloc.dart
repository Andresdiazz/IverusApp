import 'dart:io';
import 'package:cocreacion/EditProfile/model/image_model.dart';
import 'package:cocreacion/Users/model/user.dart';
import 'package:cocreacion/Users/repository/auth_repository.dart';
import 'package:cocreacion/Users/repository/cloud_firestore_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

import '../../SharedPref.dart';

class EditProfileBloc implements Bloc {
  User oldUser;
  bool _completeProfile;
  FirebaseUser user;

  EditProfileBloc(this._completeProfile) {
    isLoadingController.sink.add(false);
    if (_completeProfile) {
      _isEditingController.sink.add(true);
      FirebaseAuth.instance.currentUser().then((user) {
        this.user = user;
        _phoneController.sink.add(user.phoneNumber);
      });
    } else {
      SharedPref().get(SharedPref.user).then((value) {
        oldUser = User.stringToObject(value);
        _nameController.sink.add(oldUser.name);
        _emailController.sink.add(oldUser.email);
        _phoneController.sink.add(oldUser.phone);
        _descController.sink.add(oldUser.desc);
        imageController.sink.add(ImageModel(null, oldUser.photoURL));
      }).catchError((error) {});
    }
    // get user data from shared preferences here to load in screen
  }
  final _auth_repository = AuthRepository();
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
    imageController.close();
  }

  Future<void> updateData() {
    User user;
    if (_completeProfile) {
      user = User(
          uid: this.user.uid,
          name: _nameController.value,
          email: _emailController.value,
          phone: _phoneController.value,
          desc: _descController.value == null ? "" : _descController.value,
          points: 0);
    } else {
      user = User(
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
    }

    isLoadingController.sink.add(true);

    if (imageController.value.file != null) {
      return _cloudFiretoreRepository
          .updateImage(user.uid, imageController.value.file.path,
              imageController.value.file.path.split("/").last.split(".")[1])
          .then((res) {
        user.photoURL = res.data;
        return updateUser(user);
      });
    } else {
      user.photoURL = oldUser.photoURL;

      return updateUser(user);
    }
  }

  Future<void> updateUser(user) {
    return _cloudFiretoreRepository.updateUserDataFiretore(user).then((data) {
      isLoadingController.sink.add(false);
      _isEditingController.sink.add(false);

      SharedPref().save(SharedPref.user, user.toString()).then((value) {
        return;
      });
    });
  }

  bool validatePhone(String text) {
//    Pattern pattern = r'^(?:[+0]9)?[0-9]{10}$';
//    RegExp regex = new RegExp(pattern);
//    if (!regex.hasMatch(text))
    if (text.length >= 10 && text.length < 15)
      return true;
    else
      return false;
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
