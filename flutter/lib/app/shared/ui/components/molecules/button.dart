import 'package:blockin/theme/button_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:blockin/theme/constants/button.dart';
import 'package:blockin/theme/constants/radius.dart';
import 'package:blockin/theme/constants/spacing.dart';
import 'package:blockin/theme/theme.dart';
import 'package:blockin/theme/typography.dart';
import 'package:blockin/theme/colors/app_colors.dart';
import 'package:blockin/app/shared/ui/components/atoms/spinner.dart';
import 'package:blockin/theme/constants/spinner.dart';

/// A comprehensive Flutter button component that replicates the Blockin button system.
class BlockinButton extends StatelessWidget {
  const BlockinButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.variant,
    this.color,
    this.size,
    this.radius,
    this.fullWidth = true,
    this.isDisabled = false,
    this.isInGroup = false,
    this.isVerticalGroup = false,
    this.isIconOnly = false,
    this.isLoading = false,
    this.spinner,
    this.spinnerPlacement,
    this.spinnerVariant,
    this.disableRipple,
    this.disableAnimation,
    this.startIcon,
    this.endIcon,
    this.tooltip,
    this.focusNode,
    this.autoFocus = false,
    this.groupPosition,
    this.semanticLabel,
    this.customBackgroundColor,
    this.customForegroundColor,
    this.customBorderColor,
  });

  final VoidCallback? onPressed;
  final String text;
  final BlockinButtonVariant? variant;
  final BlockinButtonColor? color;
  final BlockinButtonSizeType? size;
  final BlockinRadiusType? radius;
  final bool fullWidth;
  final bool isDisabled;
  final bool isInGroup;
  final bool isVerticalGroup;
  final bool isIconOnly;
  final bool isLoading;
  final Widget? spinner;
  final BlockinButtonSpinnerPlacement? spinnerPlacement;
  final BlockinSpinnerVariant? spinnerVariant;
  final bool? disableRipple;
  final bool? disableAnimation;
  final Widget? startIcon;
  final Widget? endIcon;
  final String? tooltip;
  final FocusNode? focusNode;
  final bool autoFocus;
  final BlockinButtonGroupPosition? groupPosition;
  final String? semanticLabel;
  final Color? customBackgroundColor;
  final Color? customForegroundColor;
  final Color? customBorderColor;

  @override
  Widget build(BuildContext context) {
    final buttonTheme = BlockinButtonThemeExtension.of(context);
    final colors = Theme.of(context).colors;
    final effectiveVariant = variant ?? buttonTheme.defaultVariant;
    final effectiveColor = color ?? buttonTheme.defaultColor;
    final effectiveSize = size ?? buttonTheme.defaultSize;
    final effectiveRadius = radius ?? buttonTheme.defaultRadius;
    final sizeConfig = _getSizeConfig(effectiveSize);
    final colorScheme = _ButtonColorScheme.fromColorSystem(
      variant: effectiveVariant,
      color: effectiveColor,
      colors: colors,
      customBackgroundColor: customBackgroundColor,
      customForegroundColor: customForegroundColor,
      customBorderColor: customBorderColor,
    );
    final isInteractive = onPressed != null && !isDisabled && !isLoading;
    final buttonChild = _buildButtonChild(context, sizeConfig);
    final borderRadius = _getBorderRadius(effectiveRadius);

    Widget button = _buildMaterialButton(
      context,
      effectiveVariant,
      isInteractive
          ? () {
              HapticFeedback.lightImpact();
              onPressed!();
            }
          : null,
      buttonChild,
      _buildButtonStyle(
        context,
        effectiveVariant,
        colorScheme,
        sizeConfig,
        borderRadius,
        buttonTheme,
      ),
    );

    if (disableAnimation != true &&
        !buttonTheme.disableAnimations &&
        buttonTheme.scaleOnPress &&
        isInteractive) {
      button = _PressScaleAnimation(
        scale: buttonTheme.pressedScale,
        duration: buttonTheme.animationDuration,
        curve: BlockinButtonAnimation.pressCurve,
        child: button,
      );
    }

    if (fullWidth) button = SizedBox(width: double.infinity, child: button);
    if (tooltip != null) button = Tooltip(message: tooltip!, child: button);

    return Semantics(
      label: semanticLabel,
      button: true,
      enabled: isInteractive,
      child: button,
    );
  }

  Widget _buildMaterialButton(
    BuildContext context,
    BlockinButtonVariant variant,
    VoidCallback? onPressed,
    Widget child,
    ButtonStyle style,
  ) {
    if (isIconOnly) {
      return _buildButton(variant, onPressed, style, child);
    }

    if (startIcon != null &&
        endIcon == null &&
        !isLoading &&
        _supportsIcon(variant)) {
      final textWidget = _buildLabel(context);
      return _buildIconButton(
        variant,
        onPressed,
        style,
        startIcon!,
        textWidget,
      );
    }

    return _buildButton(variant, onPressed, style, child);
  }

  Widget _buildButton(
    BlockinButtonVariant variant,
    VoidCallback? onPressed,
    ButtonStyle style,
    Widget child,
  ) {
    return switch (variant) {
      BlockinButtonVariant.solid || BlockinButtonVariant.shadow => FilledButton(
        onPressed: onPressed,
        style: style,
        focusNode: focusNode,
        autofocus: autoFocus,
        child: child,
      ),
      BlockinButtonVariant.flat => FilledButton.tonal(
        onPressed: onPressed,
        style: style,
        focusNode: focusNode,
        autofocus: autoFocus,
        child: child,
      ),
      BlockinButtonVariant.bordered ||
      BlockinButtonVariant.faded ||
      BlockinButtonVariant.ghost => OutlinedButton(
        onPressed: onPressed,
        style: style,
        focusNode: focusNode,
        autofocus: autoFocus,
        child: child,
      ),
      BlockinButtonVariant.light => TextButton(
        onPressed: onPressed,
        style: style,
        focusNode: focusNode,
        autofocus: autoFocus,
        child: child,
      ),
    };
  }

  Widget _buildIconButton(
    BlockinButtonVariant variant,
    VoidCallback? onPressed,
    ButtonStyle style,
    Widget icon,
    Widget label,
  ) {
    return switch (variant) {
      BlockinButtonVariant.solid ||
      BlockinButtonVariant.shadow => FilledButton.icon(
        onPressed: onPressed,
        style: style,
        focusNode: focusNode,
        autofocus: autoFocus,
        icon: icon,
        label: label,
      ),
      BlockinButtonVariant.flat => FilledButton.tonalIcon(
        onPressed: onPressed,
        style: style,
        focusNode: focusNode,
        autofocus: autoFocus,
        icon: icon,
        label: label,
      ),
      BlockinButtonVariant.bordered ||
      BlockinButtonVariant.faded ||
      BlockinButtonVariant.ghost => OutlinedButton.icon(
        onPressed: onPressed,
        style: style,
        focusNode: focusNode,
        autofocus: autoFocus,
        icon: icon,
        label: label,
      ),
      BlockinButtonVariant.light => TextButton.icon(
        onPressed: onPressed,
        style: style,
        focusNode: focusNode,
        autofocus: autoFocus,
        icon: icon,
        label: label,
      ),
    };
  }

  bool _supportsIcon(BlockinButtonVariant variant) => true;

  Widget _buildButtonChild(BuildContext context, ButtonSizeConfig sizeConfig) {
    if (isIconOnly) {
      return isLoading
          ? _buildSpinner(context)
          : startIcon ?? endIcon ?? const SizedBox.shrink();
    }

    final textWidget = _buildLabel(context);
    if (!isLoading) return _buildButtonChildWithIcons(textWidget, sizeConfig);

    final buttonTheme = BlockinButtonThemeExtension.of(context);
    final gap = _getSizeConfig(size ?? BlockinButtonSizeType.medium).gap;
    final spinner = _buildSpinner(context);
    final content = _buildButtonChildWithIcons(textWidget, sizeConfig);
    final effectivePlacement =
        spinnerPlacement ?? buttonTheme.defaultSpinnerPlacement;
    final children = effectivePlacement == BlockinButtonSpinnerPlacement.start
        ? [spinner, SizedBox(width: gap), content]
        : [content, SizedBox(width: gap), spinner];

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }

  Widget _buildLabel(BuildContext context) {
    return Text(text);
  }

  Widget _buildButtonChildWithIcons(Widget child, ButtonSizeConfig sizeConfig) {
    if (startIcon == null && endIcon == null) return child;
    final gap = sizeConfig.gap;
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (startIcon != null) ...[startIcon!, SizedBox(width: gap)],
        Flexible(child: child),
        if (endIcon != null) ...[SizedBox(width: gap), endIcon!],
      ],
    );
  }

  ButtonStyle _buildButtonStyle(
    BuildContext context,
    BlockinButtonVariant variant,
    _ButtonColorScheme colorScheme,
    ButtonSizeConfig sizeConfig,
    BorderRadius borderRadius,
    BlockinButtonThemeExtension buttonTheme,
  ) {
    final typography = Theme.of(context).blockinTypographyOrNull;

    return ButtonStyle(
      textStyle: WidgetStateProperty.all(
        TextStyle(
          fontSize: sizeConfig.fontSize,
          fontWeight: FontWeight.w700,
          fontFamily: typography?.labelMedium.fontFamily,
        ),
      ),
      padding: WidgetStateProperty.all(
        isIconOnly
            ? EdgeInsets.zero
            : EdgeInsets.symmetric(
                horizontal: sizeConfig.paddingHorizontal,
                vertical: (sizeConfig.height - sizeConfig.fontSize) / 4,
              ),
      ),
      minimumSize: WidgetStateProperty.all(
        isIconOnly
            ? Size(sizeConfig.iconOnlySize, sizeConfig.iconOnlySize)
            : Size(sizeConfig.minWidth, sizeConfig.height),
      ),
      maximumSize: isIconOnly
          ? WidgetStateProperty.all(
              Size(sizeConfig.iconOnlySize, sizeConfig.iconOnlySize),
            )
          : null,
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: borderRadius),
      ),
      elevation: variant == BlockinButtonVariant.shadow
          ? WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.disabled)) return 0;
              if (states.contains(WidgetState.pressed)) return 2;
              if (states.contains(WidgetState.hovered)) return 8;
              return 4;
            })
          : WidgetStateProperty.all(0),
      shadowColor: variant == BlockinButtonVariant.shadow
          ? WidgetStateProperty.all(
              colorScheme.background.withAlpha((0.4 * 255).round()),
            )
          : null,
      animationDuration: buttonTheme.disableAnimations
          ? Duration.zero
          : buttonTheme.animationDuration,
      backgroundColor: colorScheme.backgroundState,
      foregroundColor: colorScheme.foregroundState,
      side: colorScheme.borderState,
      overlayColor: colorScheme.overlayState,
      splashFactory: (disableRipple ?? buttonTheme.disableRipple)
          ? NoSplash.splashFactory
          : InkRipple.splashFactory,
    );
  }

  BorderRadius _getBorderRadius(BlockinRadiusType radiusType) {
    if (isInGroup && groupPosition != null) {
      final isSingle = groupPosition == BlockinButtonGroupPosition.single;
      return BlockinButtonRadius.getGroupRadius(
        radiusType,
        isFirst: groupPosition == BlockinButtonGroupPosition.first || isSingle,
        isLast: groupPosition == BlockinButtonGroupPosition.last || isSingle,
        isVertical: isVerticalGroup,
      );
    }
    return BorderRadius.circular(
      BlockinButtonRadius.getRadius(radiusType, isIconOnly: isIconOnly),
    );
  }

  ButtonSizeConfig _getSizeConfig(BlockinButtonSizeType sizeType) =>
      switch (sizeType) {
        BlockinButtonSizeType.small => BlockinButtonSize.small,
        BlockinButtonSizeType.medium => BlockinButtonSize.medium,
        BlockinButtonSizeType.large => BlockinButtonSize.large,
      };

  Widget _buildSpinner(BuildContext context) {
    if (spinner != null) {
      return SizedBox.square(
        dimension:
            (size ?? BlockinButtonSizeType.medium) ==
                BlockinButtonSizeType.large
            ? 32.0
            : 20.0,
        child: spinner,
      );
    }

    final buttonTheme = BlockinButtonThemeExtension.of(context);
    final colors = Theme.of(context).colors;
    final effVariant = variant ?? buttonTheme.defaultVariant;
    final effColor = color ?? buttonTheme.defaultColor;
    final scheme = _ButtonColorScheme.fromColorSystem(
      variant: effVariant,
      color: effColor,
      colors: colors,
      customBackgroundColor: customBackgroundColor,
      customForegroundColor: customForegroundColor,
      customBorderColor: customBorderColor,
    );

    return BlockinSpinner(
      variant: spinnerVariant ?? buttonTheme.defaultSpinnerVariant,
      size: BlockinSpinnerSizeType.small,
      customColor: scheme.foreground,
    );
  }
}

