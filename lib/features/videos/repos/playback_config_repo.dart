import 'package:shared_preferences/shared_preferences.dart';

// DB, API Data, 디바이스 로컬 디스크 등과 read/save 작업을 하는 Repository
class PlaybackConfigRepository {
  static const String _muted = "muted";
  static const String _autoplay = "autoplay";

  final SharedPreferences _preferences;

  PlaybackConfigRepository(this._preferences);

  Future<void> setMuted(bool value) async {
    _preferences.setBool(_muted, value);
  }

  Future<void> setAutoplay(bool value) async {
    _preferences.setBool(_autoplay, value);
  }

  bool isMuted() {
    return _preferences.getBool(_muted) ?? false;
  }

  bool isAutoplay() {
    return _preferences.getBool(_autoplay) ?? false;
  }
}
