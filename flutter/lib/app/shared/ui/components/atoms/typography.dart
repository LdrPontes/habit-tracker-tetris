import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:blockin/theme/typography.dart';

/// Typography variant for BlockinText component
enum BlockinTextVariant {
  /// Display large text - largest heading
  displayLarge,

  /// Display medium text
  displayMedium,

  /// Display small text
  displaySmall,

  /// Heading large text
  headingLarge,

  /// Heading medium text
  headingMedium,

  /// Heading small text
  headingSmall,

  /// Title large text
  titleLarge,

  /// Title medium text
  titleMedium,

  /// Title small text
  titleSmall,

  /// Body large text
  bodyLarge,

  /// Body medium text (default)
  bodyMedium,

  /// Body small text
  bodySmall,

  /// Label large text
  labelLarge,

  /// Label medium text
  labelMedium,

  /// Label small text
  labelSmall,

  /// Caption text - smallest text
  caption,

  /// Link text
  link,
}

/// Blockin Text Component
///
/// A flexible text component that integrates with Blockin's typography and color system.
///
/// Example:
/// ```dart
/// BlockinText('Hello World')
///
/// BlockinText(
///   'Large Heading',
///   variant: BlockinTextVariant.headingLarge,
///   color: Colors.blue,
/// )
///
/// BlockinText(
///   'Gradient Text',
///   variant: BlockinTextVariant.displayLarge,
///   gradient: LinearGradient(
///     colors: [Colors.blue, Colors.purple],
///   ),
/// )
///
/// BlockinText(
///   'Custom styled text',
///   variant: BlockinTextVariant.bodyLarge,
///   color: Theme.of(context).colors.primary,
///   style: TextStyle(fontStyle: FontStyle.italic),
/// )
/// ```
class BlockinText extends StatelessWidget {
  /// The text to display
  final String text;

  /// Typography variant to use
  final BlockinTextVariant variant;

  /// Custom color to use for the text
  final Color? color;

  /// Gradient to apply to the text (overrides color if provided)
  final Gradient? gradient;

  /// Custom text style to merge with the variant style
  final TextStyle? style;

  /// How to align the text horizontally
  final TextAlign? textAlign;

  /// Whether the text should break at soft line breaks
  final bool? softWrap;

  /// How visual overflow should be handled
  final TextOverflow? overflow;

  /// Maximum number of lines for the text to span
  final int? maxLines;

  /// How the text should be scaled
  final TextScaler? textScaler;

  /// An alternative semantics label for this text
  final String? semanticsLabel;

  /// How the text should be aligned vertically
  final TextWidthBasis? textWidthBasis;

  /// How to handle text that doesn't fit in the available space
  final TextHeightBehavior? textHeightBehavior;

  const BlockinText(
    this.text, {
    super.key,
    this.variant = BlockinTextVariant.bodyMedium,
    this.color,
    this.gradient,
    this.style,
    this.textAlign,
    this.softWrap,
    this.overflow,
    this.maxLines,
    this.textScaler,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
  });

  /// Create a display large text
  const BlockinText.displayLarge(
    this.text, {
    super.key,
    this.color,
    this.gradient,
    this.style,
    this.textAlign,
    this.softWrap,
    this.overflow,
    this.maxLines,
    this.textScaler,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
  }) : variant = BlockinTextVariant.displayLarge;

  /// Create a display medium text
  const BlockinText.displayMedium(
    this.text, {
    super.key,
    this.color,
    this.gradient,
    this.style,
    this.textAlign,
    this.softWrap,
    this.overflow,
    this.maxLines,
    this.textScaler,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
  }) : variant = BlockinTextVariant.displayMedium;

  /// Create a display small text
  const BlockinText.displaySmall(
    this.text, {
    super.key,
    this.color,
    this.gradient,
    this.style,
    this.textAlign,
    this.softWrap,
    this.overflow,
    this.maxLines,
    this.textScaler,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
  }) : variant = BlockinTextVariant.displaySmall;

  /// Create a heading large text
  const BlockinText.headingLarge(
    this.text, {
    super.key,
    this.color,
    this.gradient,
    this.style,
    this.textAlign,
    this.softWrap,
    this.overflow,
    this.maxLines,
    this.textScaler,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
  }) : variant = BlockinTextVariant.headingLarge;

