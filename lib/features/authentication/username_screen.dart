import 'package:flutter/material.dart';
import 'package:tiktokapp/constants/gaps.dart';
import 'package:tiktokapp/constants/size.dart';
import 'package:tiktokapp/features/authentication/email_screen.dart';
import 'package:tiktokapp/features/authentication/widgets/form_button.dart';

class UsernameScreen extends StatefulWidget {
  const UsernameScreen({Key? key}) : super(key: key);

  @override
  State<UsernameScreen> createState() => _UsernameScreenState();
}

class _UsernameScreenState extends State<UsernameScreen> {
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

// Stateful일 때는 context를 넘겨줄 필요 없음
  void _onNextTap() {
    if (_username.isEmpty) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const EmailScreen(),
      ),
    );
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
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
                'Create username',
                style: TextStyle(
                  fontSize: Sizes.size24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Gaps.v8,
              const Text(
                'You can always change this later.',
                style: TextStyle(
                  fontSize: Sizes.size16,
                  color: Colors.black54,
                ),
              ),
              Gaps.v16,
              TextField(
                autocorrect: false,
                // Controller 등록
                controller: _usernameController,
                decoration: InputDecoration(
                  hintText: 'Username',
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
              // FormButton Widget 추출
              GestureDetector(
                onTap: _onNextTap,
                child: FormButton(disabled: _username.isEmpty),
              )
            ],
          ),
        ),
      ),
    );
  }
}
