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
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

/// A comprehensive Flutter button component that replicates the Blockin button system.
///
/// The [BlockinButton] leverages Material 3's foundation components:
/// - **solid/shadow** → [FilledButton]
/// - **flat** → [FilledButton.tonal]
/// - **bordered/faded/ghost** → [OutlinedButton]
/// - **light** → [TextButton]
///
/// Example:
/// ```dart
/// BlockinButton(
///   text: 'Click me',
///   variant: BlockinButtonVariant.solid,
///   color: BlockinButtonColor.primary,
///   onPressed: () => print('Pressed'),
/// )
/// ```
class BlockinButton extends StatelessWidget {
  const BlockinButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.variant,
    this.color,
    this.size,
    this.radius,
    this.fullWidth = false,
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
    this.gradient,
    this.customBackgroundColor,
    this.customForegroundColor,
    this.customBorderColor,
  });

  final VoidCallback? onPressed;

  /// The text label for the button
  final String text;

  final BlockinButtonVariant? variant;
  final BlockinButtonColor? color;
  final BlockinButtonSizeType? size;
  final BlockinRadiusType? radius;
  final bool fullWidth;
  final bool isDisabled;
  final bool isInGroup;
  final bool isVerticalGroup;

  /// Whether this is an icon-only button (text will be hidden, only icon shown)
  final bool isIconOnly;

  /// Whether the button should display a loading spinner
  final bool isLoading;

  /// Optional custom spinner widget to render during loading
  final Widget? spinner;

  /// Spinner placement relative to the content
  /// If null, uses the theme default
  final BlockinButtonSpinnerPlacement? spinnerPlacement;

  /// Spinner visual style (uses BlockinSpinner variants)
  /// If null, uses the theme default
  final BlockinSpinnerVariant? spinnerVariant;

  /// Whether to disable ripple/splash effect for this button
  final bool? disableRipple;

  final bool? disableAnimation;

  /// Optional icon widget to display before the text
  final Widget? startIcon;

  /// Optional icon widget to display after the text
  final Widget? endIcon;

  final String? tooltip;
  final FocusNode? focusNode;
  final bool autoFocus;
  final BlockinButtonGroupPosition? groupPosition;
  final String? semanticLabel;

  /// Optional gradient for button background
  /// When provided, overrides the solid background color
  final Gradient? gradient;

  /// Custom background color (overrides theme color)
  final Color? customBackgroundColor;

  /// Custom foreground/text color (overrides theme color)
  final Color? customForegroundColor;

  /// Custom border color (overrides theme color, only for bordered variants)
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

    Widget button = _buildMaterialButton(
      effectiveVariant,
      isInteractive ? _handlePress : null,
      buttonChild,
      _buildButtonStyle(
        context,
        effectiveVariant,
        colorScheme,
        sizeConfig,
        effectiveRadius,
        buttonTheme,
        hasGradient: gradient != null,
      ),
    );

    // For ghost with gradient: wrap to show gradient label in default, solid on hover/press
    if (gradient != null && effectiveVariant == BlockinButtonVariant.ghost) {
      button = _GhostGradientLabel(
        gradient: gradient!,
        hoverColor: colorScheme.ghostHover,
        isEnabled: isInteractive,
        child: button,
      );
    }

    // Apply gradient background for solid/shadow/flat always
    if (gradient != null && _isFilledVariant(effectiveVariant)) {
      final bgGradient = effectiveVariant == BlockinButtonVariant.flat
          ? _GradientUtils.applyOpacity(
              gradient!,
              (effectiveColor == BlockinButtonColor.defaultColor)
                  ? BlockinButtonOpacity.flatBackgroundStrong
                  : BlockinButtonOpacity.flatBackground,
            )
          : gradient!;
      button = _GradientButton(
        gradient: bgGradient,
        borderRadius: _getBorderRadius(effectiveRadius),
        isDisabled: isDisabled,
        child: button,
      );
    }

    // Apply gradient outline for bordered and ghost defaults
    if (gradient != null && _isOutlineVariant(effectiveVariant)) {
      button = _GradientOutline(
        gradient: gradient!,
        borderRadius: _getBorderRadius(effectiveRadius),
        borderWidth: BlockinButtonSpacing.borderWidth,
        child: button,
      );
    }

    // Apply stateful gradient background for ghost/light on hover/press only
    if (gradient != null &&
        (effectiveVariant == BlockinButtonVariant.ghost ||
            effectiveVariant == BlockinButtonVariant.light)) {
      button = _StateGradientBackground(
        gradient: gradient!,
        borderRadius: _getBorderRadius(effectiveRadius),
        isEnabled: isInteractive,
        // For light, apply same hover opacity as default light
        activeOpacity: effectiveVariant == BlockinButtonVariant.light
            ? BlockinButtonOpacity.lightHover
            : null,
        child: button,
      );
    }

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

  void _handlePress() {
    if (onPressed != null) {
      HapticFeedback.lightImpact();
      onPressed!();
    }
  }

  Widget _buildMaterialButton(
    BlockinButtonVariant variant,
    VoidCallback? onPressed,
    Widget child,
    ButtonStyle style,
  ) {
    // Determine which Material button to use
    final buttonBuilder = _getButtonBuilder(variant);

    // Handle icon-only buttons
    if (isIconOnly) {
      return buttonBuilder.build(
        onPressed: onPressed,
        style: style,
        focusNode: focusNode,
        autofocus: autoFocus,
        child: child,
      );
    }

    // Handle icon buttons with start icon only
    if (startIcon != null && endIcon == null && buttonBuilder.supportsIcon) {
      return buttonBuilder.buildIcon(
        onPressed: onPressed,
        style: style,
        focusNode: focusNode,
        autofocus: autoFocus,
        icon: startIcon!,
        label: child,
      );
    }

    // Standard button with optional icons
    return buttonBuilder.build(
      onPressed: onPressed,
      style: style,
      focusNode: focusNode,
      autofocus: autoFocus,
      child: _buildButtonChildWithIcons(child),
    );
  }

  static final _buttonBuilders = <BlockinButtonVariant, _ButtonBuilder>{
    BlockinButtonVariant.solid: _ButtonBuilder(
      FilledButton.new,
      FilledButton.icon,
    ),
    BlockinButtonVariant.shadow: _ButtonBuilder(
      FilledButton.new,
      FilledButton.icon,
    ),
    BlockinButtonVariant.flat: _ButtonBuilder(
      FilledButton.tonal,
      FilledButton.tonalIcon,
    ),
    BlockinButtonVariant.bordered: _ButtonBuilder(
      OutlinedButton.new,
      OutlinedButton.icon,
    ),
    BlockinButtonVariant.faded: _ButtonBuilder(
      OutlinedButton.new,
      OutlinedButton.icon,
    ),
    BlockinButtonVariant.ghost: _ButtonBuilder(
      OutlinedButton.new,
      OutlinedButton.icon,
    ),
    BlockinButtonVariant.light: _ButtonBuilder(TextButton.new, TextButton.icon),
  };

  _ButtonBuilder _getButtonBuilder(BlockinButtonVariant variant) =>
      _buttonBuilders[variant]!;

  // Helper methods to check variant groups
  static bool _isFilledVariant(BlockinButtonVariant v) =>
      v == BlockinButtonVariant.solid ||
      v == BlockinButtonVariant.shadow ||
      v == BlockinButtonVariant.flat;

  static bool _isOutlineVariant(BlockinButtonVariant v) =>
      v == BlockinButtonVariant.bordered || v == BlockinButtonVariant.ghost;

  Widget _buildButtonChild(BuildContext context, ButtonSizeConfig sizeConfig) {
    // Icon-only buttons: when loading, show only spinner
    if (isIconOnly) {
      if (isLoading) return _buildSpinner(context);
      return startIcon ?? endIcon ?? const SizedBox.shrink();
    }

    final textWidget = _buildLabelWithOptionalGradient(context);
    if (!isLoading) return _buildButtonChildWithIcons(textWidget);

    // Loading: place spinner according to placement
    final buttonTheme = BlockinButtonThemeExtension.of(context);
    final gap = _getSizeConfig(size ?? BlockinButtonSizeType.medium).gap;
    final spinner = _buildSpinner(context);
    final content = _buildButtonChildWithIcons(textWidget);
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

  /// Builds the label text, applying gradient foreground for specific variants
  Widget _buildLabelWithOptionalGradient(BuildContext context) {
    final buttonTheme = BlockinButtonThemeExtension.of(context);
    final effVariant = variant ?? buttonTheme.defaultVariant;
    final shouldGradientLabel =
        gradient != null &&
        (effVariant == BlockinButtonVariant.bordered ||
            effVariant == BlockinButtonVariant.ghost ||
            effVariant == BlockinButtonVariant.faded ||
            effVariant == BlockinButtonVariant.light ||
            effVariant == BlockinButtonVariant.flat);

    final label = Text(text);

    if (!shouldGradientLabel) return label;

    // For ghost: label color switches on hover/press (handled by foregroundState)
    // So we return plain text and let Material handle it
    if (effVariant == BlockinButtonVariant.ghost) {
      return label;
    }

    return ShaderMask(
      shaderCallback: (bounds) => gradient!.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      blendMode: BlendMode.srcIn,
      child: label,
    );
  }

  Widget _buildButtonChildWithIcons(Widget child) {
    if (startIcon == null && endIcon == null) return child;
    final gap = _getSizeConfig(size ?? BlockinButtonSizeType.medium).gap;
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
    BlockinRadiusType radiusType,
    BlockinButtonThemeExtension buttonTheme, {
    bool hasGradient = false,
  }) {
    final borderRadius = _getBorderRadius(radiusType);

    // Get typography to inherit font family from theme
    final typography = Theme.of(context).blockinTypographyOrNull;
    final baseLabelStyle = typography?.labelMedium;

    final outlineWithGradient = hasGradient && _isOutlineVariant(variant);

    return ButtonStyle(
      textStyle: WidgetStateProperty.all(
        TextStyle(
          fontSize: sizeConfig.fontSize,
          fontWeight: FontWeight.w500,
          fontFamily: baseLabelStyle?.fontFamily,
        ),
      ),
      padding: WidgetStateProperty.all(_getButtonPadding(sizeConfig)),
      minimumSize: WidgetStateProperty.all(_getMinimumSize(sizeConfig)),
      maximumSize: WidgetStateProperty.all(_getMaximumSize(sizeConfig)),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: borderRadius),
      ),
      elevation: _getElevation(variant),
      shadowColor: variant == BlockinButtonVariant.shadow
          ? WidgetStateProperty.all(
              colorScheme.background.withAlpha((0.4 * 255).round()),
            )
          : null,
      animationDuration: buttonTheme.disableAnimations
          ? Duration.zero
          : buttonTheme.animationDuration,
      // Make background transparent when gradient is used
      backgroundColor: hasGradient
          ? WidgetStateProperty.all(Colors.transparent)
          : colorScheme.backgroundState,
      foregroundColor: colorScheme.foregroundState,
      side: outlineWithGradient
          ? WidgetStateProperty.all(
              BorderSide(
                color: Colors.transparent,
                width: BlockinButtonSpacing.borderWidth,
              ),
            )
          : colorScheme.borderState,
      overlayColor:
          (outlineWithGradient && variant == BlockinButtonVariant.bordered) ||
              (hasGradient && variant == BlockinButtonVariant.faded)
          ? WidgetStateProperty.all(
              _selectGradientBaseColor().withAlpha(
                (BlockinButtonOpacity.overlay * 255).round(),
              ),
            )
          : colorScheme.overlayState,
      splashFactory: (disableRipple ?? buttonTheme.disableRipple)
          ? NoSplash.splashFactory
          : InkRipple.splashFactory,
    );
  }

  EdgeInsetsGeometry _getButtonPadding(ButtonSizeConfig sizeConfig) =>
      isIconOnly
      ? EdgeInsets.zero
      : EdgeInsets.symmetric(
          horizontal: sizeConfig.paddingHorizontal,
          vertical: (sizeConfig.height - sizeConfig.fontSize) / 4,
        );

  Size _getMinimumSize(ButtonSizeConfig sizeConfig) => isIconOnly
      ? Size(sizeConfig.iconOnlySize, sizeConfig.iconOnlySize)
      : Size(sizeConfig.minWidth, sizeConfig.height);

  Size? _getMaximumSize(ButtonSizeConfig sizeConfig) => isIconOnly
      ? Size(sizeConfig.iconOnlySize, sizeConfig.iconOnlySize)
      : null;

  WidgetStateProperty<double>? _getElevation(BlockinButtonVariant variant) {
    if (variant != BlockinButtonVariant.shadow) {
      return WidgetStateProperty.all(0);
    }
    return WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) return 0;
      if (states.contains(WidgetState.pressed)) return 2;
      if (states.contains(WidgetState.hovered)) return 8;
      return 4;
    });
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

  // Spinner helpers
  Widget _buildSpinner(BuildContext context) {
    if (spinner != null) {
      return SizedBox.square(dimension: _mapSpinnerPixelSize(), child: spinner);
    }

    // Derive the same foreground color used by the button for consistency
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
      // Match button text color
      customColor: scheme.foreground,
    );
  }

  double _mapSpinnerPixelSize() =>
      (size ?? BlockinButtonSizeType.medium) == BlockinButtonSizeType.large
      ? 32.0
      : 20.0;

  // Picks a representative color from the provided gradient for effects like ripple
  Color _selectGradientBaseColor() =>
      gradient != null && _gradientHasColors(gradient!)
      ? _getGradientColors(gradient!).first
      : Colors.white;

  static bool _gradientHasColors(Gradient g) =>
      _getGradientColors(g).isNotEmpty;

  static List<Color> _getGradientColors(Gradient g) => switch (g) {
    LinearGradient() => g.colors,
    RadialGradient() => g.colors,
    SweepGradient() => g.colors,
    _ => [],
  };
}

