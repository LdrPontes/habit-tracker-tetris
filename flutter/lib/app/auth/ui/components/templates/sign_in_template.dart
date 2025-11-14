import 'package:blockin/app/auth/ui/blocs/sign_in/sign_in_bloc.dart';
import 'package:blockin/app/auth/ui/components/molecules/auth_divider.dart';
import 'package:blockin/app/auth/ui/components/molecules/social_buttons.dart';
import 'package:blockin/app/shared/domain/dto/result.dart';
import 'package:blockin/app/shared/ui/components/atoms/typography.dart';
import 'package:blockin/app/shared/ui/components/molecules/blockin_app_bar.dart';
import 'package:blockin/app/shared/ui/components/molecules/button.dart';
import 'package:blockin/app/shared/ui/components/molecules/input.dart';
import 'package:blockin/core/localization/localizations.dart';
import 'package:blockin/theme/constants/spacing.dart';
import 'package:blockin/theme/theme.dart';
import 'package:blockin/utils/validators.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SignInTemplate extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onForgotPasswordPressed;
  final VoidCallback onSignUpPressed;
  final VoidCallback onGoogleSignInPressed;
  final VoidCallback onAppleSignInPressed;
  final VoidCallback onSignInPressed;

  const SignInTemplate({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.onForgotPasswordPressed,
    required this.onSignUpPressed,
    required this.onGoogleSignInPressed,
    required this.onAppleSignInPressed,
    required this.onSignInPressed,
  });

  @override
  State<SignInTemplate> createState() => _SignInTemplateState();
}

class _SignInTemplateState extends State<SignInTemplate> {
  bool obscureText = true;

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
              Spacing.xxLarge.h,
              const AuthDivider(),
              Spacing.xxLarge.h,
              SocialButtons(
                onGooglePressed: widget.onGoogleSignInPressed,
                onApplePressed: widget.onAppleSignInPressed,
              ),
              Spacing.xxLarge.h,
              _signUpCallToAction(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          BlockinText.headingLarge(AppLocalizations.of(context)!.sign_in_title),
          Spacing.xxLarge.h,
          BlockinInput(
            controller: widget.emailController,
            hint: AppLocalizations.of(context)!.email,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: (value) => Validators.email(context, value),
            onSaved: (value) => widget.emailController.text = value ?? '',
          ),
          Spacing.small.h,
          BlockinInput(
            controller: widget.passwordController,
            hint: AppLocalizations.of(context)!.password,
            obscureText: obscureText,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            validator: (value) => Validators.password(context, value),
            onSaved: (value) => widget.passwordController.text = value ?? '',
            endContent: IconButton(
              onPressed: () {
                setState(() {
                  obscureText = !obscureText;
                });
              },
              icon: Icon(
                obscureText
                    ? PhosphorIconsBold.eye
                    : PhosphorIconsBold.eyeSlash,
              ),
            ),
          ),
          Spacing.xxLarge.h,
          BlockinRichText(
            children: [
              BlockinTextSpan(
                text: AppLocalizations.of(context)!.forgot_password,
                color: Theme.of(context).colors.secondary,
                variant: BlockinTextVariant.link,
                recognizer: TapGestureRecognizer()
                  ..onTap = widget.onForgotPasswordPressed,
              ),
            ],
          ),
          Spacing.xxLarge.h,
          BlocBuilder<SignInBloc, SignInState>(
            buildWhen: (previous, current) =>
                previous.userResult != current.userResult,
            builder: (context, state) {
              return BlockinButton(
                text: AppLocalizations.of(context)!.sign_in,
                isLoading: state.userResult is Loading,
                onPressed: widget.onSignInPressed,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _signUpCallToAction(BuildContext context) {
    return BlockinRichText(
      children: [
        BlockinTextSpan(
          text: '${AppLocalizations.of(context)!.sign_up_call_to_action} ',
          variant: BlockinTextVariant.bodySmall,
        ),
        BlockinTextSpan(
          text: AppLocalizations.of(context)!.sign_up,
          variant: BlockinTextVariant.link,
          recognizer: TapGestureRecognizer()..onTap = widget.onSignUpPressed,
        ),
      ],
    );
  }
}
