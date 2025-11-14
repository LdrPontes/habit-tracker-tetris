import 'package:blockin/app/auth/ui/screens/sign_in_screen.dart';
import 'package:blockin/app/auth/ui/screens/sign_up_screen.dart';
import 'package:blockin/app/shared/ui/components/atoms/typography.dart';
import 'package:blockin/app/shared/ui/components/molecules/button.dart';
import 'package:blockin/constants/images.dart';
import 'package:blockin/core/localization/localizations.dart';
import 'package:blockin/core/navigation/routes.dart';
import 'package:blockin/theme/constants/button.dart';
import 'package:blockin/theme/constants/spacing.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  static const String routeName = '/welcome';
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Spacer(),
              BlockinText.headingLarge(
                AppLocalizations.of(context)!.welcome_description,
                textAlign: TextAlign.center,
              ),
              Image.asset(
                Theme.of(context).brightness == Brightness.dark
                    ? ImagesAssets.welcomeDark
                    : ImagesAssets.welcome,
              ),
              Spacer(),
              _buttons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buttons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.xxxxLarge),
      child: Column(
        children: [
          BlockinButton(
            text: AppLocalizations.of(context)!.create_account,
            onPressed: () => router.push(SignUpScreen.routeName),
          ),
          Spacing.large.h,
          BlockinButton(
            text: AppLocalizations.of(context)!.login,
            variant: BlockinButtonVariant.bordered,
            onPressed: () => router.push(SignInScreen.routeName),
          ),
        ],
      ),
    );
  }
}