  /// Create a heading medium text
  const BlockinText.headingMedium(
    this.text, {
    super.key,
    this.color,
    this.gradient,
    this.style,
    this.textAlign,
    this.softWrap,
    this.overflow,
    this.maxLines,
    this.textScaler,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
  }) : variant = BlockinTextVariant.headingMedium;

  /// Create a heading small text
  const BlockinText.headingSmall(
    this.text, {
    super.key,
    this.color,
    this.gradient,
    this.style,
    this.textAlign,
    this.softWrap,
    this.overflow,
    this.maxLines,
    this.textScaler,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
  }) : variant = BlockinTextVariant.headingSmall;

  /// Create a title large text
  const BlockinText.titleLarge(
    this.text, {
    super.key,
    this.color,
    this.gradient,
    this.style,
    this.textAlign,
    this.softWrap,
    this.overflow,
    this.maxLines,
    this.textScaler,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
  }) : variant = BlockinTextVariant.titleLarge;

  /// Create a title medium text
  const BlockinText.titleMedium(
    this.text, {
    super.key,
    this.color,
    this.gradient,
    this.style,
    this.textAlign,
    this.softWrap,
    this.overflow,
    this.maxLines,
    this.textScaler,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
  }) : variant = BlockinTextVariant.titleMedium;

  /// Create a title small text
  const BlockinText.titleSmall(
    this.text, {
    super.key,
    this.color,
    this.gradient,
    this.style,
    this.textAlign,
    this.softWrap,
    this.overflow,
    this.maxLines,
    this.textScaler,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
  }) : variant = BlockinTextVariant.titleSmall;

  /// Create a body large text
  const BlockinText.bodyLarge(
    this.text, {
    super.key,
    this.color,
    this.gradient,
    this.style,
    this.textAlign,
    this.softWrap,
    this.overflow,
    this.maxLines,
    this.textScaler,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
  }) : variant = BlockinTextVariant.bodyLarge;

  /// Create a body medium text
  const BlockinText.bodyMedium(
    this.text, {
    super.key,
    this.color,
    this.gradient,
    this.style,
    this.textAlign,
    this.softWrap,
    this.overflow,
    this.maxLines,
    this.textScaler,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
  }) : variant = BlockinTextVariant.bodyMedium;

  /// Create a body small text
  const BlockinText.bodySmall(
    this.text, {
    super.key,
    this.color,
    this.gradient,
    this.style,
    this.textAlign,
    this.softWrap,
    this.overflow,
    this.maxLines,
    this.textScaler,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
  }) : variant = BlockinTextVariant.bodySmall;

  /// Create a label large text
  const BlockinText.labelLarge(
    this.text, {
    super.key,
    this.color,
    this.gradient,
    this.style,
    this.textAlign,
    this.softWrap,
    this.overflow,
    this.maxLines,
    this.textScaler,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
  }) : variant = BlockinTextVariant.labelLarge;

  /// Create a label medium text
  const BlockinText.labelMedium(
    this.text, {
    super.key,
    this.color,
    this.gradient,
    this.style,
    this.textAlign,
    this.softWrap,
    this.overflow,
    this.maxLines,
    this.textScaler,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
  }) : variant = BlockinTextVariant.labelMedium;

  /// Create a label small text
  const BlockinText.labelSmall(
    this.text, {
    super.key,
    this.color,
    this.gradient,
    this.style,
    this.textAlign,
    this.softWrap,
    this.overflow,
    this.maxLines,
    this.textScaler,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
  }) : variant = BlockinTextVariant.labelSmall;

  /// Create a caption text
  const BlockinText.caption(
    this.text, {
    super.key,
    this.color,
    this.gradient,
    this.style,
    this.textAlign,
    this.softWrap,
    this.overflow,
    this.maxLines,
    this.textScaler,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
  }) : variant = BlockinTextVariant.caption;

  /// Create a link text
  const BlockinText.link(
    this.text, {
    super.key,
    this.color,
    this.gradient,
    this.style,
    this.textAlign,
    this.softWrap,
    this.overflow,
    this.maxLines,
    this.textScaler,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
  }) : variant = BlockinTextVariant.link;

