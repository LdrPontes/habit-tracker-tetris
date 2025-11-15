import 'package:blockin/app/shared/ui/components/atoms/typography.dart';
import 'package:blockin/app/shared/ui/components/molecules/button.dart';
import 'package:blockin/constants/images.dart';
import 'package:blockin/core/localization/localizations.dart';
import 'package:blockin/theme/constants/spacing.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OnboardingFinishedScreen extends StatelessWidget {
  static const String routeName = '/onboarding-finished';

  const OnboardingFinishedScreen({super.key});

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
                AppLocalizations.of(context)!.onboarding_finished_title,
                textAlign: TextAlign.center,
              ),
            ),
            Spacing.xxLarge.h,
            Image.asset(
              Theme.of(context).brightness == Brightness.dark
                  ? ImagesAssets.onboardingFinishedDark
                  : ImagesAssets.onboardingFinished,
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Spacing.xxxxLarge,
              ),
              child: BlockinButton(
                text: AppLocalizations.of(context)!.continue_button,
                onPressed: () {
                  Supabase.instance.client.auth.signOut();
                  // router.push(OnboardingScreen.routeName);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
