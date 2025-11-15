import 'package:blockin/app/shared/ui/components/atoms/typography.dart';
import 'package:blockin/theme/constants/radius.dart';
import 'package:blockin/theme/constants/spacing.dart';
import 'package:blockin/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

class NotificationCard extends StatelessWidget {
  final String title;
  final String description;
  final Widget icon;

  const NotificationCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Spacing.medium),
      width: 300,
      decoration: BoxDecoration(
        color: Theme.of(context).colors.content3,
        boxShadow: BlockinShadow.medium
            .map(
              (shadow) => shadow.copyWith(
                color: Theme.of(
                  context,
                ).colors.content3.withValues(alpha: 0.30),
              ),
            )
            .toList(),
        borderRadius: BorderRadius.circular(BlockinRadius.large),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: Spacing.small,
        children: [
          icon,
          Spacing.extraSmall.w,
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: Spacing.extraSmall,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: BlockinText.titleMedium(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          height: 1.0,
                        ),
                      ),
                    ),
                    BlockinText.labelSmall(
                      '3 min',
                      style: TextStyle(
                        color: Theme.of(context).colors.zinc.shade400,
                      ),
                    ),
                  ],
                ),
                BlockinText.bodySmall(description),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

@Preview(name: 'NotificationCard')
Widget notificationCardPreview() {
  return Scaffold(
    backgroundColor: Colors.white,
    body: Theme(
      data: BlockinTheme.lightTheme(),
      child: NotificationCard(
        title: 'Blockin: Daily Habits',
        description:
            'Faltam apenas três peças para você atingir seu próximo objetivo!',
        icon: Icon(Icons.notifications),
      ),
    ),
  );
}
