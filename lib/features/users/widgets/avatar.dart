import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktokapp/constants/size.dart';
import 'package:tiktokapp/features/users/view_models/avatar_view_model.dart';

class Avatar extends ConsumerWidget {
  final String name;
  final bool hasAvatar;
  final String uid;
  final double size;

  const Avatar({
    super.key,
    required this.name,
    required this.hasAvatar,
    required this.uid,
    this.size = 50,
  });

  Future<void> _onAvatarTap(WidgetRef ref, BuildContext context) async {
    // ImagePicker를 통해 갤러리에서 사진 선택
    final xFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 40,
      maxHeight: 150,
      maxWidth: 150,
    );
    if (xFile != null) {
      final file = File(xFile.path);
      // upload avatar
      ref.read(avatarProvider.notifier).uploadAvatar(file, context);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(avatarProvider).isLoading;
    return GestureDetector(
      onTap: isLoading ? null : () => _onAvatarTap(ref, context),
      child: isLoading
          ? Container(
              width: size,
              height: size,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: const CircularProgressIndicator(),
            )
          : CircleAvatar(
              radius: size,
              // NetworkImage는 기본적으로 캐시를 사용하여 이미지를 한 번 불러오면 수정하지 않음
              // 따라서 이미지URL 끝에 &haha${DateTime.now().toString()}을 추가하여
              // URL이 바뀐 것처럼 Flutter를 속여서 Fetching하게 만듦
              foregroundImage: hasAvatar
                  ? NetworkImage(
                      "https://firebasestorage.googleapis.com/v0/b/tiktok-camel.appspot.com/o/avatars%2F$uid?alt=media&token=0eab2817-2e90-4c5c-9585-e213fe3b15fe&haha=${DateTime.now().toString()}")
                  : null,
              child: Center(
                child: Text(
                  name,
                  style: const TextStyle(fontSize: Sizes.size6),
                ),
              ),
            ),
    );
  }
}
