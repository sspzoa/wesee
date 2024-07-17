import 'package:wesee/app/screens/test/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestScreen extends GetView<TestController> {
  const TestScreen({super.key});

  Widget linkToRoute(String route) {
    return TextButton(
      onPressed: () {
        Get.toNamed(route);
      },
      child: Text(route),
    );
  }

  Widget linkToRouteWithArgs(
      String route, String title, Map<String, dynamic> args) {
    return TextButton(
      onPressed: () {
        Get.toNamed(route, arguments: args);
      },
      child: Text(title),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Route"),
        centerTitle: true,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          linkToRoute('/'),
          linkToRoute('/login'),
          linkToRoute('/profile'),
          linkToRoute('/license'),
          linkToRoute('/expiration_date'),
          linkToRoute('/expiration_date/capture'),
          linkToRoute('/expiration_date/list'),
          linkToRoute('/short_mall'),
        ],
      ),
    );
  }
}
