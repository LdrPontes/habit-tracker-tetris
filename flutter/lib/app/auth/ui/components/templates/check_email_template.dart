import 'package:blockin/app/auth/ui/blocs/sign_up/sign_up_bloc.dart';
import 'package:blockin/app/shared/domain/dto/result.dart';
import 'package:blockin/app/shared/ui/components/atoms/typography.dart';
import 'package:blockin/app/shared/ui/components/molecules/blockin_app_bar.dart';
import 'package:blockin/constants/images.dart';
import 'package:blockin/core/localization/localizations.dart';
import 'package:blockin/theme/constants/spacing.dart';
import 'package:blockin/theme/theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckEmailTemplate extends StatelessWidget {
  final String email;
  final VoidCallback onResendEmailPressed;

  const CheckEmailTemplate({
    super.key,
    required this.email,
    required this.onResendEmailPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,

      appBar: BlockinAppBar(),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            _buildContent(context),
            Spacer(),
            _buildResendEmailLink(context),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      children: [
        BlockinText.headingLarge(
          AppLocalizations.of(context)!.check_your_email_title,
        ),

        Image.asset(
          Theme.of(context).brightness == Brightness.dark
              ? ImagesAssets.confirmEmailDark
              : ImagesAssets.confirmEmail,
          width: MediaQuery.of(context).size.width,
        ),
        Spacing.xxLarge.h,
        BlockinText.bodyLarge(
          email,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        Spacing.small.h,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Spacing.xxxxLarge),
          child: BlockinText.bodySmall(
            AppLocalizations.of(context)!.check_your_email_description,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildResendEmailLink(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) =>
          previous.resendEmailResult != current.resendEmailResult ||
          previous.resendEmailCooldownSeconds !=
              current.resendEmailCooldownSeconds,
      builder: (context, state) {
        final isLoading = state.resendEmailResult is Loading;
        final isOnCooldown = state.resendEmailCooldownSeconds > 0;
        final canResend = !isLoading && !isOnCooldown;

        String text;
        if (isOnCooldown) {
          text = AppLocalizations.of(
            context,
          )!.resend_email_cooldown(state.resendEmailCooldownSeconds);
        } else {
          text = AppLocalizations.of(context)!.i_didnt_get_an_email;
        }

        return BlockinRichText(
          children: [
            BlockinTextSpan(
              text: text,
              color: canResend
                  ? Theme.of(context).colors.secondary
                  : Theme.of(context).colors.secondary.withOpacity(0.5),
              variant: BlockinTextVariant.link,
              recognizer: canResend
                  ? (TapGestureRecognizer()..onTap = onResendEmailPressed)
                  : null,
            ),
          ],
        );
      },
    );
  }
}
