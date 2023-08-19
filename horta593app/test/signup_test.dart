import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:horta593app/screens/login/login_screen.dart';
import 'package:horta593app/screens/register/register_screen.dart';

void main() {
  group('RegisterScreen', () {
    testWidgets('Form submission and navigation', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: RegisterScreen(),
        ),
      );

      // Simulate filling out the form
      await tester.enterText(find.byKey(const Key('first_name')), 'John');
      await tester.enterText(find.byKey(Key('last_name')), 'Doe');
      await tester.enterText(find.byKey(Key('email')), 'john.doe@example.com');
      await tester.enterText(find.byKey(Key('password')), 'password');

      // Tap the Register button
      await tester.tap(find.text('Register'));
      await tester.pumpAndSettle();

      // Ensure that the success snackbar is displayed
      expect(find.text('Register Successfully'), findsOneWidget);

      // Ensure that navigation to the LoginScreen occurs
      expect(find.byType(LoginScreen), findsOneWidget);
    });
  });
}
