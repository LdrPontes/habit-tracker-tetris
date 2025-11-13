/// Constants for Blockin Input component

/// Input visual variants
enum BlockinInputVariant { flat, faded, bordered, underlined }

/// Input semantic colors
enum BlockinInputColor {
  defaultColor,
  primary,
  secondary,
  success,
  warning,
  danger,
}

/// Input sizes
enum BlockinInputSizeType { small, medium, large }

/// Radius scale for inputs
enum BlockinInputRadiusType { none, small, medium, large, full }

/// Label placement options similar to Blockin web
enum BlockinInputLabelPlacement { inside, outside, outsideLeft, outsideTop }

/// Size configuration for input
class InputSizeConfig {
  final double height;
  final double heightWithLabelInside;
  final double fontSize;
  final double labelFontSize; // For inside labels
  final double outsideLabelFontSize; // For outside labels
  final double paddingX;
  final double gap;

  const InputSizeConfig({
    required this.height,
    required this.heightWithLabelInside,
    required this.fontSize,
    required this.labelFontSize,
    required this.outsideLabelFontSize,
    required this.paddingX,
    required this.gap,
  });
}

class BlockinInputSize {
  static const small = InputSizeConfig(
    height: 40.0, // h-10 (increased for outside labels)
    heightWithLabelInside: 48.0, // h-12 when label inside
    fontSize: 14.0, // text-small
    labelFontSize: 14.0, // text-small for inside labels (sm/md)
    outsideLabelFontSize: 12.0, // text-tiny for outside labels
    paddingX: 8.0, // px-2 (default), px-3 when label inside
    gap: 8.0,
  );

  static const medium = InputSizeConfig(
    height: 48.0, // h-12 (increased for outside labels)
    heightWithLabelInside: 56.0, // h-14 when label inside
    fontSize: 14.0, // text-small
    labelFontSize: 14.0, // text-small for inside labels (sm/md)
    outsideLabelFontSize: 14.0, // text-small for outside labels
    paddingX: 12.0, // px-3
    gap: 12.0,
  );

  static const large = InputSizeConfig(
    height: 56.0, // h-14 (increased for outside labels)
    heightWithLabelInside: 64.0, // h-16 when label inside
    fontSize: 16.0, // text-medium
    labelFontSize: 16.0, // text-medium for inside labels (lg)
    outsideLabelFontSize: 16.0, // text-medium for outside labels
    paddingX: 12.0, // px-3
    gap: 12.0,
  );

  static InputSizeConfig getConfig(BlockinInputSizeType size) => switch (size) {
    BlockinInputSizeType.small => small,
    BlockinInputSizeType.medium => medium,
    BlockinInputSizeType.large => large,
  };
}

class BlockinInputRadius {
  static double getRadius(BlockinInputRadiusType radius) => switch (radius) {
    BlockinInputRadiusType.none => 0,
    BlockinInputRadiusType.small => 6,
    BlockinInputRadiusType.medium => 10,
    BlockinInputRadiusType.large => 14,
    BlockinInputRadiusType.full => 999,
  };
}

/// Opacity values for different states, mirrored from button system for consistency
class BlockinInputOpacity {
  static const double hover = 0.92;
  static const double disabled = 0.5;
}
