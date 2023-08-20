import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:horta593app/blocs/auth/auth_bloc.dart';
import 'package:horta593app/screens/cart/bloc/cart_bloc.dart';
import 'package:horta593app/screens/login/login_screen.dart';
import 'package:horta593app/screens/register/register_screen.dart';
import 'package:horta593app/screens/tracking/bloc/tracking_bloc.dart';

void main() {
  group('RegisterScreen', () {
    testWidgets('Form submission and navigation', (WidgetTester tester) async {
      // Mock the BLoCs
      final TrackingBloc _trackBloc = TrackingBloc();
      final CartBloc _cartBloc = CartBloc();
      final AuthBloc _authBloc = AuthBloc();

      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<CartBloc>(create: (context) => _cartBloc),
            BlocProvider<AuthBloc>(create: (context) => _authBloc),
            BlocProvider<TrackingBloc>(create: (context) => _trackBloc),
          ],
          child: MaterialApp(
            home: RegisterScreen(),
            // Add the other properties if needed like localizationsDelegates, supportedLocales, etc.
          ),
        ),
      );

      print("Aqui");
      print(tester);
      print("");
      // Simulate filling out the form
      await tester.enterText(find.byKey(Key('first_name')), 'Andrea');
      await tester.enterText(find.byKey(Key('last_name')), 'MeroMero');
      await tester.enterText(
          find.byKey(const Key('email')), 'john.doe@example.com');
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
