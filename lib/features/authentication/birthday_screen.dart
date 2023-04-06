import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiktokapp/constants/gaps.dart';
import 'package:tiktokapp/constants/size.dart';
import 'package:tiktokapp/features/authentication/widgets/form_button.dart';
import 'package:tiktokapp/features/onboarding/interests_screen.dart';

class BirthdayScreen extends StatefulWidget {
  const BirthdayScreen({Key? key}) : super(key: key);

  @override
  State<BirthdayScreen> createState() => _BirthdayScreenState();
}

class _BirthdayScreenState extends State<BirthdayScreen> {
  // TextEitingController : TextField() 컨트롤러 등록을 위한 변수 선언
  final TextEditingController _birthdayController = TextEditingController();
  late DateTime initialDate;

  @override
  void initState() {
    super.initState();
    // 12세 연령제한 적용
    DateTime now = DateTime.now();
    initialDate = DateTime(now.year - 12);
    _setTextFieldDate(initialDate);
  }

// 메모리를 위해 꼭 사용한 위젯 Controller dispose해주기
  @override
  void dispose() {
    _birthdayController.dispose();
    super.dispose();
  }

// Stateful일 때는 context를 넘겨줄 필요 없음
  void _onNextTap() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const InterestsScreen(),
        ),
        (route) => false);
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  void _setTextFieldDate(DateTime date) {
    final textDate = date.toString().split(" ").first;
    // Controller를 통해 TextField에 Value 넣기
    _birthdayController.value = TextEditingValue(text: textDate);
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
                "When's your birthday?",
                style: TextStyle(
                  fontSize: Sizes.size24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Gaps.v8,
              const Text(
                "Your birthday won't be shown publicly.",
                style: TextStyle(
                  fontSize: Sizes.size16,
                  color: Colors.black54,
                ),
              ),
              Gaps.v16,
              TextField(
                autocorrect: false,
                // Controller 등록
                controller: _birthdayController,
                decoration: InputDecoration(
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
                child: const FormButton(disabled: false),
              )
            ],
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: 300,
          // CupertinoDatePicker 위젯
          child: CupertinoDatePicker(
            maximumDate: initialDate,
            initialDateTime: initialDate,
            mode: CupertinoDatePickerMode.date,
            onDateTimeChanged: _setTextFieldDate,
          ),
        ),
      ),
    );
  }
}
