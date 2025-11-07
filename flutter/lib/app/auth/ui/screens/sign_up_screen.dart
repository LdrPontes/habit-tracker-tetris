import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blockin/app/auth/domain/dto/sign_up_dto.dart';
import 'package:blockin/app/auth/ui/blocs/sign_up/sign_up_bloc.dart';
import 'package:blockin/app/shared/domain/dto/result.dart';
import 'package:blockin/app/shared/ui/components/molecules/snackbar_service.dart';
import 'package:blockin/core/app_injections.dart';
import 'package:blockin/core/navigation/routes.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = '/sign-up';

  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final signUpBloc = getIt.get<SignUpBloc>();

  final formKey = GlobalKey<FormState>();
  final signUpDto = SignUpDto();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => signUpBloc,
      child: BlocListener<SignUpBloc, SignUpState>(
        listener: _signUpListener,
        child: Scaffold(
          appBar: AppBar(title: const Text('Sign Up')),
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
                        decoration: const InputDecoration(labelText: 'Name'),
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Name is required';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          signUpDto.fullName = value;
                        },
                      ),
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
                          signUpDto.email = value;
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
                          signUpDto.password = value;
                        },
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState?.validate() ?? false) {
                            formKey.currentState?.save();
                            signUpBloc.add(SignUpEvent(signUpDto: signUpDto));
                          }
                        },
                        child: const Text('Sign Up with Email'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _signUpListener(BuildContext context, SignUpState state) {
    if (state.userResult is Success) {
      SnackbarService.of(context).success('Confirm your email and sign in');
      router.pop();
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
