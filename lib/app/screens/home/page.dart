import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wesee/app/screens/home/controller.dart';
import 'package:wesee/app/screens/home/pages/homepage/controller.dart';
import 'package:wesee/app/screens/home/pages/homepage/page.dart';
import 'package:wesee/app/screens/home/pages/listpage/controller.dart';
import 'package:wesee/app/screens/home/pages/listpage/page.dart';
import 'package:wesee/app/screens/home/pages/mypage/controller.dart';
import 'package:wesee/app/screens/home/pages/mypage/page.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('위시'),
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller.pageController,
        onPageChanged: (index) {
          controller.currentIndex.value = index;
        },
        children: [
          GetBuilder<ListPageController>(
            init: ListPageController(),
            builder: (_) => const ListPage(),
          ),
          GetBuilder<HomePageController>(
            init: HomePageController(),
            builder: (_) => const HomePage(),
          ),
          GetBuilder<MyPageController>(
            init: MyPageController(),
            builder: (_) => const MyPage(),
          ),
        ],
      ),
      bottomNavigationBar: Obx(
            () => BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: (index) {
            controller.changePage(index);
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.feed),
              label: '리스트',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '홈',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: '마이페이지',
            ),
          ],
        ),
      ),
    );
  }
}