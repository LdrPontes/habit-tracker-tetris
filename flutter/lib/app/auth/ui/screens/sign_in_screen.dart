import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/app/auth/domain/dto/sign_in_dto.dart';
import 'package:starter/app/auth/ui/blocs/sign_in/sign_in_bloc.dart';
import 'package:starter/core/app_injections.dart';

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
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _signInListener(BuildContext context, SignInState state) {
    state.userResult.when(
      success: (user) {},
      error: (code, message, exception) {},
    );
  }
}
