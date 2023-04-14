import 'package:flutter/material.dart';
import 'package:tiktokapp/features/videos/models/playback_config_model.dart';
import 'package:tiktokapp/features/videos/repos/playback_config_repo.dart';

// View에 필요한 데이터들 (State)을 유지하고, View와 연관된 비지니스 로직을 처리한다.
// 비지니스 로직 처리 중 필요한 데이터는 Data Layer을 통해 받아오거나 저장한다.
class PlaybackConfigViewModel extends ChangeNotifier {
  final PlaybackConfigRepository _repository;

  // Model(data) Init
  late final PlaybackConfigModel _model = PlaybackConfigModel(
    muted: _repository.isMuted(),
    autoplay: _repository.isAutoplay(),
  );
  // Constructor를 통해 Repository 받기
  PlaybackConfigViewModel(this._repository);

  // Model(Data) Getter
  bool get muted => _model.muted;
  bool get autoplay => _model.autoplay;

  void setMuted(bool value) {
    _repository.setMuted(value);
    _model.muted = value;
    notifyListeners();
  }

  void setAutoplay(bool value) {
    _repository.setAutoplay(value);
    _model.autoplay = value;
    notifyListeners();
  }
}