enum BlockinButtonGroupPosition { single, first, middle, last }

class _ButtonColorScheme {
  const _ButtonColorScheme({
    required this.background,
    required this.foreground,
    this.border,
    required this.lightHover,
    required this.ghostHover,
    required this.variant,
  });

  final Color background;
  final Color foreground;
  final Color? border;
  final Color lightHover;
  final Color ghostHover;
  final BlockinButtonVariant variant;

  factory _ButtonColorScheme.fromColorSystem({
    required BlockinButtonVariant variant,
    required BlockinButtonColor color,
    required IAppColors colors,
    Color? customBackgroundColor,
    Color? customForegroundColor,
    Color? customBorderColor,
  }) {
    final baseColors = _getBaseColors(color, colors);
    final scheme = _applyVariant(variant, baseColors, colors);

    if (customBackgroundColor != null ||
        customForegroundColor != null ||
        customBorderColor != null) {
      return _ButtonColorScheme(
        variant: scheme.variant,
        background: customBackgroundColor ?? scheme.background,
        foreground: customForegroundColor ?? scheme.foreground,
        border: customBorderColor ?? scheme.border,
        lightHover:
            customBackgroundColor?.withAlpha(
              (BlockinButtonOpacity.lightHover * 255).round(),
            ) ??
            scheme.lightHover,
        ghostHover: customBackgroundColor ?? scheme.ghostHover,
      );
    }

    return scheme;
  }

