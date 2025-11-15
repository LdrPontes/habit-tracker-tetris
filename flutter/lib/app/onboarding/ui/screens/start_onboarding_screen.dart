import 'package:blockin/app/onboarding/ui/screens/onboarding_screen.dart';
import 'package:blockin/app/shared/ui/components/atoms/typography.dart';
import 'package:blockin/app/shared/ui/components/molecules/button.dart';
import 'package:blockin/constants/images.dart';
import 'package:blockin/core/localization/localizations.dart';
import 'package:blockin/core/navigation/routes.dart';
import 'package:blockin/theme/constants/spacing.dart';
import 'package:flutter/material.dart';

class StartOnboardingScreen extends StatelessWidget {
  static const String routeName = '/start-onboarding';

  const StartOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Spacing.xxxxLarge,
              ),
              child: BlockinText.headingLarge(
                AppLocalizations.of(context)!.start_onboarding_title,
                textAlign: TextAlign.center,
              ),
            ),
            Spacing.xxLarge.h,
            BlockinText.bodyMedium(
              AppLocalizations.of(context)!.start_onboarding_description,
              textAlign: TextAlign.center,
            ),
            Image.asset(
              Theme.of(context).brightness == Brightness.dark
                  ? ImagesAssets.startOnboardingDark
                  : ImagesAssets.startOnboarding,
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Spacing.xxxxLarge,
              ),
              child: BlockinButton(
                text: AppLocalizations.of(context)!.start_onboarding,
                onPressed: () {
                  router.push(OnboardingScreen.routeName);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
