import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/app/auth/ui/blocs/sign_in/sign_in_bloc.dart';
import 'package:starter/core/app_injections.dart';

class SignInScreen extends StatelessWidget {
  static const String routeName = '/sign-in';

  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final signInBloc = getIt.get<SignInBloc>();

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
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => signInBloc.add(
                          SignInWithEmailEvent(email: '', password: ''),
                        ),
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
