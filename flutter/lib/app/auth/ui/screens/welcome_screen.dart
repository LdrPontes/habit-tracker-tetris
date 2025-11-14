import 'package:blockin/app/auth/ui/screens/sign_in_screen.dart';
import 'package:blockin/app/shared/ui/components/atoms/typography.dart';
import 'package:blockin/app/shared/ui/components/molecules/button.dart';
import 'package:blockin/constants/images.dart';
import 'package:blockin/core/localization/localizations.dart';
import 'package:blockin/core/navigation/routes.dart';
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
              (MediaQuery.of(context).size.height * 0.1).h,
              BlockinText.headingMedium(
                AppLocalizations.of(context)!.welcome_description,
                textAlign: TextAlign.center,
              ),
              Image.asset(ImagesAssets.welcome),
              Expanded(child: Container()),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Spacing.xxxxLarge,
                ),
                child: BlockinButton(
                  text: AppLocalizations.of(context)!.start_button,
                  onPressed: () => router.push(SignInScreen.routeName),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
