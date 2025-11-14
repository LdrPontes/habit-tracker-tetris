import 'package:blockin/app/auth/ui/blocs/sign_up/sign_up_bloc.dart';
import 'package:blockin/app/auth/ui/components/templates/check_email_template.dart';
import 'package:blockin/app/shared/domain/dto/result.dart';
import 'package:blockin/app/shared/ui/components/molecules/snackbar_service.dart';
import 'package:blockin/core/app_injections.dart';
import 'package:blockin/core/localization/localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckEmailScreen extends StatefulWidget {
  static const String routeName = '/check-email';
  final String email;

  const CheckEmailScreen({super.key, required this.email});

  @override
  State<CheckEmailScreen> createState() => _CheckEmailScreenState();
}

class _CheckEmailScreenState extends State<CheckEmailScreen> {
  final signUpBloc = getIt.get<SignUpBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: signUpBloc,
      child: BlocListener<SignUpBloc, SignUpState>(
        listener: _resendEmailListener,
        listenWhen: (previous, current) =>
            previous.resendEmailResult != current.resendEmailResult,
        child: CheckEmailTemplate(
          email: widget.email,
          onResendEmailPressed: _onResendEmailPressed,
        ),
      ),
    );
  }

  void _resendEmailListener(BuildContext context, SignUpState state) {
    if (state.resendEmailResult is Success) {
      SnackbarService.of(
        context,
      ).success(AppLocalizations.of(context)!.confirm_your_email);
    }
    if (state.resendEmailResult is Error) {
      SnackbarService.of(
        context,
      ).error((state.resendEmailResult as Error).getMessage(context));
    }
  }

  void _onResendEmailPressed() {
    signUpBloc.add(ResendConfirmationEmailEvent(email: widget.email));
  }
}