/// Position of button in a button group
enum BlockinButtonGroupPosition { single, first, middle, last }

/// Internal button builder using functional approach
class _ButtonBuilder {
  const _ButtonBuilder(this.builder, this.iconBuilder);

  final Widget Function({
    required VoidCallback? onPressed,
    required ButtonStyle style,
    required FocusNode? focusNode,
    required bool autofocus,
    required Widget child,
  })
  builder;

  final Widget Function({
    required VoidCallback? onPressed,
    required ButtonStyle style,
    required FocusNode? focusNode,
    required bool autofocus,
    required Widget icon,
    required Widget label,
  })?
  iconBuilder;

  bool get supportsIcon => iconBuilder != null;

  Widget build({
    required VoidCallback? onPressed,
    required ButtonStyle style,
    required FocusNode? focusNode,
    required bool autofocus,
    required Widget child,
  }) => builder(
    onPressed: onPressed,
    style: style,
    focusNode: focusNode,
    autofocus: autofocus,
    child: child,
  );

  Widget buildIcon({
    required VoidCallback? onPressed,
    required ButtonStyle style,
    required FocusNode? focusNode,
    required bool autofocus,
    required Widget icon,
    required Widget label,
  }) => iconBuilder!(
    onPressed: onPressed,
    style: style,
    focusNode: focusNode,
    autofocus: autofocus,
    icon: icon,
    label: label,
  );
}

