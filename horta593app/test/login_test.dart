import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:horta593app/blocs/auth/auth_bloc.dart';
import 'package:horta593app/screens/login/bloc/login_bloc.dart';
import 'package:horta593app/screens/login/login_screen.dart';
import 'package:mockito/mockito.dart';

void main() {
  testWidgets('Login screen test', (WidgetTester tester) async {
    // Mocking auth and login blocs
    final authBloc = AuthBloc(); // Mock your auth bloc
    final loginBloc = LoginBloc(); // Mock your login bloc

    // Wrap the LoginScreen with necessary providers and widgets
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<AuthBloc>.value(
          value: authBloc,
          child: MaterialApp(
            home: BlocProvider<LoginBloc>.value(
              value: loginBloc,
              child: LoginScreen(),
            ),
          ),
        ),
      ),
    );

    // Ensure that the login form is rendered
    expect(find.byKey(const Key('email_field')), findsOneWidget);
    expect(find.byKey(const Key('password_field')), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Sign Up'), findsOneWidget);

    // Fill in the email and password fields
    await tester.enterText(
        find.byKey(const Key('email_field')), 'test@example.com');
    await tester.enterText(
        find.byKey(const Key('password_field')), 'password123');

    // Tap the login button
    await tester.tap(find.text('Login'));
    await tester.pump();

    // Verify that the login request was triggered
    verify(loginBloc.add(
      const LoginRequestEvent(
          email: 'test@example.com', password: 'password123'),
    )).called(1);
  });
}