  /// Get the text style for the given variant
  TextStyle _getVariantStyle(BuildContext context) {
    final typography = Theme.of(context).blockinTypography;
    switch (variant) {
      case BlockinTextVariant.displayLarge:
        return typography.displayLarge;
      case BlockinTextVariant.displayMedium:
        return typography.displayMedium;
      case BlockinTextVariant.displaySmall:
        return typography.displaySmall;
      case BlockinTextVariant.headingLarge:
        return typography.headingLarge;
      case BlockinTextVariant.headingMedium:
        return typography.headingMedium;
      case BlockinTextVariant.headingSmall:
        return typography.headingSmall;
      case BlockinTextVariant.titleLarge:
        return typography.titleLarge;
      case BlockinTextVariant.titleMedium:
        return typography.titleMedium;
      case BlockinTextVariant.titleSmall:
        return typography.titleSmall;
      case BlockinTextVariant.bodyLarge:
        return typography.bodyLarge;
      case BlockinTextVariant.bodyMedium:
        return typography.bodyMedium;
      case BlockinTextVariant.bodySmall:
        return typography.bodySmall;
      case BlockinTextVariant.labelLarge:
        return typography.labelLarge;
      case BlockinTextVariant.labelMedium:
        return typography.labelMedium;
      case BlockinTextVariant.labelSmall:
        return typography.labelSmall;
      case BlockinTextVariant.caption:
        return typography.caption;
      case BlockinTextVariant.link:
        return typography.link;
    }
  }

  @override
  Widget build(BuildContext context) {
    final variantStyle = _getVariantStyle(context);

    // Merge styles: variant style -> custom color -> custom style
    final effectiveStyle = variantStyle
        .copyWith(color: color, decorationColor: color)
        .merge(style);

    final textWidget = Text(
      text,
      style: effectiveStyle,
      textAlign: textAlign,
      softWrap: softWrap,
      overflow: overflow,
      maxLines: maxLines,
      textScaler: textScaler,
      semanticsLabel: semanticsLabel,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
    );

    // Apply gradient if provided
    if (gradient != null) {
      return ShaderMask(
        shaderCallback: (bounds) => gradient!.createShader(
          Rect.fromLTWH(0, 0, bounds.width, bounds.height),
        ),
        blendMode: BlendMode.srcIn,
        child: textWidget,
      );
    }

    return textWidget;
  }
}

/// Blockin Rich Text Component
///
/// A flexible rich text component that allows multiple text spans with different styles.
///
/// Example:
/// ```dart
/// BlockinRichText(
///   children: [
///     BlockinTextSpan(text: 'Hello '),
///     BlockinTextSpan(
///       text: 'World',
///       color: Colors.blue,
///       variant: BlockinTextVariant.headingLarge,
///     ),
///   ],
/// )
///
/// BlockinRichText(
///   gradient: LinearGradient(colors: [Colors.blue, Colors.purple]),
///   children: [
///     BlockinTextSpan(text: 'Gradient '),
///     BlockinTextSpan(text: 'Rich Text'),
///   ],
/// )
///
/// BlockinRichText.fromSpans(
///   [
///     TextSpan(text: 'Regular text '),
///     TextSpan(
///       text: 'Bold',
///       style: TextStyle(fontWeight: FontWeight.bold),
///     ),
///   ],
///   variant: BlockinTextVariant.bodyLarge,
/// )
/// ```
class BlockinRichText extends StatelessWidget {
  /// The text spans to display
  final List<BlockinTextSpan> children;

  /// Base typography variant to use (applies to spans without explicit variant)
  final BlockinTextVariant variant;

  /// Base gradient to apply to the entire text (can be overridden per span)
  final Gradient? gradient;

  /// How to align the text horizontally
  final TextAlign? textAlign;

  /// Whether the text should break at soft line breaks
  final bool? softWrap;

  /// How visual overflow should be handled
  final TextOverflow? overflow;

  /// Maximum number of lines for the text to span
  final int? maxLines;

  /// How the text should be scaled
  final TextScaler? textScaler;

  /// How the text should be aligned vertically
  final TextWidthBasis? textWidthBasis;

  /// How to handle text that doesn't fit in the available space
  final TextHeightBehavior? textHeightBehavior;

  const BlockinRichText({
    super.key,
    required this.children,
    this.variant = BlockinTextVariant.bodyMedium,
    this.gradient,
    this.textAlign,
    this.softWrap,
    this.overflow,
    this.maxLines,
    this.textScaler,
    this.textWidthBasis,
    this.textHeightBehavior,
  });