/// Internal color scheme for buttons - data-driven approach
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

  /// Create color scheme from Blockin color system
  factory _ButtonColorScheme.fromColorSystem({
    required BlockinButtonVariant variant,
    required BlockinButtonColor color,
    required IAppColors colors,
    Color? customBackgroundColor,
    Color? customForegroundColor,
    Color? customBorderColor,
  }) {
    // Get base colors for the color type
    final baseColors = _getBaseColors(color, colors);

    // Apply variant-specific modifications
    final scheme = _applyVariant(variant, baseColors, colors);

    // Apply custom color overrides if provided
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
    // Helper to create scheme with common hover colors
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

  /// Get background color states for Material button
  WidgetStateProperty<Color> get backgroundState {
    return WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return background.withAlpha(
          (BlockinButtonOpacity.disabled * 255).round(),
        );
      }
      if (states.contains(WidgetState.hovered)) {
        return _getHoverBackground();
      }
      return background;
    });
  }

  Color _getHoverBackground() => switch (variant) {
    BlockinButtonVariant.solid || BlockinButtonVariant.shadow =>
      background.withAlpha((BlockinButtonOpacity.hover * 255).round()),
    BlockinButtonVariant.flat || BlockinButtonVariant.faded => background,
    BlockinButtonVariant.bordered || BlockinButtonVariant.light => lightHover,
    BlockinButtonVariant.ghost => ghostHover,
  };

  /// Get foreground color states
  WidgetStateProperty<Color> get foregroundState {
    return WidgetStateProperty.resolveWith((states) {
      // Only ghost variant inverts text color on hover
      if (states.contains(WidgetState.hovered) &&
          variant == BlockinButtonVariant.ghost) {
        final hoverBg = ghostHover;
        final luminance = hoverBg.computeLuminance();
        return luminance > 0.5 ? Colors.black : Colors.white;
      }
      return foreground;
    });
  }

  /// Get border states
  WidgetStateProperty<BorderSide>? get borderState {
    if (border == null) return null;

    return WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return BorderSide(
          color: border!.withAlpha(
            (BlockinButtonOpacity.disabled * 255).round(),
          ),
          width: BlockinButtonSpacing.borderWidth,
        );
      }
      return BorderSide(
        color: border!,
        width: BlockinButtonSpacing.borderWidth,
      );
    });
  }

  /// Get overlay (splash/ripple) color
  WidgetStateProperty<Color> get overlayState {
    return WidgetStateProperty.all(
      foreground.withAlpha((BlockinButtonOpacity.overlay * 255).round()),
    );
  }
}

