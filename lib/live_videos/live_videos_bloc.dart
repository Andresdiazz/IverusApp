import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

import 'live_video_model.dart';

class LiveVideosBloc extends Bloc {
  final _videosController = BehaviorSubject<List<LiveVideoModel>>();

  Observable<List<LiveVideoModel>> get videos => _videosController.stream;

  LiveVideosBloc() {
    List<LiveVideoModel> videos = List();
    Map<String, String> actions = Map();
    actions["No"] = "456";
    actions["Yes"] = "789";
    actions["Other"] = "321";

    videos.add(LiveVideoModel(12, "123", "Are you hydrated?", "", actions));
    videos.add(LiveVideoModel(12, "456", "Yes", "", actions));
    videos.add(LiveVideoModel(12, "789", "No", "", actions));
    videos.add(LiveVideoModel(12, "321", "Other", "", actions));

    _videosController.add(videos);
  }

  @override
  void dispose() {
    _videosController.close();
  }

  getVideo(String videoId) {
    return _videosController.value[0];
  }
}
