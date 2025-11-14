import 'package:blockin/app/auth/ui/blocs/sign_up/sign_up_bloc.dart';
import 'package:blockin/app/auth/ui/components/molecules/auth_divider.dart';
import 'package:blockin/app/auth/ui/components/molecules/social_buttons.dart';
import 'package:blockin/app/shared/domain/dto/result.dart';
import 'package:blockin/app/shared/ui/components/atoms/typography.dart';
import 'package:blockin/app/shared/ui/components/molecules/blockin_app_bar.dart';
import 'package:blockin/app/shared/ui/components/molecules/button.dart';
import 'package:blockin/app/shared/ui/components/molecules/input.dart';
import 'package:blockin/core/localization/localizations.dart';
import 'package:blockin/theme/constants/spacing.dart';
import 'package:blockin/utils/validators.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SignUpTemplate extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onSignInPressed;
  final VoidCallback onGoogleSignUpPressed;
  final VoidCallback onAppleSignUpPressed;
  final VoidCallback onSignUpPressed;

  const SignUpTemplate({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.onSignInPressed,
    required this.onGoogleSignUpPressed,
    required this.onAppleSignUpPressed,
    required this.onSignUpPressed,
  });

  @override
  State<SignUpTemplate> createState() => _SignUpTemplateState();
}

class _SignUpTemplateState extends State<SignUpTemplate> {
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
                onGooglePressed: widget.onGoogleSignUpPressed,
                onApplePressed: widget.onAppleSignUpPressed,
              ),
              Spacing.xxLarge.h,
              _signInCallToAction(context),
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
          BlockinText.headingMedium(
            AppLocalizations.of(context)!.sign_up_title,
          ),
          Spacing.xxLarge.h,
          BlockinInput(
            controller: widget.nameController,
            hint: AppLocalizations.of(context)!.name,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppLocalizations.of(context)!.validation_error_name_required;
              }
              return null;
            },
            onSaved: (value) => widget.nameController.text = value ?? '',
          ),
          Spacing.small.h,
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
          BlocBuilder<SignUpBloc, SignUpState>(
            buildWhen: (previous, current) =>
                previous.userResult != current.userResult,
            builder: (context, state) {
              return BlockinButton(
                text: AppLocalizations.of(context)!.sign_up_with_email,
                isLoading: state.userResult is Loading,
                onPressed: widget.onSignUpPressed,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _signInCallToAction(BuildContext context) {
    return BlockinRichText(
      children: [
        BlockinTextSpan(
          text: '${AppLocalizations.of(context)!.sign_in_call_to_action} ',
          variant: BlockinTextVariant.bodySmall,
        ),
        BlockinTextSpan(
          text: AppLocalizations.of(context)!.sign_in,
          variant: BlockinTextVariant.link,
          recognizer: TapGestureRecognizer()..onTap = widget.onSignInPressed,
        ),
      ],
    );
  }
}