/// Base colors for a color type (before variant is applied)
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

/// Utility class for gradient transformations
class _GradientUtils {
  static Gradient applyOpacity(Gradient g, double opacity) {
    return _transformGradientColors(g, (c) => c.withOpacity(opacity));
  }

  static Gradient applyAlpha(Gradient g, int alpha) {
    return _transformGradientColors(g, (c) => c.withAlpha(alpha));
  }

  static Gradient _transformGradientColors(
    Gradient g,
    Color Function(Color) transform,
  ) {
    if (g is LinearGradient) {
      return LinearGradient(
        colors: g.colors.map(transform).toList(),
        stops: g.stops,
        begin: g.begin,
        end: g.end,
        tileMode: g.tileMode,
        transform: g.transform,
      );
    } else if (g is RadialGradient) {
      return RadialGradient(
        colors: g.colors.map(transform).toList(),
        stops: g.stops,
        center: g.center,
        radius: g.radius,
        tileMode: g.tileMode,
        focal: g.focal,
        focalRadius: g.focalRadius,
        transform: g.transform,
      );
    } else if (g is SweepGradient) {
      return SweepGradient(
        colors: g.colors.map(transform).toList(),
        stops: g.stops,
        center: g.center,
        startAngle: g.startAngle,
        endAngle: g.endAngle,
        tileMode: g.tileMode,
        transform: g.transform,
      );
    }
    return g;
  }
}

