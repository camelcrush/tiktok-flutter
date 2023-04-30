import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tiktokapp/features/authentication/widgets/form_button.dart';

void main() {
  group("From Button Tests", () {
    testWidgets("Enabled State", (widgetTester) async {
      await widgetTester.pumpWidget(
        Theme(
          data: ThemeData(primaryColor: Colors.red),
          child: const Directionality(
            textDirection: TextDirection.ltr,
            child: FormButton(disabled: false),
          ),
        ),
      );
      expect(find.text("Next"), findsOneWidget);
      expect(
        widgetTester
            .firstWidget<AnimatedDefaultTextStyle>(
                find.byType(AnimatedDefaultTextStyle))
            .style
            .color,
        Colors.white,
      );
      expect(
        (widgetTester
                .firstWidget<AnimatedContainer>(find.byType(AnimatedContainer))
                .decoration as BoxDecoration)
            .color,
        Colors.red,
      );
    });

    testWidgets("Disabled State", (widgetTester) async {
      await widgetTester.pumpWidget(
        const MediaQuery(
          data: MediaQueryData(),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: FormButton(disabled: true),
          ),
        ),
      );
      expect(find.text("Next"), findsOneWidget);
      expect(
        widgetTester
            .firstWidget<AnimatedDefaultTextStyle>(
                find.byType(AnimatedDefaultTextStyle))
            .style
            .color,
        Colors.grey.shade400,
      );
    });

    testWidgets("Disabled State Dark Mode", (widgetTester) async {
      await widgetTester.pumpWidget(
        const MediaQuery(
          data: MediaQueryData(platformBrightness: Brightness.dark),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: FormButton(disabled: true),
          ),
        ),
      );
      expect(find.text("Next"), findsOneWidget);
      expect(
        (widgetTester
                .firstWidget<AnimatedContainer>(find.byType(AnimatedContainer))
                .decoration as BoxDecoration)
            .color,
        Colors.grey.shade800,
      );
    });

    testWidgets("Disabled State Light Mode", (widgetTester) async {
      await widgetTester.pumpWidget(
        const MediaQuery(
          data: MediaQueryData(platformBrightness: Brightness.light),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: FormButton(disabled: true),
          ),
        ),
      );
      expect(find.text("Next"), findsOneWidget);
      expect(
        (widgetTester
                .firstWidget<AnimatedContainer>(find.byType(AnimatedContainer))
                .decoration as BoxDecoration)
            .color,
        Colors.grey.shade300,
      );
    });
  });
}
