import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktokapp/features/authentication/widgets/form_button.dart';
import 'package:tiktokapp/features/authentication/birthday_screen.dart';
import '../../../constants/gaps.dart';
import '../../../constants/size.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({Key? key}) : super(key: key);

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  // TextEitingController : TextField() 컨트롤러 등록을 위한 변수 선언
  final TextEditingController _passwordController = TextEditingController();
  String _password = "";

  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    // TextField() Controller EventListener
    _passwordController.addListener(() {
      // _password Sate값 업데이트
      setState(() {
        _password = _passwordController.text;
      });
    });
  }

// 메모리를 위해 꼭 사용한 위젯 Controller dispose해주기
  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

// Email Validation Check
  bool _isPasswordValid() {
    return _password.isNotEmpty && _password.length > 8;
    // Here's another regex that satisfies the following:
    // 1. It must be longer than 8 alphanumeric characters
    // 2. It must include both alphabet and numbers
    // 3. It must include at least one special character

    // final regExp = RegExp(
    // r"^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[@$!%*#?&\^])[A-Za-z0-9@$!%*#?&\^]{9,}$")
  }

// FocusScope : keyboard avoid 기능
  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

// onSubmit
  void _onSubmit() {
    if (!_isPasswordValid()) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const BirthdayScreen(),
      ),
    );
  }

  void _onClearTap() {
    _passwordController.clear();
  }

  void _toggleObscureText() {
    _obscureText = !_obscureText;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // Keyboard Avoiding을 위해 GestureDetector 위젯 사용
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
                'Password',
                style: TextStyle(
                  fontSize: Sizes.size24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Gaps.v16,
              TextField(
                // password 숨김표시
                obscureText: _obscureText,
                onEditingComplete: _onSubmit,
                autocorrect: false,
                // Controller 등록
                controller: _passwordController,
                decoration: InputDecoration(
                  // prefix와 suffix가 있음
                  suffix: Row(
                    // Row는 공간을 최대한 활용할려고 함 따라서 Size.min
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: _onClearTap,
                        child: FaIcon(
                          FontAwesomeIcons.solidCircleXmark,
                          color: Colors.grey.shade500,
                          size: Sizes.size20,
                        ),
                      ),
                      Gaps.h16,
                      GestureDetector(
                        onTap: _toggleObscureText,
                        child: FaIcon(
                          _obscureText
                              ? FontAwesomeIcons.eye
                              : FontAwesomeIcons.eyeSlash,
                          color: Colors.grey.shade500,
                          size: Sizes.size20,
                        ),
                      ),
                    ],
                  ),
                  hintText: 'Make it strong!',
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
              Gaps.v10,
              const Text(
                'Your password must have:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gaps.v10,
              Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.circleCheck,
                    size: Sizes.size20,
                    color: _isPasswordValid()
                        ? Colors.green
                        : Colors.grey.shade400,
                  ),
                  Gaps.h5,
                  const Text('8 to 20 characters')
                ],
              ),
              Gaps.v28,
              GestureDetector(
                onTap: _onSubmit,
                child: FormButton(
                  disabled: !_isPasswordValid(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
