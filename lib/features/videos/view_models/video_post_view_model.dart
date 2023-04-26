import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktokapp/features/authentication/repos/authentication_repo.dart';
import 'package:tiktokapp/features/videos/repos/videos_repo.dart';

// FamilyAsyncNotifier : Arg를 받아 state값을 초기화할 수 있음
class VideoPostViewModel extends FamilyAsyncNotifier<bool, String> {
  late final VideosRepository _repository;
  late final String _videoId;
  bool _isLiked = false;

  @override
  FutureOr<bool> build(String arg) async {
    // arg를 통해 state값 초기화
    _videoId = arg;
    _repository = ref.read(videosRepo);
    final user = ref.read(authRepo).user!;
    _isLiked = await _repository.isLiked(_videoId, user.uid);
    return _isLiked;
  }

  Future<void> toggleLike() async {
    final user = ref.read(authRepo).user;
    await _repository.toggleLike(
      _videoId,
      user!.uid,
    );
    _isLiked = !_isLiked;
    state = AsyncData(_isLiked);
  }
}

// AsyncNotifierProvider.family : Arg를 통해 notifier 초기화할 때 아래 family 추가
final videoPostProvider =
    AsyncNotifierProvider.family<VideoPostViewModel, bool, String>(
  () => VideoPostViewModel(),
);
