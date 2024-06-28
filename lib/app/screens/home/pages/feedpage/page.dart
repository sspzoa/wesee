import 'package:wesee/app/core/theme/wesee_colors.dart';
import 'package:wesee/app/core/theme/wesee_typography.dart';
import 'package:wesee/app/screens/home/pages/feedpage/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeedPage extends GetView<FeedPageController> {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    WeseeColors colorTheme = Theme.of(context).extension<WeseeColors>()!;
    WeseeTypography textTheme = Theme.of(context).extension<WeseeTypography>()!;

    return Container(
      child: Center(
        child: Text(
          '피드',
          style: textTheme.header1.copyWith(color: colorTheme.primaryBrand),
        ),
      ),
    );
  }
}