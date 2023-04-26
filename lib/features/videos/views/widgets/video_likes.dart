import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktokapp/features/videos/view_models/video_post_view_model.dart';
import 'package:tiktokapp/features/videos/views/widgets/vidoe_button.dart';

class VideoLikes extends ConsumerStatefulWidget {
  final int likes;
  final String videoId;

  const VideoLikes({
    super.key,
    required this.videoId,
    required this.likes,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VideoLikesState();
}

class _VideoLikesState extends ConsumerState<VideoLikes> {
  int _likeCount = 0;

  @override
  void initState() {
    super.initState();
    _likeCount = widget.likes;
  }

  void _onLikeTap(bool isLiked) {
    // Notifier에 Args를 넘겨서 state를 초기화 하는 방법
    ref.read(videoPostProvider(widget.videoId).notifier).toggleLike();
    // 아래 방법으로 대체해도 됨
    // ref.read(videoPostProvider.notifier).likeVideo(widget.videoData.id);
    if (isLiked) {
      _likeCount--;
    } else {
      _likeCount++;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(videoPostProvider(widget.videoId)).when(
          loading: () => GestureDetector(
            onTap: null,
            child: VideoButton(
              icon: Icons.favorite,
              text: "$_likeCount",
              iconColor: Colors.white,
            ),
          ),
          error: (error, stackTrace) => const SizedBox(),
          data: (isLiked) {
            return GestureDetector(
              onTap: () => _onLikeTap(isLiked),
              child: VideoButton(
                icon: Icons.favorite,
                text: "$_likeCount",
                iconColor: isLiked ? Colors.red.shade400 : Colors.white,
              ),
            );
          },
        );
  }
}
