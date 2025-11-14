import 'package:blockin/app/shared/ui/components/atoms/typography.dart';
import 'package:blockin/core/localization/localizations.dart';
import 'package:blockin/theme/constants/spacing.dart';
import 'package:blockin/theme/theme.dart';
import 'package:flutter/material.dart';

class AuthDivider extends StatelessWidget {
  const AuthDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Divider(
            height: Spacing.large,
            color: Theme.of(context).colors.divider,
          ),
        ),
        Spacing.large.w,
        BlockinText.caption(
          AppLocalizations.of(context)!.or,
          color: Theme.of(context).colors.divider,
        ),
        Spacing.large.w,
        Expanded(
          child: Divider(
            height: Spacing.large,
            color: Theme.of(context).colors.divider,
          ),
        ),
      ],
    );
  }
}

