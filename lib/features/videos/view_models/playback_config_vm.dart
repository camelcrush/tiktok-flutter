import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktokapp/features/videos/models/playback_config_model.dart';
import 'package:tiktokapp/features/videos/repos/playback_config_repo.dart';

// View에 필요한 데이터들 (State)을 유지하고, View와 연관된 비지니스 로직을 처리한다.
// 비지니스 로직 처리 중 필요한 데이터는 Data Layer을 통해 받아오거나 저장한다.

class PlaybackConfigViewModel extends Notifier<PlaybackConfigModel> {
  final PlaybackConfigRepository _repository;

  PlaybackConfigViewModel(this._repository);

  void setMuted(bool value) {
    _repository.setMuted(value);
    state = PlaybackConfigModel(
      muted: value,
      autoplay: state.autoplay,
    );
  }

  void setAutoplay(bool value) {
    _repository.setAutoplay(value);
    state = PlaybackConfigModel(
      muted: state.muted,
      autoplay: value,
    );
  }

  @override
  PlaybackConfigModel build() {
    return PlaybackConfigModel(
      muted: _repository.isMuted(),
      autoplay: _repository.isAutoplay(),
    );
  }
}

// Provider 만들기
// 여기서는 repository가 main.dart에서 초기화 되기 때문에 임시로 에러를 던지고
// main.dart에서 override로 초기화 시킴
final playbackConfigProvider =
    NotifierProvider<PlaybackConfigViewModel, PlaybackConfigModel>(
  () => throw UnimplementedError(),
);


// Provider Version + Change Notifier

// class PlaybackConfigViewModel extends ChangeNotifier {
//   final PlaybackConfigRepository _repository;

//   // Model(data) Init
//   late final PlaybackConfigModel _model = PlaybackConfigModel(
//     muted: _repository.isMuted(),
//     autoplay: _repository.isAutoplay(),
//   );
//   // Constructor를 통해 Repository 받기
//   PlaybackConfigViewModel(this._repository);

//   // Model(Data) Getter
//   bool get muted => _model.muted;
//   bool get autoplay => _model.autoplay;

//   void setMuted(bool value) {
//     _repository.setMuted(value);
//     _model.muted = value;
//     notifyListeners();
//   }

//   void setAutoplay(bool value) {
//     _repository.setAutoplay(value);
//     _model.autoplay = value;
//     notifyListeners();
//   }
// }
