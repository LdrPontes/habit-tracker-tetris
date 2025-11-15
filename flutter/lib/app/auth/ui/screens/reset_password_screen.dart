import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blockin/app/auth/ui/blocs/reset_password/reset_password_bloc.dart';
import 'package:blockin/app/auth/ui/components/templates/reset_password_template.dart';
import 'package:blockin/app/auth/ui/screens/sign_in_screen.dart';
import 'package:blockin/app/shared/domain/dto/result.dart';
import 'package:blockin/app/shared/ui/components/molecules/snackbar_service.dart';
import 'package:blockin/core/app_injections.dart';
import 'package:blockin/core/localization/localizations.dart';
import 'package:blockin/core/navigation/routes.dart';

class ResetPasswordScreen extends StatefulWidget {
  static const String routeName = '/reset-password';

  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final resetPasswordBloc = getIt.get<ResetPasswordBloc>();

  final formKey = GlobalKey<FormState>();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => resetPasswordBloc,
      child: BlocListener<ResetPasswordBloc, ResetPasswordState>(
        listener: _resetPasswordListener,
        child: ResetPasswordTemplate(
          formKey: formKey,
          newPasswordController: newPasswordController,
          confirmPasswordController: confirmPasswordController,
          onResetPasswordPressed: _onResetPasswordPressed,
        ),
      ),
    );
  }

  void _resetPasswordListener(BuildContext context, ResetPasswordState state) {
    if (state.result is Success) {
      SnackbarService.of(
        context,
      ).success(AppLocalizations.of(context)!.password_reset_successfully);
      router.pop();
    }

    if (state.result is Error) {
      SnackbarService.of(
        context,
      ).error((state.result as Error).getMessage(context));
    }
  }

  void _onResetPasswordPressed() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      resetPasswordBloc.add(
        ResetPasswordEvent(newPassword: newPasswordController.text),
      );
    }
  }
}
