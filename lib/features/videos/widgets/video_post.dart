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

// [ Mixins ]
// Mixin은 생성자가 없는 클래스를 의미한다.
// Mixin 클래스는 상속을 할 때 extends를 하지 않고 with 를 사용한다.
// Mixin의 핵심은 여러 클래스에 재사용이 가능하다는 점이다.
// extends와 차이점은 extend를 하게 되면 확장한 그 클래스는 부모 클래스가 되지만 with는 부모의 인스턴스 관계가 된다.
// 단순하게 mixin 내부의 프로퍼티를 갖고 오는 거라고 생각하면 쉽다.

class _VideoPostState extends State<VideoPost>
    with SingleTickerProviderStateMixin {
// Provides a single [Ticker] that is configured to only tick while the current tree is enabled, as defined by [TickerMode].
// To create the [AnimationController] in a [State] that only uses a single [AnimationController], mix in this class, then pass vsync: this to the animation controller constructor.

  // VideoPlayerContoller 선언
  final VideoPlayerController _videoPlayerController =
      VideoPlayerController.asset('assets/videos/video.MOV');

  final Duration _animationDuration = const Duration(milliseconds: 200);

  bool _isPaused = false;

  // AnimationController 선언
  late AnimationController _animationController;

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

    // AnimationController 위젯 셋팅
    _animationController = AnimationController(
      // animation이 부드럽게 재생되기 위해서는 Ticker가 필요하고,
      // SingleTickerProviderStateMixin이 화면이 활성화 되었을 때 Ticker를 생성해 준다.
      vsync: this,
      lowerBound: 1.0,
      upperBound: 1.5,
      value: 1.5,
      duration: _animationDuration,
    );

    // Build Wideget이 Animation Value값이 변할 때마다 렌더링을 하기 위해서는 setState를 통해
    // 1.5 ~1.0 사이값을 인지할 수 있도록 해 주어야 함
    // AnimationContoller가 변할 때마다 setState()시키기
    // _animationController.addListener(() {
    //   setState(() {});
    // });
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
      // AnimationContoller 되감기
      _animationController.reverse();
    } else {
      _videoPlayerController.play();
      // AnimationController 앞으로감기
      _animationController.forward();
    }
    setState(() {
      _isPaused = !_isPaused;
    });
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
          Positioned.fill(
              // IgnorePointer : Tap 무시해주는 위젯
              child: IgnorePointer(
            child: Center(
              // AnimatedBuilder : AnimationController값이 변할 때마다 bulder를 실행해주는 위젯
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  // Transform.scale 값을 child로 전달
                  return Transform.scale(
                    scale: _animationController.value,
                    // child는 밑에 AnimatedOpacity임
                    child: child,
                  );
                },
                child: AnimatedOpacity(
                  opacity: _isPaused ? 1 : 0,
                  duration: _animationDuration,
                  child: const FaIcon(
                    FontAwesomeIcons.play,
                    color: Colors.white,
                    size: Sizes.size52,
                  ),
                ),
              ),
            ),
          ))
        ],
      ),
    );
  }
}
