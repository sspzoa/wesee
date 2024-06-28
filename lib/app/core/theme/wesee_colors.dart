import 'package:flutter/material.dart';

class WeseeColors extends ThemeExtension<WeseeColors> {
  final Color grayscale100;
  final Color grayscale200;
  final Color grayscale300;
  final Color grayscale400;
  final Color grayscale500;
  final Color grayscale600;
  final Color grayscale700;
  final Color grayscale800;
  final Color grayscale900;
  final Color grayscale1000;
  final Color primaryBrand;
  final Color primaryNegative;

  WeseeColors({
    required this.grayscale100,
    required this.grayscale200,
    required this.grayscale300,
    required this.grayscale400,
    required this.grayscale500,
    required this.grayscale600,
    required this.grayscale700,
    required this.grayscale800,
    required this.grayscale900,
    required this.grayscale1000,
    required this.primaryBrand,
    required this.primaryNegative,
  });

  @override
  ThemeExtension<WeseeColors> copyWith({
    Color? grayscale100,
    Color? grayscale200,
    Color? grayscale300,
    Color? grayscale400,
    Color? grayscale500,
    Color? grayscale600,
    Color? grayscale700,
    Color? grayscale800,
    Color? grayscale900,
    Color? grayscale1000,
    Color? primaryBrand,
    Color? primaryNegative,
  }) {
    return WeseeColors(
      grayscale100: grayscale100 ?? this.grayscale100,
      grayscale200: grayscale200 ?? this.grayscale200,
      grayscale300: grayscale300 ?? this.grayscale300,
      grayscale400: grayscale400 ?? this.grayscale400,
      grayscale500: grayscale500 ?? this.grayscale500,
      grayscale600: grayscale600 ?? this.grayscale600,
      grayscale700: grayscale700 ?? this.grayscale700,
      grayscale800: grayscale800 ?? this.grayscale800,
      grayscale900: grayscale900 ?? this.grayscale900,
      grayscale1000: grayscale1000 ?? this.grayscale1000,
      primaryBrand: primaryBrand ?? this.primaryBrand,
      primaryNegative: primaryNegative ?? this.primaryNegative,
    );
  }

  @override
  ThemeExtension<WeseeColors> lerp(covariant ThemeExtension<WeseeColors>? other, double t) {
    if (other is! WeseeColors) {
      return this;
    }

    return WeseeColors(
      grayscale100: Color.lerp(grayscale100, other.grayscale100, t)!,
      grayscale200: Color.lerp(grayscale200, other.grayscale200, t)!,
      grayscale300: Color.lerp(grayscale300, other.grayscale300, t)!,
      grayscale400: Color.lerp(grayscale400, other.grayscale400, t)!,
      grayscale500: Color.lerp(grayscale500, other.grayscale500, t)!,
      grayscale600: Color.lerp(grayscale600, other.grayscale600, t)!,
      grayscale700: Color.lerp(grayscale700, other.grayscale700, t)!,
      grayscale800: Color.lerp(grayscale800, other.grayscale800, t)!,
      grayscale900: Color.lerp(grayscale900, other.grayscale900, t)!,
      grayscale1000: Color.lerp(grayscale1000, other.grayscale1000, t)!,
      primaryBrand: Color.lerp(primaryBrand, other.primaryBrand, t)!,
      primaryNegative: Color.lerp(primaryNegative, other.primaryNegative, t)!,
    );
  }
}