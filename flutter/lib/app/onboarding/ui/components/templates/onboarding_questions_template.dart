import 'package:blockin/app/onboarding/ui/components/organisms/selectable_group.dart';
import 'package:blockin/app/shared/ui/components/atoms/typography.dart';
import 'package:blockin/app/shared/ui/components/molecules/button.dart';
import 'package:blockin/constants/images.dart';
import 'package:blockin/core/localization/localizations.dart';
import 'package:blockin/theme/constants/spacing.dart';
import 'package:blockin/theme/theme.dart';
import 'package:flutter/material.dart';

class OnboardingQuestionsTemplate extends StatelessWidget {
  final String title;
  final List<String> options;
  final Function(int) onOptionSelected;
  final bool allowMultipleSelection;
  final Function() onContinuePressed;

  const OnboardingQuestionsTemplate({
    super.key,
    required this.title,
    required this.options,
    required this.onOptionSelected,
    this.allowMultipleSelection = true,
    required this.onContinuePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Stack(
          children: [
            // Scrollable content that goes behind header and footer
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Spacer to account for fixed header
                    Builder(
                      builder: (context) {
                        // Get header height dynamically
                        final headerHeight =
                            MediaQuery.of(context).size.width *
                            (9 / 16); // Assuming 16:9 aspect ratio
                        return SizedBox(height: headerHeight);
                      },
                    ),
                    _content(context),
                    200.h,
                  ],
                ),
              ),
            ),
            // Fixed header at the top
            Positioned(left: 0, right: 0, top: 0, child: _header(context)),

            // Fixed footer at the bottom
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: SafeArea(top: false, child: _footer(context)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    final backgroundColor = Theme.of(context).colors.background;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            backgroundColor.withAlpha(150),
            backgroundColor.withAlpha(200),
            backgroundColor.withAlpha(255),
          ],
        ),
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colors.divider.withAlpha(10),
            width: 1,
          ),
        ),
      ),
      child: Image.asset(
        Theme.of(context).brightness == Brightness.dark
            ? ImagesAssets.onboardingHeaderDark
            : ImagesAssets.onboardingHeader,
        width: double.infinity,
      ),
    );
  }

  Widget _content(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.xxxxLarge),
      child: Column(
        children: [
          Spacing.xxxLarge.h,
          BlockinText.headingLarge(title, textAlign: TextAlign.center),
          Spacing.xxxxLarge.h,
          BlockinSelectableGroup(
            items: options,
            spacing: Spacing.extraLarge,
            allowMultipleSelection: allowMultipleSelection,
            onSelectionChanged: (indices) {
              if (indices.isNotEmpty) {
                onOptionSelected(indices.first);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _footer(BuildContext context) {
    return Container(
      color: Theme.of(context).colors.background,
      padding: const EdgeInsets.symmetric(horizontal: Spacing.xxxxLarge),
      child: BlockinButton(
        text: AppLocalizations.of(context)!.continue_button,
        onPressed: onContinuePressed,
      ),
    );
  }
}
