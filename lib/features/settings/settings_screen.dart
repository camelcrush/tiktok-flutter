import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktokapp/common/widgets/mode_config/mode_config.dart';
import 'package:tiktokapp/common/widgets/video_config/video_config.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notifications = false;

  void _onNotoficationsChanged(bool? newValue) {
    if (newValue == null) return;
    setState(() {
      _notifications = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: ListView(
        children: [
          // Switch.adaptive(
          //   value: _notifications,
          //   onChanged: _onNotoficationsChanged,
          // ),

          // VideoConfigData.of를 통해 context 및 state 접근
          // SwitchListTile.adaptive(
          //   value: VideoConfigData.of(context).autoMute,
          //   onChanged: (value) => VideoConfigData.of(context).toggleMuted(),
          //   title: const Text("Auto Mute"),
          //   subtitle: const Text("Video will be muted by default"),
          // ),

          // ChageNotifier + AnimatedBuilder를 통한 State 관리
          // AnimatedBuilder 안 위젯만 Rebuild하기 때문에 효율적임
          // AnimatedBuilder(
          //   animation: videoConfig,
          //   builder: (context, child) => SwitchListTile.adaptive(
          //     value: videoConfig.autoMute,
          //     onChanged: (value) => videoConfig.toggleAutoMute(),
          //     title: const Text("Auto Mute"),
          //     subtitle: const Text("Video will be muted by default"),
          //   ),
          // ),

          ValueListenableBuilder(
            valueListenable: modeConfig,
            builder: (context, value, child) => SwitchListTile.adaptive(
              value: value == 'dark' ? true : false,
              onChanged: (value) {
                modeConfig.value = value ? 'dark' : 'light';
              },
              title: const Text('App Mode'),
              subtitle: const Text('Light/Dark Mode'),
            ),
          ),
          // ValueNotifier
          AnimatedBuilder(
            animation: videoConfig,
            builder: (context, child) => SwitchListTile.adaptive(
              value: videoConfig.value,
              onChanged: (value) {
                videoConfig.value = !videoConfig.value;
              },
              title: const Text("Auto Mute"),
              subtitle: const Text("Video will be muted by default"),
            ),
          ),
          SwitchListTile.adaptive(
            value: _notifications,
            onChanged: _onNotoficationsChanged,
            title: const Text("Enable notifications"),
            subtitle: const Text("Enable notifications"),
          ),
          CheckboxListTile(
            activeColor: Colors.black,
            value: _notifications,
            onChanged: _onNotoficationsChanged,
            title: const Text("Enable Notifications"),
            subtitle: const Text("Enable Notifications"),
          ),
          ListTile(
            title: const Text("Log out (IOS)"),
            textColor: Colors.red,
            onTap: () => showCupertinoDialog(
              context: context,
              builder: (context) => CupertinoAlertDialog(
                title: const Text("Are you sure?"),
                content: const Text("Plz don't go"),
                actions: [
                  CupertinoDialogAction(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text("NO"),
                  ),
                  CupertinoDialogAction(
                    onPressed: () => Navigator.of(context).pop(),
                    isDestructiveAction: true,
                    child: const Text("Yes"),
                  )
                ],
              ),
            ),
          ),
          ListTile(
            title: const Text("Log out (Android)"),
            textColor: Colors.red,
            onTap: () => showDialog(
              context: context,
              builder: (context) => AlertDialog(
                icon: const FaIcon(FontAwesomeIcons.skull),
                title: const Text("Are you sure?"),
                content: const Text("Plz don't go"),
                actions: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const FaIcon(FontAwesomeIcons.xmark),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text("Yes"),
                  )
                ],
              ),
            ),
          ),
          ListTile(
            title: const Text("Log out (IOS / Bottom)"),
            textColor: Colors.red,
            onTap: () => showCupertinoModalPopup(
              context: context,
              builder: (context) => CupertinoActionSheet(
                title: const Text("Are you sure?"),
                message: const Text("Plz don't go"),
                actions: [
                  CupertinoActionSheetAction(
                    onPressed: () => Navigator.of(context).pop(),
                    isDefaultAction: true,
                    child: const Text("NO"),
                  ),
                  CupertinoActionSheetAction(
                    onPressed: () => Navigator.of(context).pop(),
                    isDestructiveAction: true,
                    child: const Text("Yes"),
                  )
                ],
              ),
            ),
          ),
          ListTile(
            onTap: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1980),
                lastDate: DateTime(2050),
              );
              if (kDebugMode) {
                print(date);
              }
              if (!mounted) return;
              final time = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              if (kDebugMode) {
                print(time);
              }
              if (!mounted) return;
              final booking = await showDateRangePicker(
                context: context,
                firstDate: DateTime(1980),
                lastDate: DateTime(2050),
                builder: (context, child) {
                  return Theme(
                    data: ThemeData(
                      appBarTheme: const AppBarTheme(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.black,
                      ),
                    ),
                    child: child!,
                  );
                },
              );
              if (kDebugMode) {
                print(booking);
              }
            },
            title: const Text("What is your birthday?"),
          ),
          // showAboutDialog or AboutListTile을 통해 앱 라이센스 법적 고지
          const AboutListTile()
        ],
      ),
    );
  }
}