  static _BaseColors _getBaseColors(
    BlockinButtonColor color,
    IAppColors colors,
  ) {
    final (solid, foreground) = switch (color) {
      BlockinButtonColor.defaultColor => (
        colors.defaultColor,
        colors.defaultReadableColor,
      ),
      BlockinButtonColor.primary => (
        colors.primary,
        colors.primaryReadableColor,
      ),
      BlockinButtonColor.secondary => (
        colors.secondary,
        colors.secondaryReadableColor,
      ),
      BlockinButtonColor.success => (
        colors.success,
        colors.successReadableColor,
      ),
      BlockinButtonColor.warning => (
        colors.warning,
        colors.warningReadableColor,
      ),
      BlockinButtonColor.danger => (colors.danger, colors.dangerReadableColor),
    };
    return _BaseColors(solid: solid, solidForeground: foreground, tint: solid);
  }

  static _ButtonColorScheme _applyVariant(
    BlockinButtonVariant variant,
    _BaseColors base,
    IAppColors colors,
  ) {
    _ButtonColorScheme scheme({
      required Color background,
      required Color foreground,
      Color? border,
    }) => _ButtonColorScheme(
      variant: variant,
      background: background,
      foreground: foreground,
      border: border,
      lightHover: base.tint.withAlpha(
        (BlockinButtonOpacity.lightHover * 255).round(),
      ),
      ghostHover: base.solid,
    );

    return switch (variant) {
      BlockinButtonVariant.solid || BlockinButtonVariant.shadow => scheme(
        background: base.solid,
        foreground: base.solidForeground,
      ),
      BlockinButtonVariant.flat => scheme(
        background: base.tint.withAlpha(
          base.solid == colors.defaultColor
              ? (BlockinButtonOpacity.flatBackgroundStrong * 255).round()
              : (BlockinButtonOpacity.flatBackground * 255).round(),
        ),
        foreground: base.tint,
      ),
      BlockinButtonVariant.bordered || BlockinButtonVariant.ghost => scheme(
        background: Colors.transparent,
        foreground: base.tint,
        border: base.tint,
      ),
      BlockinButtonVariant.faded => scheme(
        background: base.tint.withAlpha((0.1 * 255).round()),
        foreground: base.tint,
        border: colors.defaultColor,
      ),
      BlockinButtonVariant.light => scheme(
        background: Colors.transparent,
        foreground: base.tint,
      ),
    };
  }

