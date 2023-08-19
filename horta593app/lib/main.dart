import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:horta593app/screens/home_screen.dart';
import 'package:horta593app/constants/global_variables.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:horta593app/router.dart';
import 'package:horta593app/screens/tracking/bloc/tracking_bloc.dart';

import 'blocs/auth/auth_bloc.dart';
import 'screens/cart/bloc/cart_bloc.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  final TrackingBloc _trackBloc = TrackingBloc();
  final CartBloc _cartBloc = CartBloc();
  final AuthBloc _authBloc = AuthBloc();
  // const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => _cartBloc),
        BlocProvider(create: (context) => _authBloc),
        BlocProvider(create: (context) => _trackBloc),
      ],
      child: MaterialApp(
        title: 'Horta593',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            scaffoldBackgroundColor: GlobalVariables.primarybackground,
            colorScheme: const ColorScheme.light(
                primary: GlobalVariables.secondaryColor)),
        onGenerateRoute: (settings) => generateRoute(settings),
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthLoadingState) {
              return const HomeScreen();
            } else {
              return const HomeScreen();
            }
          },
        ),
        localizationsDelegates: const [
          FormBuilderLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''),
          // Locale('pt', ''),
          // Locale('es', ''),
          // Locale('fa', ''),
          // Locale('fr', ''),
          // Locale('ja', ''),
          // Locale('sk', ''),
          // Locale('pl', ''),
        ],
      ),
    );
  }
}
