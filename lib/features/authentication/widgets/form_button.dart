import 'package:flutter/material.dart';
import 'package:tiktokapp/utils.dart';

import '../../../constants/size.dart';

class FormButton extends StatelessWidget {
  const FormButton({
    super.key,
    required this.disabled,
    this.formText = "Next",
  });

  final bool disabled;
  final String formText;

  @override
  Widget build(BuildContext context) {
    // [ FractionallySizedBox ]
    // 부모 사이즈의 퍼센트로 크기를 줄 수 있음.
    return FractionallySizedBox(
      widthFactor: 1,
      // AnimatedContainer : duration 필수
      child: AnimatedContainer(
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size16,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Sizes.size5),
          color: disabled
              ? isDarkMode(context)
                  ? Colors.grey.shade800
                  : Colors.grey.shade300
              : Theme.of(context).primaryColor,
        ),
        duration: const Duration(milliseconds: 500),
        // AnimatedDefaultTextStyle : duration 필수
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 500),
          style: TextStyle(
            color: disabled ? Colors.grey.shade400 : Colors.white,
            fontWeight: FontWeight.w600,
          ),
          child: Text(
            formText,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