  WidgetStateProperty<Color> get backgroundState {
    return WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return background.withAlpha(
          (BlockinButtonOpacity.disabled * 255).round(),
        );
      }
      if (states.contains(WidgetState.hovered)) {
        return switch (variant) {
          BlockinButtonVariant.solid || BlockinButtonVariant.shadow =>
            background.withAlpha((BlockinButtonOpacity.hover * 255).round()),
          BlockinButtonVariant.flat || BlockinButtonVariant.faded => background,
          BlockinButtonVariant.bordered ||
          BlockinButtonVariant.light => lightHover,
          BlockinButtonVariant.ghost => ghostHover,
        };
      }
      return background;
    });
  }

  WidgetStateProperty<Color> get foregroundState {
    return WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.hovered) &&
          variant == BlockinButtonVariant.ghost) {
        final luminance = ghostHover.computeLuminance();
        return luminance > 0.5 ? Colors.black : Colors.white;
      }
      return foreground;
    });
  }

  WidgetStateProperty<BorderSide>? get borderState {
    if (border == null) return null;
    return WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return BorderSide(
          color: border!.withAlpha(
            (BlockinButtonOpacity.disabled * 255).round(),
          ),
          width: ButtonSpacing.borderWidth,
        );
      }
      return BorderSide(color: border!, width: ButtonSpacing.borderWidth);
    });
  }

  WidgetStateProperty<Color> get overlayState {
    return WidgetStateProperty.all(
      foreground.withAlpha((BlockinButtonOpacity.overlay * 255).round()),
    );
  }
}

