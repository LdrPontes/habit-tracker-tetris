import 'package:blockin/app/shared/ui/components/atoms/typography.dart';
import 'package:blockin/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class BlockinAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final Widget? leading;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? elevation;
  final ShapeBorder? shape;
  final int? totalSteps;
  final int? currentStep;

  const BlockinAppBar({
    super.key,
    this.title,
    this.actions,
    this.leading,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation,
    this.shape,
    this.totalSteps,
    this.currentStep,
  });

  @override
  Widget build(BuildContext context) {
    final hasSteps =
        totalSteps != null && currentStep != null && totalSteps! > 0;
    final stepHeight = hasSteps ? 4.0 : 0.0;

    return AppBar(
      title: title != null
          ? BlockinText.headingSmall(title!, textAlign: TextAlign.center)
          : null,
      actions: actions,
      leading: Navigator.canPop(context)
          ? IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(PhosphorIconsBold.caretLeft),
              color: Theme.of(context).colors.foreground.shade900,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              padding: EdgeInsets.zero,
              iconSize: 20,
            )
          : leading,
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      shape: shape,
      bottom: hasSteps
          ? PreferredSize(
              preferredSize: Size.fromHeight(stepHeight),
              child: _StepProgressBar(
                totalSteps: totalSteps!,
                currentStep: currentStep!,
              ),
            )
          : null,
    );
  }

  @override
  Size get preferredSize {
    final hasSteps =
        totalSteps != null && currentStep != null && totalSteps! > 0;
    final stepHeight = hasSteps ? 4.0 : 0.0;
    return Size.fromHeight(kToolbarHeight + stepHeight);
  }
}

class _StepProgressBar extends StatefulWidget {
  final int totalSteps;
  final int currentStep;

  const _StepProgressBar({required this.totalSteps, required this.currentStep});

  @override
  State<_StepProgressBar> createState() => _StepProgressBarState();
}

class _StepProgressBarState extends State<_StepProgressBar> {
  late double _previousProgress;

  @override
  void initState() {
    super.initState();
    _previousProgress = (widget.currentStep / widget.totalSteps).clamp(
      0.0,
      1.0,
    );
  }

  @override
  void didUpdateWidget(_StepProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentStep != widget.currentStep) {
      _previousProgress = (oldWidget.currentStep / oldWidget.totalSteps).clamp(
        0.0,
        1.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colors;
    final targetProgress = (widget.currentStep / widget.totalSteps).clamp(
      0.0,
      1.0,
    );

    return Container(
      height: 4.0,
      margin: EdgeInsets.zero,
      child: Stack(
        children: [
          // Background track
          Container(width: double.infinity, color: colors.content3),
          // Animated progress indicator
          TweenAnimationBuilder<double>(
            key: ValueKey(widget.currentStep),
            tween: Tween<double>(begin: _previousProgress, end: targetProgress),
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            onEnd: () {
              if (mounted) {
                setState(() {
                  _previousProgress = targetProgress;
                });
              }
            },
            builder: (context, progress, child) {
              return FractionallySizedBox(
                widthFactor: progress,
                child: Container(color: colors.foreground.shade900),
              );
            },
          ),
        ],
      ),
    );
  }
}
