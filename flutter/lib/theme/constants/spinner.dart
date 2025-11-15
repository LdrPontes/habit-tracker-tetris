/// Spinner size configurations
enum BlockinSpinnerSizeType { small, medium, large }

/// Spinner color options
enum BlockinSpinnerColor {
  current,
  white,
  defaultColor,
  primary,
  secondary,
  success,
  warning,
  danger,
}

/// Spinner variant options
enum BlockinSpinnerVariant {
  defaultVariant,
  gradient,
  wave,
  dots,
  spinner,
  simple,
}

/// Spinner label color options
enum BlockinSpinnerLabelColor {
  foreground,
  primary,
  secondary,
  success,
  warning,
  danger,
}

/// Size configuration for spinner
class SpinnerSizeConfig {
  final double size;
  final double borderWidth;
  final double dotSize;
  final double fontSize;

  const SpinnerSizeConfig({
    required this.size,
    required this.borderWidth,
    required this.dotSize,
    required this.fontSize,
  });
}

/// Predefined size configurations
class BlockinSpinnerSize {
  static const small = SpinnerSizeConfig(
    size: 20.0, // w-5 h-5
    borderWidth: 2.0, // border-2
    dotSize: 4.0, // size-1
    fontSize: 14.0, // text-small
  );

  static const medium = SpinnerSizeConfig(
    size: 32.0, // w-8 h-8
    borderWidth: 3.0, // border-3
    dotSize: 6.0, // size-1.5
    fontSize: 16.0, // text-medium
  );

  static const large = SpinnerSizeConfig(
    size: 40.0, // w-10 h-10
    borderWidth: 3.0, // border-3
    dotSize: 8.0, // size-2
    fontSize: 18.0, // text-large
  );

  // Special sizes for wave and dots variants
  static const waveMedium = SpinnerSizeConfig(
    size: 32.0,
    borderWidth: 3.0,
    dotSize: 6.0,
    fontSize: 16.0,
  );

  static const waveLarge = SpinnerSizeConfig(
    size: 48.0, // w-12 h-12
    borderWidth: 3.0,
    dotSize: 8.0,
    fontSize: 18.0,
  );

  static SpinnerSizeConfig getConfig(
    BlockinSpinnerSizeType size, {
    BlockinSpinnerVariant? variant,
  }) {
    if (variant == BlockinSpinnerVariant.wave ||
        variant == BlockinSpinnerVariant.dots) {
      return switch (size) {
        BlockinSpinnerSizeType.small => small,
        BlockinSpinnerSizeType.medium => waveMedium,
        BlockinSpinnerSizeType.large => waveLarge,
      };
    }

    return switch (size) {
      BlockinSpinnerSizeType.small => small,
      BlockinSpinnerSizeType.medium => medium,
      BlockinSpinnerSizeType.large => large,
    };
  }
}

/// Animation durations
class BlockinSpinnerAnimation {
  // Both spinner animations use the same duration with different curves
  static const Duration easeSpin = Duration(milliseconds: 800); // 0.8s ease
  static const Duration linearSpin = Duration(milliseconds: 800); // 0.8s linear
  static const Duration barFadeOut = Duration(milliseconds: 1200);
  static const Duration dotAnimation = Duration(milliseconds: 250);
  static const Duration dotBlinkAnimation = Duration(milliseconds: 200);
  static const Duration gradientSpin = Duration(
    milliseconds: 800,
  ); // 0.8s for gradient
}
