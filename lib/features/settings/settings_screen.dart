import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: ListView(
        children: [
          ListTile(
            // showAboutDialog or AboutListTile을 통해 앱 라이센스 법적 고지
            onTap: () => showAboutDialog(
                context: context,
                applicationVersion: "1.0",
                applicationLegalese:
                    "All rights reseverd. Please dont copy me."),
            title: const Text(
              "About",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: const Text("About this app..."),
          ),
          const AboutListTile()
        ],
      ),
    );
  }
}
