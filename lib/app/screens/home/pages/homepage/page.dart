import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wesee/app/core/theme/wesee_colors.dart';
import 'package:wesee/app/core/theme/wesee_typography.dart';
import 'package:wesee/app/screens/home/pages/homepage/controller.dart';
class HomePage extends GetView<HomePageController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Center(
            child: ElevatedButton(
          onPressed: () {
            controller.startCamera();
          },
          child: const Text('카메라 시작하기'),
        ));
      },
    );
  }
}