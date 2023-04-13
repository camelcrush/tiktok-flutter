import 'package:flutter/widgets.dart';

// InheritedWidget
class VideoConfig extends InheritedWidget {
  const VideoConfig({
    super.key,
    required super.child,
  });

  final bool autoMute = false;

  // VideoConfig를 반환하는 Static Method
  static VideoConfig of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<VideoConfig>()!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}