/// Shared widget for tracking hover and press states
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

  void _setHovered(bool value) {
    if (!widget.isEnabled) return;
    setState(() => _hovered = value);
  }

  void _setPressed(bool value) {
    if (!widget.isEnabled) return;
    setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _setHovered(true),
      onExit: (_) => _setHovered(false),
      child: Listener(
        onPointerDown: (_) => _setPressed(true),
        onPointerUp: (_) => _setPressed(false),
        onPointerCancel: (_) => _setPressed(false),
        child: widget.builder(context, _hovered, _pressed),
      ),
    );
  }
}

/// Press scale animation wrapper - keeps BlockinButton stateless
///
/// This widget handles the press animation state separately, providing
/// better separation of concerns and keeping the main button component clean.
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

/// Gradient button wrapper
///
/// Wraps a Material button and applies a gradient background.
/// Uses an Ink widget with decoration to maintain Material ripple effects.
class _GradientButton extends StatelessWidget {
  const _GradientButton({
    required this.gradient,
    required this.borderRadius,
    required this.isDisabled,
    required this.child,
  });

  final Gradient gradient;
  final BorderRadius borderRadius;
  final bool isDisabled;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: isDisabled
            ? _GradientUtils.applyAlpha(
                gradient,
                (BlockinButtonOpacity.disabled * 255).round(),
              )
            : gradient,
        borderRadius: borderRadius,
      ),
      child: child,
    );
  }
}

