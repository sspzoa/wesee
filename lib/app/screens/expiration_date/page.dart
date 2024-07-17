import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wesee/app/core/theme/wesee_colors.dart';
import 'package:wesee/app/core/theme/wesee_typography.dart';
import 'package:wesee/app/routes/routes.dart';
import 'package:wesee/app/screens/home/controller.dart';

class ExpirationDateScreen extends GetView<HomeController> {
  const ExpirationDateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).extension<WeseeColors>()!;
    final textTheme = Theme.of(context).extension<WeseeTypography>()!;
    return Scaffold(
      appBar: AppBar(
        title: Text('Expiration Date', style: textTheme.title),
      ),
      body: Center(
        child: Column(
            children: [
              ElevatedButton(
                onPressed: () => Get.toNamed(Routes.CAPTURE),
                child: const Text('캡쳐'),
              ),
              ElevatedButton(
                onPressed: () => Get.toNamed(Routes.LIST),
                child: const Text('리스트'),
              )
            ]
        ),
      )
    );
  }
}