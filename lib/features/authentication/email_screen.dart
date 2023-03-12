import 'package:flutter/material.dart';
import 'package:tiktokapp/features/authentication/widgets/form_button.dart';

import '../../constants/gaps.dart';
import '../../constants/size.dart';

class EmailScreen extends StatefulWidget {
  const EmailScreen({Key? key}) : super(key: key);

  @override
  State<EmailScreen> createState() => _UsernameScreenState();
}

class _UsernameScreenState extends State<EmailScreen> {
  // TextEitingController : TextField() 컨트롤러 등록을 위한 변수 선언
  final TextEditingController _usernameController = TextEditingController();
  String _username = "";

  @override
  void initState() {
    super.initState();
    // TextField() Controller EventListener
    _usernameController.addListener(() {
      // _username Sate값 업데이트
      setState(() {
        _username = _usernameController.text;
      });
    });
  }

// 메모리를 위해 꼭 사용한 위젯 Controller dispose해주기
  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size36,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gaps.v40,
            const Text(
              'What is your email?',
              style: TextStyle(
                fontSize: Sizes.size24,
                fontWeight: FontWeight.w700,
              ),
            ),
            Gaps.v16,
            TextField(
              // Controller 등록
              controller: _usernameController,
              decoration: InputDecoration(
                hintText: 'Email',
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade400,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade400,
                  ),
                ),
              ),
              cursorColor: Theme.of(context).primaryColor,
            ),
            Gaps.v28,
            FormButton(disabled: _username.isEmpty),
          ],
        ),
      ),
    );
  }
}
