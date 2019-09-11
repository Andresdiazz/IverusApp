import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

class EditProfileBloc implements Bloc {
  final _isEditingController = BehaviorSubject<bool>();

  Observable<bool> get isEditing => _isEditingController.stream;

  EditProfileBloc() {
    // get user data from shared preferences here to load in screen
  }

  @override
  void dispose() {
    _isEditingController.close();
  }
}
