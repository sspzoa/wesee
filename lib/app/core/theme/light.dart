import 'package:flutter/material.dart';

import 'wesee_colors.dart';
import 'wesee_theme.dart';
import 'wesee_typography.dart';

class WeseeLightThemeColors extends WeseeColors {
  WeseeLightThemeColors()
      : super(
    grayscale100: const Color(0xFFFDFEFE),
    grayscale200: const Color(0xFFF4F5F5),
    grayscale300: const Color(0xFFEAEBEB),
    grayscale400: const Color(0xFFDADDDD),
    grayscale500: const Color(0xFFB4B9B9),
    grayscale600: const Color(0xFF808989),
    grayscale700: const Color(0xFF626A6B),
    grayscale800: const Color(0xFF4B5152),
    grayscale900: const Color(0xFF333738),
    grayscale1000: const Color(0xFF1C1F1F),
    primaryBrand: const Color(0xFFAF272F),
    primaryNegative: const Color(0xFFB1B3B3),
  );
}

class WeseeLightThemeTypography extends WeseeTypography {
  WeseeLightThemeTypography() : super(defaultColor: WeseeLightThemeColors().grayscale700);
}

class WeseeLightTheme extends WeseeTheme {
  WeseeLightTheme() : super(colors: WeseeLightThemeColors(), textStyle: WeseeLightThemeTypography());
}