import 'package:wesee/app/routes/routes.dart';
import 'package:wesee/app/screens/home/pages/mypage/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyPage extends GetView<MyPageController> {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Get.toNamed(Routes.PROFILE);
        },
        child: const Text('프로필'),
      ),
    );
  }
}