class _BaseColors {
  const _BaseColors({
    required this.solid,
    required this.solidForeground,
    required this.tint,
  });

  final Color solid;
  final Color solidForeground;
  final Color tint;
}

class _InteractionTracker extends StatefulWidget {
  const _InteractionTracker({required this.isEnabled, required this.builder});

  final bool isEnabled;
  final Widget Function(BuildContext, bool hovered, bool pressed) builder;

  @override
  State<_InteractionTracker> createState() => _InteractionTrackerState();
}

class _InteractionTrackerState extends State<_InteractionTracker> {
  bool _hovered = false;
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        if (widget.isEnabled) setState(() => _hovered = true);
      },
      onExit: (_) {
        if (widget.isEnabled) setState(() => _hovered = false);
      },
      child: Listener(
        onPointerDown: (_) {
          if (widget.isEnabled) setState(() => _pressed = true);
        },
        onPointerUp: (_) {
          if (widget.isEnabled) setState(() => _pressed = false);
        },
        onPointerCancel: (_) {
          if (widget.isEnabled) setState(() => _pressed = false);
        },
        child: widget.builder(context, _hovered, _pressed),
      ),
    );
  }
}

class _PressScaleAnimation extends StatefulWidget {
  const _PressScaleAnimation({
    required this.child,
    required this.scale,
    required this.duration,
    required this.curve,
  });

  final Widget child;
  final double scale;
  final Duration duration;
  final Curve curve;

  @override
  State<_PressScaleAnimation> createState() => _PressScaleAnimationState();
}

class _PressScaleAnimationState extends State<_PressScaleAnimation> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) => setState(() => _isPressed = true),
      onPointerUp: (_) => setState(() => _isPressed = false),
      onPointerCancel: (_) => setState(() => _isPressed = false),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: AnimatedScale(
          scale: _isPressed ? widget.scale : 1.0,
          duration: widget.duration,
          curve: widget.curve,
          child: widget.child,
        ),
      ),
    );
  }
}
