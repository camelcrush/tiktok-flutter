import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktokapp/features/videos/models/video_model.dart';
import 'package:tiktokapp/features/videos/repos/videos_repo.dart';

class TimelineViewModel extends AsyncNotifier<List<VideoModel>> {
  late VideosRepository _repository;
  List<VideoModel> _list = [];

  // Private Method로서 초기 화면 Init시에 비디오 fetch, fetchNextPage fetch할 때 호출
  Future<List<VideoModel>> _fetchVideos({int? lastItemCreatedAt}) async {
    final result = await _repository.fetchVideos(
      lastItemCreatedAt: lastItemCreatedAt,
    );
    final videos = result.docs.map(
      (doc) => VideoModel.fromJson(
        json: doc.data(),
        videoId: doc.id,
      ),
    );
    return videos.toList();
  }

  // 초기 화면 Init 시 lastItemCreatedAt:null 로 fetchVideo 호출
  @override
  FutureOr<List<VideoModel>> build() async {
    _repository = ref.read(videosRepo);
    _list = await _fetchVideos(lastItemCreatedAt: null);
    return _list;
  }

  // fetchNextPage 호출
  Future<void> fetchNextPage() async {
    final nextPage =
        await _fetchVideos(lastItemCreatedAt: _list.last.createdAt);
    // _list에 새로운 page data를 추가한 후 state 저장
    state = AsyncValue.data([..._list, ...nextPage]);
  }

  Future<void> refresh() async {
    final video = await _fetchVideos(lastItemCreatedAt: null);
    // _list에 복사
    _list = video;
    state = AsyncValue.data(video);
  }
}

// Provider 생성
final timelineProvider =
    AsyncNotifierProvider<TimelineViewModel, List<VideoModel>>(
  () => TimelineViewModel(),
);
