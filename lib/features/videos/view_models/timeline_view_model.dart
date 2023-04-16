import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktokapp/features/videos/models/video_model.dart';

class TimelineViewModel extends AsyncNotifier<List<VideoModel>> {
  // Fake API Data
  List<VideoModel> _list = [];

  Future<void> uploadVideo() async {
    // State 불러오기
    state = const AsyncValue.loading();
    // upload 영역
    await Future.delayed(const Duration(seconds: 2));
    final newVideo = VideoModel(title: "${DateTime.now()}");
    _list = [..._list, newVideo];
    // State 없데이트를 통해 Rebuild
    state = AsyncValue.data(_list);
  }

  // API로 데이터 불러오는 영역
  @override
  FutureOr<List<VideoModel>> build() async {
    await Future.delayed(const Duration(seconds: 2));
    return _list;
  }
}

// Provider 생성
final timelineProvider =
    AsyncNotifierProvider<TimelineViewModel, List<VideoModel>>(
  () => TimelineViewModel(),
);
