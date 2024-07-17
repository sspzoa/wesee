import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wesee/app/core/theme/wesee_colors.dart';
import 'package:wesee/app/core/theme/wesee_typography.dart';
import 'package:wesee/app/routes/routes.dart';
import 'package:wesee/app/screens/home/controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).extension<WeseeColors>()!;
    final textTheme = Theme.of(context).extension<WeseeTypography>()!;
    return Scaffold(
      appBar: AppBar(
        title: Text('WeSee', style: textTheme.title),
        backgroundColor: colorTheme.primaryBrand,
      ),
      body: Column(
          children: [
            ElevatedButton(
              onPressed: () => Get.toNamed(Routes.SHORT_MALL),
              child: const Text('숏몰'),
            ),
            ElevatedButton(
              onPressed: () => Get.toNamed(Routes.EXPIRATION_DATE),
              child: const Text('소비기한'),
            )
          ]
      ),
    );
  }
}