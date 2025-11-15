import 'package:blockin/app/onboarding/ui/components/molecules/notification_card.dart';
import 'package:blockin/app/shared/ui/components/atoms/typography.dart';
import 'package:blockin/app/shared/ui/components/molecules/button.dart';
import 'package:blockin/constants/images.dart';
import 'package:blockin/core/localization/localizations.dart';
import 'package:blockin/theme/constants/spacing.dart';
import 'package:flutter/material.dart';

class OnboardingNotificationTemplate extends StatelessWidget {
  final VoidCallback onContinuePressed;

  const OnboardingNotificationTemplate({
    super.key,
    required this.onContinuePressed,
  });

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
                AppLocalizations.of(context)!.onboarding_notification_title,
                textAlign: TextAlign.center,
              ),
            ),
            Spacing.xxLarge.h,
            _buildCenterContent(context),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Spacing.xxxxLarge,
              ),
              child: BlockinButton(
                text: AppLocalizations.of(context)!.continue_button,
                onPressed: onContinuePressed,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCenterContent(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          Theme.of(context).brightness == Brightness.dark
              ? ImagesAssets.onboardingNotificationsDark
              : ImagesAssets.onboardingNotifications,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Positioned(
          top: Spacing.xxxxLarge,
          right: Spacing.large,
          child: NotificationCard(
            title: AppLocalizations.of(context)!.blockin_daily_habits,
            description: AppLocalizations.of(context)!.only_two_more_goals,
            icon: Image.asset(ImagesAssets.onboardingNotification),
          ),
        ),
        Positioned(
          left: Spacing.large,
          bottom: Spacing.xxxxLarge,
          child: NotificationCard(
            title: AppLocalizations.of(context)!.blockin_daily_habits,
            description:
                AppLocalizations.of(context)!.only_three_more_goals,
            icon: Image.asset(ImagesAssets.onboardingNotification),
          ),
        ),
      ],
    );
  }
}
