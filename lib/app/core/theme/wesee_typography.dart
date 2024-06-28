import 'package:flutter/material.dart';

TextStyle style(FontWeight weight, double size, double height, Color color, {bool underlined = false, double spacing = 0}) => TextStyle(
  color: color,
  height: height / size,
  fontSize: size,
  fontFamily: 'SUITv1',
  fontWeight: weight,
  letterSpacing: spacing,
  decoration: underlined ? TextDecoration.underline : TextDecoration.none,
  decorationColor: color,
);

abstract class Weight {
  static const thin = FontWeight.w100;
  static const extraLight = FontWeight.w200;
  static const light = FontWeight.w300;
  static const regular = FontWeight.w400;
  static const medium = FontWeight.w500;
  static const semiBold = FontWeight.w600;
  static const bold = FontWeight.w700;
  static const extraBold = FontWeight.w800;
  static const heavy = FontWeight.w900;
}

class WeseeTypography extends ThemeExtension<WeseeTypography> {
  final Color defaultColor;

  WeseeTypography({
    required this.defaultColor,
    TextStyle? title,
    TextStyle? header1,
    TextStyle? header2,
    TextStyle? itemTitle,
    TextStyle? itemDescription,
    TextStyle? description,
    TextStyle? readable,
    TextStyle? token,
    TextStyle? hint,
    TextStyle? paragraph1,
    TextStyle? paragraph2,
    TextStyle? paragraph1Underlined,
    TextStyle? paragraph2Underlined,
  })  : title = title ?? style(Weight.semiBold, 28, 36, defaultColor),
        header1 = header1 ?? style(Weight.bold, 24, 32, defaultColor),
        header2 = header2 ?? style(Weight.semiBold, 20, 26, defaultColor),
        itemTitle = itemTitle ?? style(Weight.semiBold, 16, 22, defaultColor),
        itemDescription = itemDescription ?? style(Weight.medium, 14, 20, defaultColor),
        description = description ?? style(Weight.semiBold, 16, 22, defaultColor),
        readable = readable ?? style(Weight.semiBold, 14, 20, defaultColor),
        token = token ?? style(Weight.regular, 12, 18, defaultColor),
        hint = hint ?? style(Weight.regular, 10, 16, defaultColor),
        paragraph1 = paragraph1 ?? style(Weight.regular, 16, 16 * 1.6, defaultColor),
        paragraph2 = paragraph2 ?? style(Weight.regular, 14, 14 * 1.6, defaultColor),
        paragraph1Underlined = paragraph1Underlined ?? style(Weight.regular, 16, 16 * 1.6, underlined: true, defaultColor),
        paragraph2Underlined = paragraph2Underlined ?? style(Weight.regular, 14, 14 * 1.6, underlined: true, defaultColor);

  final TextStyle title;

  final TextStyle header1;

  final TextStyle header2;

  final TextStyle itemTitle;

  final TextStyle itemDescription;

  final TextStyle description;

  final TextStyle readable;

  final TextStyle token;

  final TextStyle hint;

  final TextStyle paragraph1;

  final TextStyle paragraph2;

  final TextStyle paragraph1Underlined;

  final TextStyle paragraph2Underlined;

  @override
  ThemeExtension<WeseeTypography> copyWith({
    Color? defaultColor,
    TextStyle? title,
    TextStyle? header1,
    TextStyle? header2,
    TextStyle? itemTitle,
    TextStyle? itemDescription,
    TextStyle? description,
    TextStyle? readable,
    TextStyle? token,
    TextStyle? hint,
    TextStyle? paragraph1,
    TextStyle? paragraph2,
    TextStyle? paragraph1Underlined,
    TextStyle? paragraph2Underlined,
  }) {
    return WeseeTypography(
      defaultColor: defaultColor ?? this.defaultColor,
      title: title ?? this.title,
      header1: header1 ?? this.header1,
      header2: header2 ?? this.header2,
      itemTitle: itemTitle ?? this.itemTitle,
      itemDescription: itemDescription ?? this.itemDescription,
      description: description ?? this.description,
      readable: readable ?? this.readable,
      token: token ?? this.token,
      hint: hint ?? this.hint,
      paragraph1: paragraph1 ?? this.paragraph1,
      paragraph2: paragraph2 ?? this.paragraph2,
      paragraph1Underlined: paragraph1Underlined ?? this.paragraph1Underlined,
      paragraph2Underlined: paragraph2Underlined ?? this.paragraph2Underlined,
    );
  }

  @override
  ThemeExtension<WeseeTypography> lerp(covariant ThemeExtension<WeseeTypography>? other, double t) {
    if (other is! WeseeTypography) {
      return this;
    }
    return WeseeTypography(
      defaultColor: Color.lerp(defaultColor, other.defaultColor, t)!,
      title: TextStyle.lerp(title, other.title, t),
      header1: TextStyle.lerp(header1, other.header1, t),
      header2: TextStyle.lerp(header2, other.header2, t),
      itemTitle: TextStyle.lerp(itemTitle, other.itemTitle, t),
      itemDescription: TextStyle.lerp(itemDescription, other.itemDescription, t),
      description: TextStyle.lerp(description, other.description, t),
      readable: TextStyle.lerp(readable, other.readable, t),
      token: TextStyle.lerp(token, other.token, t),
      hint: TextStyle.lerp(hint, other.hint, t),
      paragraph1: TextStyle.lerp(paragraph1, other.paragraph1, t),
      paragraph2: TextStyle.lerp(paragraph2, other.paragraph2, t),
      paragraph1Underlined: TextStyle.lerp(paragraph1Underlined, other.paragraph1Underlined, t),
      paragraph2Underlined: TextStyle.lerp(paragraph2Underlined, other.paragraph2Underlined, t),
    );
  }
}