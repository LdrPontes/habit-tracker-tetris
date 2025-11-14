import 'package:blockin/app/auth/ui/blocs/reset_password/reset_password_bloc.dart';
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
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ResetPasswordTemplate extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController newPasswordController;
  final TextEditingController confirmPasswordController;
  final VoidCallback onResetPasswordPressed;

  const ResetPasswordTemplate({
    super.key,
    required this.formKey,
    required this.newPasswordController,
    required this.confirmPasswordController,
    required this.onResetPasswordPressed,
  });

  @override
  State<ResetPasswordTemplate> createState() => _ResetPasswordTemplateState();
}

class _ResetPasswordTemplateState extends State<ResetPasswordTemplate> {
  bool obscureNewPassword = true;
  bool obscureConfirmPassword = true;

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
      key: widget.formKey,
      child: Column(
        children: [
          BlockinText.headingLarge(
            AppLocalizations.of(context)!.reset_password_title,
          ),
          Spacing.xxLarge.h,
          BlockinInput(
            controller: widget.newPasswordController,
            hint: AppLocalizations.of(context)!.new_password,
            obscureText: obscureNewPassword,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            validator: (value) => Validators.password(context, value),
            onSaved: (value) => widget.newPasswordController.text = value ?? '',
            endContent: IconButton(
              onPressed: () {
                setState(() {
                  obscureNewPassword = !obscureNewPassword;
                });
              },
              icon: Icon(
                obscureNewPassword
                    ? PhosphorIconsBold.eye
                    : PhosphorIconsBold.eyeSlash,
              ),
            ),
          ),
          Spacing.small.h,
          BlockinInput(
            controller: widget.confirmPasswordController,
            hint: AppLocalizations.of(context)!.confirm_password,
            obscureText: obscureConfirmPassword,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppLocalizations.of(
                  context,
                )!.validation_error_password_confirm_required;
              }
              if (value != widget.newPasswordController.text) {
                return AppLocalizations.of(
                  context,
                )!.validation_error_passwords_do_not_match;
              }
              return null;
            },
            onSaved: (value) =>
                widget.confirmPasswordController.text = value ?? '',
            endContent: IconButton(
              onPressed: () {
                setState(() {
                  obscureConfirmPassword = !obscureConfirmPassword;
                });
              },
              icon: Icon(
                obscureConfirmPassword
                    ? PhosphorIconsBold.eye
                    : PhosphorIconsBold.eyeSlash,
              ),
            ),
          ),
          Spacing.xxLarge.h,
          BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
            buildWhen: (previous, current) => previous.result != current.result,
            builder: (context, state) {
              return BlockinButton(
                text: AppLocalizations.of(context)!.reset_password,
                isLoading: state.result is Loading,
                onPressed: widget.onResetPasswordPressed,
              );
            },
          ),
        ],
      ),
    );
  }
}
