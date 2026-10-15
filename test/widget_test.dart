import 'dart:ui' show Size;

import 'package:flutter_test/flutter_test.dart';

import 'package:tutor_match_ai/app.dart';

void main() {
  testWidgets('Home shows tutors and navigates to Login', (tester) async {
    tester.view.physicalSize = const Size(1400, 1200);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(const TutorMatchApp());
    expect(find.text('Sample Tutors'), findsOneWidget);

    await tester.tap(find.text('Get Started'));
    await tester.pumpAndSettle();
    expect(find.text('Login (demonstration only)'), findsOneWidget);
  });

  testWidgets('Login shows errors for empty input', (tester) async {
    tester.view.physicalSize = const Size(1400, 1200);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(const TutorMatchApp());
    await tester.tap(find.text('Get Started'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Login').last);
    await tester.pump();
    expect(find.text('Please enter your email address.'), findsOneWidget);
    expect(find.text('Please enter your password.'), findsOneWidget);
  });
}
