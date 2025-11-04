import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/app/auth/domain/dto/reset_password_dto.dart';
import 'package:starter/app/auth/ui/blocs/reset_password/reset_password_bloc.dart';
import 'package:starter/app/auth/ui/screens/sign_in_screen.dart';
import 'package:starter/app/shared/domain/dto/result.dart';
import 'package:starter/app/shared/ui/components/molecules/snackbar_service.dart';
import 'package:starter/core/app_injections.dart';
import 'package:starter/core/navigation/routes.dart';

class ResetPasswordScreen extends StatefulWidget {
  static const String routeName = '/reset-password';

  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final resetPasswordBloc = getIt.get<ResetPasswordBloc>();

  final formKey = GlobalKey<FormState>();
  final resetPasswordDto = ResetPasswordDto();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => resetPasswordBloc,
      child: BlocListener<ResetPasswordBloc, ResetPasswordState>(
        listener: _resetPasswordListener,
        child: Scaffold(
          appBar: AppBar(title: const Text('Reset Password')),
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
                        controller: newPasswordController,
                        decoration: const InputDecoration(
                          labelText: 'New Password',
                        ),
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password is required';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          resetPasswordDto.newPassword = value;
                        },
                      ),
                      TextFormField(
                        controller: confirmPasswordController,
                        decoration: const InputDecoration(
                          labelText: 'Confirm Password',
                        ),
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password';
                          }
                          if (value != newPasswordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          resetPasswordDto.confirmPassword = value;
                        },
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState?.validate() ?? false) {
                            formKey.currentState?.save();
                            resetPasswordBloc.add(
                              ResetPasswordEvent(
                                newPassword: resetPasswordDto.newPassword ?? '',
                              ),
                            );
                          }
                        },
                        child: const Text('Reset Password'),
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

  void _resetPasswordListener(BuildContext context, ResetPasswordState state) {
    if (state.result is Success) {
      SnackbarService.of(context).success('Password reset successfully');
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

  @override
  void dispose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