  /// Create a BlockinRichText from regular TextSpans
  ///
  /// This allows you to use standard Flutter TextSpans while still
  /// benefiting from Blockin's typography system for the base style.
  const BlockinRichText.fromSpans(
    List<InlineSpan> spans, {
    super.key,
    this.variant = BlockinTextVariant.bodyMedium,
    this.gradient,
    this.textAlign,
    this.softWrap,
    this.overflow,
    this.maxLines,
    this.textScaler,
    this.textWidthBasis,
    this.textHeightBehavior,
  }) : children = const [];

  /// Get the text style for the given variant
  TextStyle _getVariantStyle(BuildContext context, BlockinTextVariant variant) {
    final typography = Theme.of(context).blockinTypography;
    switch (variant) {
      case BlockinTextVariant.displayLarge:
        return typography.displayLarge;
      case BlockinTextVariant.displayMedium:
        return typography.displayMedium;
      case BlockinTextVariant.displaySmall:
        return typography.displaySmall;
      case BlockinTextVariant.headingLarge:
        return typography.headingLarge;
      case BlockinTextVariant.headingMedium:
        return typography.headingMedium;
      case BlockinTextVariant.headingSmall:
        return typography.headingSmall;
      case BlockinTextVariant.titleLarge:
        return typography.titleLarge;
      case BlockinTextVariant.titleMedium:
        return typography.titleMedium;
      case BlockinTextVariant.titleSmall:
        return typography.titleSmall;
      case BlockinTextVariant.bodyLarge:
        return typography.bodyLarge;
      case BlockinTextVariant.bodyMedium:
        return typography.bodyMedium;
      case BlockinTextVariant.bodySmall:
        return typography.bodySmall;
      case BlockinTextVariant.labelLarge:
        return typography.labelLarge;
      case BlockinTextVariant.labelMedium:
        return typography.labelMedium;
      case BlockinTextVariant.labelSmall:
        return typography.labelSmall;
      case BlockinTextVariant.caption:
        return typography.caption;
      case BlockinTextVariant.link:
        return typography.link;
    }
  }

  /// Convert BlockinTextSpan to Flutter TextSpan
  TextSpan _buildTextSpan(BuildContext context, BlockinTextSpan span) {
    final baseStyle = _getVariantStyle(context, span.variant ?? variant);
    final effectiveStyle = baseStyle
        .copyWith(color: span.color, decorationColor: span.color)
        .merge(span.style);

    return TextSpan(
      text: span.text,
      style: effectiveStyle,
      children: span.children
          ?.map((child) => _buildTextSpan(context, child))
          .toList(),
      recognizer: span.recognizer,
      semanticsLabel: span.semanticsLabel,
    );
  }

  @override
  Widget build(BuildContext context) {
    final baseStyle = _getVariantStyle(context, variant);

    final textWidget = Text.rich(
      TextSpan(
        style: baseStyle,
        children: children
            .map((span) => _buildTextSpan(context, span))
            .toList(),
      ),
      textAlign: textAlign,
      softWrap: softWrap,
      overflow: overflow,
      maxLines: maxLines,
      textScaler: textScaler,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
    );

    // Apply gradient if provided
    if (gradient != null) {
      return ShaderMask(
        shaderCallback: (bounds) => gradient!.createShader(
          Rect.fromLTWH(0, 0, bounds.width, bounds.height),
        ),
        blendMode: BlendMode.srcIn,
        child: textWidget,
      );
    }

    return textWidget;
  }
}

/// A text span for use with BlockinRichText
///
/// Similar to Flutter's TextSpan but integrates with Blockin's typography system.
class BlockinTextSpan {
  /// The text content
  final String? text;

  /// Typography variant for this span (overrides parent variant)
  final BlockinTextVariant? variant;

  /// Color for this span
  final Color? color;

  /// Gradient for this span (overrides color if provided)
  final Gradient? gradient;

  /// Custom text style to merge with the variant style
  final TextStyle? style;

  /// Child text spans
  final List<BlockinTextSpan>? children;

  /// Gesture recognizer for tap/long press handling
  final GestureRecognizer? recognizer;

  /// Semantics label for accessibility
  final String? semanticsLabel;

  const BlockinTextSpan({
    this.text,
    this.variant,
    this.color,
    this.gradient,
    this.style,
    this.children,
    this.recognizer,
    this.semanticsLabel,
  });
}
