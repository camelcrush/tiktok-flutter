import 'package:flutter/material.dart';
import 'package:tiktokapp/constants/size.dart';

class StfScreen extends StatefulWidget {
  const StfScreen({Key? key}) : super(key: key);

  @override
  State<StfScreen> createState() => _StfScreenState();
}

class _StfScreenState extends State<StfScreen> {
  int _clicks = 0;

  void _increase() {
    setState(() {
      _clicks = _clicks + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "$_clicks",
            style: const TextStyle(
              fontSize: Sizes.size48,
            ),
          ),
          TextButton(onPressed: _increase, child: const Text('+'))
        ],
      ),
    );
  }
}
