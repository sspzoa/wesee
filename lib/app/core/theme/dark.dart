import 'package:flutter/material.dart';

import 'wesee_colors.dart';
import 'wesee_theme.dart';
import 'wesee_typography.dart';

class WeseeDarkThemeColors extends WeseeColors {
  WeseeDarkThemeColors()
      : super(
    grayscale100: const Color(0xFF222525),
    grayscale200: const Color(0xFF1C1F1F),
    grayscale300: const Color(0xFF2C3030),
    grayscale400: const Color(0xFF3B3F40),
    grayscale500: const Color(0xFF808989),
    grayscale600: const Color(0xFFB4B9B9),
    grayscale700: const Color(0xFFDADDDD),
    grayscale800: const Color(0xFFEAEBEB),
    grayscale900: const Color(0xFFF4F5F5),
    grayscale1000: const Color(0xFFFDFEFE),
    primaryBrand: const Color(0xFFAF272F),
    primaryNegative: const Color(0xFFB1B3B3),
  );
}

class WeseeDarkThemeTypography extends WeseeTypography {
  WeseeDarkThemeTypography() : super(defaultColor: WeseeDarkThemeColors().grayscale700);
}

class WeseeDarkTheme extends WeseeTheme {
  WeseeDarkTheme() : super(colors: WeseeDarkThemeColors(), textStyle: WeseeDarkThemeTypography());
}