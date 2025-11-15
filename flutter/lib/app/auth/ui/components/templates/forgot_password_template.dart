import 'package:blockin/app/auth/ui/blocs/forgot_password/forgot_password_bloc.dart';
import 'package:blockin/app/shared/domain/dto/result.dart';
import 'package:blockin/app/shared/ui/components/atoms/typography.dart';
import 'package:blockin/app/shared/ui/components/molecules/blockin_app_bar.dart';
import 'package:blockin/app/shared/ui/components/molecules/button.dart';
import 'package:blockin/app/shared/ui/components/molecules/input.dart';
import 'package:blockin/core/localization/localizations.dart';
import 'package:blockin/theme/constants/spacing.dart';
import 'package:blockin/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordTemplate extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final VoidCallback onSendResetLinkPressed;

  const ForgotPasswordTemplate({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.onSendResetLinkPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: BlockinAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Spacing.xxxxLarge),
        child: SingleChildScrollView(
          child: Column(
            children: [
              (MediaQuery.of(context).size.height * 0.23).h,
              _buildForm(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          BlockinText.headingLarge(
            AppLocalizations.of(context)!.forgot_password_title,
          ),
          Spacing.xxLarge.h,
          BlockinInput(
            controller: emailController,
            hint: AppLocalizations.of(context)!.email,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
            validator: (value) => Validators.email(context, value),
            onSaved: (value) => emailController.text = value ?? '',
          ),
          Spacing.xxLarge.h,
          BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
            buildWhen: (previous, current) => previous.result != current.result,
            builder: (context, state) {
              return BlockinButton(
                text: AppLocalizations.of(context)!.send_reset_link,
                isLoading: state.result is Loading,
                onPressed: onSendResetLinkPressed,
              );
            },
          ),
        ],
      ),
    );
  }
}