/// Gradient outline wrapper for bordered/ghost variants
class _GradientOutline extends StatelessWidget {
  const _GradientOutline({
    required this.gradient,
    required this.borderRadius,
    required this.borderWidth,
    required this.child,
  });

  final Gradient gradient;
  final BorderRadius borderRadius;
  final double borderWidth;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        border: GradientBoxBorder(gradient: gradient, width: borderWidth),
      ),
      child: child,
    );
  }
}

/// Shows a gradient background only while hovered or pressed
class _StateGradientBackground extends StatelessWidget {
  const _StateGradientBackground({
    required this.gradient,
    required this.borderRadius,
    required this.isEnabled,
    required this.child,
    this.activeOpacity,
  });

  final Gradient gradient;
  final BorderRadius borderRadius;
  final bool isEnabled;
  final Widget child;
  final double? activeOpacity;

  @override
  Widget build(BuildContext context) {
    return _InteractionTracker(
      isEnabled: isEnabled,
      builder: (context, hovered, pressed) {
        final active = isEnabled && (hovered || pressed);
        if (!active) return child;

        final decorated = activeOpacity != null
            ? _GradientUtils.applyOpacity(gradient, activeOpacity!)
            : gradient;

        return DecoratedBox(
          decoration: BoxDecoration(
            gradient: decorated,
            borderRadius: borderRadius,
          ),
          child: child,
        );
      },
    );
  }
}

/// Wrapper for ghost buttons with gradient that overlays gradient text in default state
class _GhostGradientLabel extends StatelessWidget {
  const _GhostGradientLabel({
    required this.gradient,
    required this.hoverColor,
    required this.isEnabled,
    required this.child,
  });

  final Gradient gradient;
  final Color hoverColor;
  final bool isEnabled;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return _InteractionTracker(
      isEnabled: isEnabled,
      builder: (context, hovered, pressed) {
        final active = isEnabled && (hovered || pressed);
        // In default state: overlay gradient on text
        // On hover/press: let Material's foregroundColor handle it (inverted color)
        if (active) return child;

        return ShaderMask(
          shaderCallback: (bounds) => gradient.createShader(bounds),
          blendMode: BlendMode.srcATop,
          child: child,
        );
      },
    );
  }
}
