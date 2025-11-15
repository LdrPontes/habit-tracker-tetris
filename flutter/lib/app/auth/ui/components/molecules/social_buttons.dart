import 'dart:io';

import 'package:blockin/app/shared/ui/components/molecules/button.dart';
import 'package:blockin/constants/images.dart';
import 'package:blockin/core/localization/localizations.dart';
import 'package:blockin/theme/constants/button.dart';
import 'package:blockin/theme/constants/spacing.dart';
import 'package:blockin/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SocialButtons extends StatelessWidget {
  final VoidCallback onGooglePressed;
  final VoidCallback onApplePressed;

  const SocialButtons({
    super.key,
    required this.onGooglePressed,
    required this.onApplePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlockinButton(
          text: AppLocalizations.of(context)!.continue_with_google,
          variant: BlockinButtonVariant.bordered,
          customBorderColor: Theme.of(context).colors.foreground.shade900,
          customForegroundColor: Theme.of(context).colors.foreground.shade900,
          onPressed: onGooglePressed,
          startIcon: SvgPicture.asset(
            ImagesAssets.googleLogo,
            width: 20,
            height: 20,
          ),
        ),
        if (Platform.isIOS) ...[
          Spacing.xxLarge.h,
          BlockinButton(
            text: AppLocalizations.of(context)!.continue_with_apple,
            variant: BlockinButtonVariant.bordered,
            customBorderColor: Theme.of(context).colors.foreground.shade900,
            customForegroundColor: Theme.of(context).colors.foreground.shade900,
            onPressed: onApplePressed,
            startIcon: Theme.of(context).brightness == Brightness.light
                ? SvgPicture.asset(
                    ImagesAssets.appleLogoBlack,
                    width: 20,
                    height: 20,
                  )
                : SvgPicture.asset(
                    ImagesAssets.appleLogoWhite,
                    width: 20,
                    height: 20,
                  ),
          ),
        ],
      ],
    );
  }
}
