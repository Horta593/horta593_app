import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:horta593app/blocs/auth/auth_bloc.dart';
import 'package:horta593app/widgets/custom_button.dart';
import 'package:horta593app/screens/login/login_screen.dart';
import 'package:flutter/cupertino.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Scaffold(
            body: ListView(
          children: [
            const SizedBox(height: 150),
            const Center(
              child: Image(
                width: 300,
                height: 300,
                image: AssetImage('lib/constants/images/logo_dark.png'),
              ),
            ),
            const SizedBox(height: 100),
            Builder(builder: (context) {
              return CustomButton(
                  text: "Start",
                  onTap: () {
                    Navigator.pushNamed(context, LoginScreen.routeName);
                  });
            })
          ],
        ));
      },
    );
  }
}
