/// Font size constants used in Blockin typography system
///
/// These font sizes follow the Tailwind CSS typography scale,
/// providing a consistent and modern typographic hierarchy.
///
/// Example usage:
/// ```dart
/// Text(
///   'Hello',
///   style: TextStyle(fontSize: FontSize.headingLarge),
/// )
/// ```
///
/// Based on Tailwind CSS:
/// - Display styles use text-6xl, text-5xl, text-4xl
/// - Heading styles use text-3xl, text-2xl
/// - Body and label styles use text-base, text-sm, text-xs
class FontSize {
  const FontSize._();

  /// Display large - 60px (text-6xl)
  static const double displayLarge = 60;

  /// Display medium - 48px (text-5xl)
  static const double displayMedium = 48;

  /// Display small - 36px (text-4xl)
  static const double displaySmall = 36;

  /// Heading large - 30px (text-3xl)
  static const double headingLarge = 30;

  /// Heading medium - 24px (text-2xl)
  static const double headingMedium = 24;

  /// Heading small - 20px (text-xl)
  static const double headingSmall = 20;

  /// Title large - 18px (text-lg)
  static const double titleLarge = 18;

  /// Title medium - 16px (text-base)
  static const double titleMedium = 16;

  /// Title small - 14px (text-sm)
  static const double titleSmall = 14;

  /// Body large - 18px (text-lg)
  static const double bodyLarge = 18;

  /// Body medium - 16px (text-base, default body text)
  static const double bodyMedium = 16;

  /// Body small - 14px (text-sm)
  static const double bodySmall = 14;

  /// Label large - 14px (text-sm)
  static const double labelLarge = 14;

  /// Label medium - 12px (text-xs)
  static const double labelMedium = 12;

  /// Label small - 12px (text-xs)
  static const double labelSmall = 12;

  /// Caption - 12px (text-xs, smallest text)
  static const double caption = 12;
}

class FontFamily {
  const FontFamily._();

  static const String nunito = 'Nunito';
}
