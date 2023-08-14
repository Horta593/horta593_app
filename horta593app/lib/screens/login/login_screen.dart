import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:horta593app/blocs/auth/auth_bloc.dart';
import 'package:horta593app/exceptions/form_exceptions.dart';
import 'package:horta593app/screens/register/register_screen.dart';
import 'package:horta593app/widgets/form_error_widget.dart';

import '../../constants/global_variables.dart';
import '../home/base_screen.dart';
import 'bloc/login_bloc.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = 'login-screen/';
  LoginScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormBuilderState>();

  void submitForm(BuildContext context) {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final data = _formKey.currentState?.value;

      context.read<LoginBloc>().add(
            LoginRequestEvent(
              email: data!['email'],
              password: data['password'],
            ),
          );
    }
  }

  Future<bool> popScreen(state) async {
    return state is! LoginLoadingState;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        return BlocProvider(
          create: (context) => LoginBloc(),
          child: BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginSuccessState) {
                context.read<AuthBloc>().add(AuthAuthenticateEvent(state.user));

                Navigator.pushNamed(context, BaseScreen.routeName);
              }
            },
            builder: (context, state) {
              return buildLoginScreen(context, state);
            },
          ),
        );
      },
    );
  }

  Widget buildLoginScreen(BuildContext context, LoginState state) {
    return WillPopScope(
      onWillPop: () => popScreen(state),
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: buildLoginForm(state),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLoginForm(LoginState state) {
    return FormBuilder(
      key: _formKey,
      child: Builder(builder: (context) {
        if (state is LoginErrorState) {
          if (state.exception is FormFieldsException) {
            for (var error
                in (state.exception as FormFieldsException).errors.entries) {
              _formKey.currentState?.invalidateField(
                name: error.key,
                errorText: error.value,
              );
            }
          }
        }

        return Column(
          children: [
            Builder(builder: (context) {
              if (state is LoginErrorState) {
                if (state.exception is FormGeneralException) {
                  return Column(
                    children: [
                      FormErrorWidget(
                        (state.exception as FormGeneralException).message,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  );
                }
              }
              return Container();
            }),
            const Image(
                width: 300,
                height: 300,
                image: AssetImage('lib/constants/images/logo_dark.png')),
            const SizedBox(
              height: 30,
            ),
            Container(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: FormBuilderTextField(
                style: const TextStyle(color: GlobalVariables.whitebackgound),
                name: 'email',
                decoration: const InputDecoration(
                    labelStyle: TextStyle(
                        color: GlobalVariables.whitebackgound, fontSize: 14),
                    labelText: "Email",
                    contentPadding: EdgeInsets.all(10),
                    hintStyle: TextStyle(color: GlobalVariables.greyHorta),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: GlobalVariables.greenHorta,
                    )),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: GlobalVariables.greenHorta,
                    ))),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(context),
                  FormBuilderValidators.email(context),
                ]),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: FormBuilderTextField(
                style: const TextStyle(color: GlobalVariables.whitebackgound),
                name: 'password',
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(context),
                  FormBuilderValidators.minLength(context, 8)
                ]),
                decoration: const InputDecoration(
                    labelStyle: TextStyle(
                        fontSize: 14, color: GlobalVariables.whitebackgound),
                    labelText: "Password",
                    contentPadding: EdgeInsets.all(10),
                    hintStyle: TextStyle(color: GlobalVariables.greyHorta),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: GlobalVariables.greenHorta,
                    )),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: GlobalVariables.greenHorta,
                    ))),
                obscureText: true,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) {
                  if (state is! AuthLoadingState) {
                    submitForm(context);
                  }
                },
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            MaterialButton(
                color: GlobalVariables.secondaryColor,
                onPressed: () {
                  if (state is! LoginLoadingState) {
                    submitForm(context);
                  }
                },
                child: const SizedBox(
                  width: 280,
                  child: Text(
                    'Login',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                )),
            OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterScreen(),
                    ),
                  );
                },
                child: const SizedBox(
                  width: 280,
                  child: Text(
                    'Sign Up',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                )),
          ],
        );
      }),
    );
  }
}
