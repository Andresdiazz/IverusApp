import 'package:cocreacion/Users/repository/cloud_firestore_repository.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

import 'live_video_model.dart';

class LiveVideosBloc extends Bloc {
  final CloudFirestoreRepository _repository = CloudFirestoreRepository();
  final _videoController = BehaviorSubject<LiveVideoModel>();
  var showPoints = List<dynamic>();

  Observable<LiveVideoModel> get video => _videoController.stream;

  LiveVideosBloc() {
    _repository.getTutorial().then((value) {
      LiveVideoModel data = LiveVideoModel.fromJson(value.data);
      _videoController.add(LiveVideoModel.fromJson(value.data));
      showPoints = data.askAt.keys.toList();
    });
  }

  Map<dynamic, dynamic> getOptions(String askAtId) {
    Map<dynamic, dynamic> options =
        _videoController.value.askAt[askAtId.toString()];
    return options;
  }

  @override
  void dispose() {
    _videoController.close();
  }
}
