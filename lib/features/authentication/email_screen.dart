import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktokapp/features/authentication/view_models/signup_view_model.dart';
import 'package:tiktokapp/features/authentication/widgets/form_button.dart';
import 'package:tiktokapp/features/authentication/password_screen.dart';
import '../../constants/gaps.dart';
import '../../constants/size.dart';

class EmailScreenArgs {
  final String username;

  EmailScreenArgs({required this.username});
}

class EmailScreen extends ConsumerStatefulWidget {
  final String username;

  const EmailScreen({
    Key? key,
    required this.username,
  }) : super(key: key);

  @override
  ConsumerState<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends ConsumerState<EmailScreen> {
  // TextEitingController : TextField() 컨트롤러 등록을 위한 변수 선언
  final TextEditingController _emailController = TextEditingController();
  String _email = "";

  @override
  void initState() {
    super.initState();
    // TextField() Controller EventListener
    _emailController.addListener(() {
      // _email Sate값 업데이트
      setState(() {
        _email = _emailController.text;
      });
    });
  }

// 메모리를 위해 꼭 사용한 위젯 Controller dispose해주기
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

// Email Validation Check
  String? _isEmailValid() {
    if (_email.isEmpty) return null;
    // Email 형식 정규표현식
    final regExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!regExp.hasMatch(_email)) {
      return 'Email not valid.';
    }
    return null;
  }

// FocusScope : keyboard avoid 기능
  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

// onSubmit
  void _onSubmit() {
    if (_email.isEmpty || _isEmailValid() != null) return;
    // Provider를 이용해 notifier에 state값 추가하기
    final state = ref.read(signUpForm.notifier).state;
    ref.read(signUpForm.notifier).state = {'email': _email, ...state};
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PasswordScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Navigator 1로부터 받은 Args를 가져오는 방법
    // final args = ModalRoute.of(context)!.settings.arguments as EmailScreenArgs;
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
              Text(
                'What is your email?, ${widget.username}',
                style: const TextStyle(
                  fontSize: Sizes.size24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Gaps.v16,
              TextField(
                onEditingComplete: _onSubmit,
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                // Controller 등록
                controller: _emailController,
                decoration: InputDecoration(
                  // errorText
                  errorText: _isEmailValid(),
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
              GestureDetector(
                onTap: _onSubmit,
                child: FormButton(
                  disabled: _email.isEmpty || _isEmailValid() != null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
