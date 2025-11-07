import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blockin/app/auth/domain/dto/sign_in_dto.dart';
import 'package:blockin/app/auth/ui/blocs/sign_in/sign_in_bloc.dart';
import 'package:blockin/app/auth/ui/screens/sign_up_screen.dart';
import 'package:blockin/app/auth/ui/screens/forgot_password_screen.dart';
import 'package:blockin/app/shared/domain/dto/result.dart';
import 'package:blockin/app/shared/ui/components/molecules/snackbar_service.dart';
import 'package:blockin/core/app_injections.dart';
import 'package:blockin/core/navigation/routes.dart';
import 'package:blockin/app/board/ui/screens/home_screen.dart';

class SignInScreen extends StatefulWidget {
  static const String routeName = '/sign-in';

  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final signInBloc = getIt.get<SignInBloc>();

  final formKey = GlobalKey<FormState>();
  final signInDto = SignInDto();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => signInBloc,
      child: BlocListener<SignInBloc, SignInState>(
        listener: _signInListener,
        child: Scaffold(
          appBar: AppBar(title: const Text('Sign In')),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Email'),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email is required';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          signInDto.email = value;
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Password',
                        ),
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password is required';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          signInDto.password = value;
                        },
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () =>
                              router.push(ForgotPasswordScreen.routeName),
                          child: const Text('Forgot Password?'),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState?.validate() ?? false) {
                            formKey.currentState?.save();
                            signInBloc.add(
                              SignInWithEmailEvent(
                                email: signInDto.email ?? '',
                                password: signInDto.password ?? '',
                              ),
                            );
                          }
                        },
                        child: const Text('Sign In with Email'),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 48),
                ElevatedButton(
                  onPressed: () => signInBloc.add(SignInWithGoogleEvent()),
                  child: const Text('Sign In with Google'),
                ),
                ElevatedButton(
                  onPressed: () => signInBloc.add(SignInWithAppleEvent()),
                  child: const Text('Sign In with Apple'),
                ),
                const Divider(height: 48),
                ElevatedButton(
                  onPressed: () => router.push(SignUpScreen.routeName),
                  child: const Text('Sign Up'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _signInListener(BuildContext context, SignInState state) {
    if (state.userResult is Success) {
      SnackbarService.of(context).success('Sign in successful');
      router.go(TetrisDemoScreen.routeName);
    }

    if (state.userResult is Error) {
      SnackbarService.of(context).error(
        (state.userResult as Error).getMessage(
          context,
          defaultErrorMessage: 'An unknown error occurred',
        ),
      );
    }
  }
}
