import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPost extends StatefulWidget {
  // StatefulWidghet에서 property 받기
  final Function onVideoFinished;

  const VideoPost({
    Key? key,
    required this.onVideoFinished,
  }) : super(key: key);

  @override
  State<VideoPost> createState() => _VideoPostState();
}

class _VideoPostState extends State<VideoPost> {
  // VideoPlayerContoller 선언
  final VideoPlayerController _videoPlayerController =
      VideoPlayerController.asset('assets/videos/video.MOV');

  void _onVideoChanged() {
    // _videoPlayerController가 Initialized가 되면
    if (_videoPlayerController.value.isInitialized) {
      // 영상의 총 길이와 현재 재생위치(Position)이 같다면
      if (_videoPlayerController.value.duration ==
          _videoPlayerController.value.position) {
        // StatefulWidget을 통해 받은 onVideoFinished()를 실행
        // widget을 통해 property 접근 가능
        widget.onVideoFinished();
      }
    }
  }

  void _initVideoPlayer() async {
    // VideoPlayerContoller를 반드시 Init하고 Play()해주어야 함, 준비시간 필요
    await _videoPlayerController.initialize();
    _videoPlayerController.play();
    setState(() {});
    // _videoPlayerController에 이벤트리스너 추가
    _videoPlayerController.addListener(_onVideoChanged);
  }

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Positioned.fill : 화면 전체를 채움
        // VideoPlayer(controller)
        Positioned.fill(
          child: _videoPlayerController.value.isInitialized
              ? VideoPlayer(_videoPlayerController)
              : Container(
                  color: Colors.black,
                ),
        ),
      ],
    );
  }
}
