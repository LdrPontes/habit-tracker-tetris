import 'package:flutter/material.dart';

/// Interface for common colors
abstract class ICommonColors {
  Color get white;
  Color get black;
  MaterialColor get blue;
  MaterialColor get purple;
  MaterialColor get pink;
  MaterialColor get green;
  MaterialColor get red;
  MaterialColor get yellow;
  MaterialColor get cyan;
  MaterialColor get zinc;
}

/// Common colors implementation with all color scales
///
/// Provides the standard Blockin color palette with full MaterialColor scales (50-900)
mixin CommonColorsMixin implements ICommonColors {
  @override
  Color get white => const Color(0xFFFFFFFF);

  @override
  Color get black => const Color(0xFF000000);

  @override
  MaterialColor get blue => const MaterialColor(0xFF006FEE, {
    50: Color(0xFFE6F1FE),
    100: Color(0xFFCCE3FD),
    200: Color(0xFF99C7FB),
    300: Color(0xFF66AAF9),
    400: Color(0xFF338EF7),
    500: Color(0xFF006FEE),
    600: Color(0xFF005BC4),
    700: Color(0xFF004493),
    800: Color(0xFF002E62),
    900: Color(0xFF001731),
  });

  @override
  MaterialColor get green => const MaterialColor(0xFF17C964, {
    50: Color(0xFFE8FAF0),
    100: Color(0xFFD1F4E0),
    200: Color(0xFFA2E9C1),
    300: Color(0xFF74DFA2),
    400: Color(0xFF45D483),
    500: Color(0xFF17C964),
    600: Color(0xFF12A150),
    700: Color(0xFF0E793C),
    800: Color(0xFF095028),
    900: Color(0xFF052814),
  });

  @override
  MaterialColor get pink => const MaterialColor(0xFFFF4ECD, {
    50: Color(0xFFFFEDFA),
    100: Color(0xFFFFDCF5),
    200: Color(0xFFFFB8EB),
    300: Color(0xFFFF95E1),
    400: Color(0xFFFF71D7),
    500: Color(0xFFFF4ECD),
    600: Color(0xFFCC3EA4),
    700: Color(0xFF992F7B),
    800: Color(0xFF661F52),
    900: Color(0xFF331029),
  });

  @override
  MaterialColor get purple => const MaterialColor(0xFF7828C8, {
    50: Color(0xFFF2EAFA),
    100: Color(0xFFE4D4F4),
    200: Color(0xFFC9A9E9),
    300: Color(0xFFAE7EDE),
    400: Color(0xFF9353D3),
    500: Color(0xFF7828C8),
    600: Color(0xFF6020A0),
    700: Color(0xFF481878),
    800: Color(0xFF301050),
    900: Color(0xFF180828),
  });

  @override
  MaterialColor get red => const MaterialColor(0xFFF31260, {
    50: Color(0xFFFEE7EF),
    100: Color(0xFFFDD0DF),
    200: Color(0xFFFAA0BF),
    300: Color(0xFFF871A0),
    400: Color(0xFFF54180),
    500: Color(0xFFF31260),
    600: Color(0xFFC20E4D),
    700: Color(0xFF920B3A),
    800: Color(0xFF610726),
    900: Color(0xFF310413),
  });

  @override
  MaterialColor get yellow => const MaterialColor(0xFFF5A524, {
    50: Color(0xFFFEFCE8),
    100: Color(0xFFFDEDD3),
    200: Color(0xFFFBDBA7),
    300: Color(0xFFF9C97C),
    400: Color(0xFFF7B750),
    500: Color(0xFFF5A524),
    600: Color(0xFFC4841D),
    700: Color(0xFF936316),
    800: Color(0xFF62420E),
    900: Color(0xFF312107),
  });

  @override
  MaterialColor get cyan => const MaterialColor(0xFF7EE7FC, {
    50: Color(0xFFF0FCFF),
    100: Color(0xFFE6FAFE),
    200: Color(0xFFD7F8FE),
    300: Color(0xFFC3F4FD),
    400: Color(0xFFA5EEFD),
    500: Color(0xFF7EE7FC),
    600: Color(0xFF06B7DB),
    700: Color(0xFF09AACD),
    800: Color(0xFF0E8AAA),
    900: Color(0xFF053B48),
  });

  @override
  MaterialColor get zinc => const MaterialColor(0xFFD4D4D8, {
    50: Color(0xFFFAFAFA),
    100: Color(0xFFF4F4F5),
    200: Color(0xFFE4E4E7),
    300: Color(0xFFD4D4D8),
    400: Color(0xFFA1A1AA),
    500: Color(0xFF71717A),
    600: Color(0xFF52525B),
    700: Color(0xFF3F3F46),
    800: Color(0xFF27272A),
    900: Color(0xFF18181B),
  });
}
