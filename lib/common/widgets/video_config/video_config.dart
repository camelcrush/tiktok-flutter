import 'package:flutter/widgets.dart';

// ChangeNotifier : 다수의 상태관리 위젯
// 5~10개 미만의 Screen이 있을 경우 State관리가 효율적
class VideoConfig extends ChangeNotifier {
  bool autoMute = false;

  void toggleAutoMute() {
    autoMute = !autoMute;
    notifyListeners();
  }
}

final videoConfig = VideoConfig();


// //  InheritedWidget + StatfuleWidget을 통한 State 관리

// class VideoConfigData extends InheritedWidget {
//   final bool autoMute;
//   final void Function() toggleMuted;

//   const VideoConfigData({
//     super.key,
//     required this.toggleMuted,
//     required this.autoMute,
//     required super.child,
//   });

//   // VideoConfigData를 반환하는 Static Method
//   static VideoConfigData of(BuildContext context) {
//     return context.dependOnInheritedWidgetOfExactType<VideoConfigData>()!;
//   }

//   @override
//   bool updateShouldNotify(covariant InheritedWidget oldWidget) {
//     return true;
//   }
// }

// // InheritedWidget은 Property 접근에 대한 기능을 제공하지만 업데이트 할 수 있는 메커니즘이 없음
// // 따라서 StatefulWidget을 사용하여 Property와 업데이트 Method를 만들어 InheritedWidget에 제공
// // InheritedWidget는 생성자를 통해 Property/Method를 받고 각 위젯에 공유
// class VideoConfig extends StatefulWidget {
//   final Widget child;

//   const VideoConfig({
//     Key? key,
//     required this.child,
//   }) : super(key: key);

//   @override
//   State<VideoConfig> createState() => _VideoConfigState();
// }

// class _VideoConfigState extends State<VideoConfig> {
//   bool autoMute = false;

//   void toggleMuted() {
//     setState(() {
//       autoMute = !autoMute;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return VideoConfigData(
//       toggleMuted: toggleMuted,
//       autoMute: autoMute,
//       child: widget.child,
//     );
//   }
// }
