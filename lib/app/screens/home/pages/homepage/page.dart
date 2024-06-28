import 'package:wesee/app/core/theme/wesee_colors.dart';
import 'package:wesee/app/core/theme/wesee_typography.dart';
import 'package:wesee/app/screens/home/pages/homepage/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class HomePage extends GetView<HomePageController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    WeseeColors colorTheme = Theme.of(context).extension<WeseeColors>()!;
    WeseeTypography textTheme = Theme.of(context).extension<WeseeTypography>()!;
    return LayoutBuilder(
      builder: (context, constraints) {
        return Center(
          child: Text(
            '홈',
            style: textTheme.header1.copyWith(color: colorTheme.primaryBrand),
          ),
        );
      },
    );
  }
}