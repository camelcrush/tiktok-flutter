import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktokapp/constants/gaps.dart';
import 'package:tiktokapp/constants/size.dart';
import 'package:tiktokapp/features/authentication/view_models/login_view_model.dart';
import 'package:tiktokapp/features/authentication/widgets/form_button.dart';

class LoginFormScreen extends ConsumerStatefulWidget {
  const LoginFormScreen({super.key});

  @override
  ConsumerState<LoginFormScreen> createState() => _LoginFormScreenState();
}

class _LoginFormScreenState extends ConsumerState<LoginFormScreen> {
  // Global formKey : Form에 key값을 부여하여 어디서든지 접근가능하게 함
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Map<String, String> formData = {};

  void _onSubmitTap() {
    // FormKey의 State값이 Null일 수도 있기 때문에 반드시 체크
    if (_formKey.currentState != null) {
      // !를 표현하여 Null이 아님을 체크
      if (_formKey.currentState!.validate()) {
        // FormKey State값 저장
        _formKey.currentState!.save();
        // pushAndRemoveUntil
        // push()는 새로운 화면을 위에다가 stack하기 때문에 뒤로가기를 막기위에서는
        // 지난 route history를 삭제해야 함. (route) => false;
        // Navigator.of(context).pushAndRemoveUntil(
        //     MaterialPageRoute(
        //       builder: (context) => const InterestsScreen(),
        //     ),
        //     (route) => false);

        // Snack을 보여주기 위해 context를 전달해 주어야 함
        ref.read(loginProvider.notifier).login(
              formData['email']!,
              formData['password']!,
              context,
            );
        // context.goNamed(InterestsScreen.routeName);
      }
    }
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
          title: const Text('Log In'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size36,
          ),
          child: Form(
            // Form에 Global Key 부여
            key: _formKey,
            child: Column(
              children: [
                Gaps.v28,
                TextFormField(
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
                  // FormField의 자체적인 Validator를 설정할 수 있음
                  validator: (value) {
                    final regEx = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                    // Null방지를 위해 반드시 Null이 아닌지 체크해줘야 함
                    if (value != null) {
                      if (value.isEmpty) {
                        return 'Please write your email';
                      } else if (!regEx.hasMatch(value)) {
                        return 'Wrong Email';
                      }
                    }
                    return null;
                  },
                  // Validation이 통과되면 State값을 fromData에 저장
                  onSaved: (newValue) {
                    if (newValue != null) {
                      formData['email'] = newValue;
                    }
                  },
                ),
                Gaps.v16,
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Password',
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
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return 'Please write your password';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    if (newValue != null) {
                      formData['password'] = newValue;
                    }
                  },
                ),
                Gaps.v28,
                GestureDetector(
                  onTap: _onSubmitTap,
                  child: FormButton(
                    disabled: ref.watch(loginProvider).isLoading,
                    formText: 'Log In',
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
