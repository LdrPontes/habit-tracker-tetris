import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blockin/app/auth/ui/blocs/forgot_password/forgot_password_bloc.dart';
import 'package:blockin/app/auth/ui/components/templates/forgot_password_template.dart';
import 'package:blockin/app/shared/domain/dto/result.dart';
import 'package:blockin/app/shared/ui/components/molecules/snackbar_service.dart';
import 'package:blockin/core/app_injections.dart';
import 'package:blockin/core/localization/localizations.dart';
import 'package:blockin/core/navigation/routes.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const String routeName = '/forgot-password';

  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final forgotPasswordBloc = getIt.get<ForgotPasswordBloc>();

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => forgotPasswordBloc,
      child: BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
        listener: _forgotPasswordListener,
        child: ForgotPasswordTemplate(
          formKey: formKey,
          emailController: emailController,
          onSendResetLinkPressed: _onSendResetLinkPressed,
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
      ).success(AppLocalizations.of(context)!.password_reset_link_sent);
      router.pop();
    }

    if (state.result is Error) {
      SnackbarService.of(
        context,
      ).error((state.result as Error).getMessage(context));
    }
  }

  void _onSendResetLinkPressed() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      forgotPasswordBloc.add(ForgotPasswordEvent(email: emailController.text));
    }
  }
}
