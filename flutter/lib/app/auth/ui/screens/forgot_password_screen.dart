import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/app/auth/domain/dto/forgot_password_dto.dart';
import 'package:starter/app/auth/ui/blocs/forgot_password/forgot_password_bloc.dart';
import 'package:starter/app/auth/ui/screens/sign_in_screen.dart';
import 'package:starter/app/shared/domain/dto/result.dart';
import 'package:starter/app/shared/ui/components/molecules/snackbar_service.dart';
import 'package:starter/core/app_injections.dart';
import 'package:starter/core/navigation/routes.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const String routeName = '/forgot-password';

  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final forgotPasswordBloc = getIt.get<ForgotPasswordBloc>();

  final formKey = GlobalKey<FormState>();
  final forgotPasswordDto = ForgotPasswordDto();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => forgotPasswordBloc,
      child: BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
        listener: _forgotPasswordListener,
        child: Scaffold(
          appBar: AppBar(title: const Text('Forgot Password')),
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
                          forgotPasswordDto.email = value;
                        },
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState?.validate() ?? false) {
                            formKey.currentState?.save();
                            forgotPasswordBloc.add(
                              ForgotPasswordEvent(
                                email: forgotPasswordDto.email ?? '',
                              ),
                            );
                          }
                        },
                        child: const Text('Send Reset Link'),
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

  void _forgotPasswordListener(
    BuildContext context,
    ForgotPasswordState state,
  ) {
    if (state.result is Success) {
      SnackbarService.of(
        context,
      ).success('Password reset link sent to your email');
      router.go(SignInScreen.routeName);
    }

    if (state.result is Error) {
      SnackbarService.of(context).error(
        (state.result as Error).getMessage(
          context,
          defaultErrorMessage: 'An unknown error occurred',
        ),
      );
    }
  }
}
