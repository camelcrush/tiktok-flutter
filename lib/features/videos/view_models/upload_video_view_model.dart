import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktokapp/features/authentication/repos/authentication_repo.dart';
import 'package:tiktokapp/features/users/view_models/users_view_model.dart';
import 'package:tiktokapp/features/videos/models/video_model.dart';
import 'package:tiktokapp/features/videos/repos/videos_repo.dart';

class UploadVideoViewModel extends AsyncNotifier<void> {
  late final VideosRepository _repository;

  @override
  FutureOr<void> build() {
    _repository = ref.read(videosRepo);
  }

  Future<void> uploadVideo(
      File video, Map<String, dynamic> formData, BuildContext context) async {
    final user = ref.read(authRepo).user;
    final userProfile = ref.read(usersProvider).value;
    if (userProfile == null) return;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final task = await _repository.uploadVideo(
        video,
        user!.uid,
      );
      await _repository.saveVideo(
        VideoModel(
          title: formData['title'] ?? '',
          description: formData['description'] ?? '',
          fileUrl: await task.ref.getDownloadURL(),
          thumbnailUrl: '',
          creatorUid: user.uid,
          creator: userProfile.name,
          likes: 0,
          comments: 0,
          createdAt: DateTime.now().millisecondsSinceEpoch,
        ),
      );
      context.go("/home");
    });
  }
}

final uploadVideoProvider = AsyncNotifierProvider<UploadVideoViewModel, void>(
  () => UploadVideoViewModel(),
);
