import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktokapp/constants/size.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPost extends StatefulWidget {
  // StatefulWidghet에서 property 받기
  final Function onVideoFinished;

  final int index;

  const VideoPost({
    Key? key,
    required this.onVideoFinished,
    required this.index,
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

  void _onVisibilityChanged(VisibilityInfo info) {
    // info.visibleFraction 전체화면에서 해당 위젯이 차지하는 비율
    // 영상이 전체화면이고 재생중이 아니라면 영상 재생
    if (info.visibleFraction == 1 && !_videoPlayerController.value.isPlaying) {
      _videoPlayerController.play();
    }
  }

  void _onTogglePause() {
    if (_videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
    } else {
      _videoPlayerController.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key("${widget.index}"),
      onVisibilityChanged: _onVisibilityChanged,
      child: Stack(
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
          Positioned.fill(
            child: GestureDetector(
              onTap: _onTogglePause,
            ),
          ),
          const Positioned.fill(
              // IgnorePointer : Tap 무시해주는 위젯
              child: IgnorePointer(
            child: Center(
              child: FaIcon(
                FontAwesomeIcons.play,
                color: Colors.white,
                size: Sizes.size52,
              ),
            ),
          ))
        ],
      ),
    );
  }
}
