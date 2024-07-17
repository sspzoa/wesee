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
        automaticallyImplyLeading: false,
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '안녕하세요, ',
                style: textTheme.header1.copyWith(color: colorTheme.grayscale900),
              ),
              TextSpan(
                text: '${controller.fullName!}',
                style: textTheme.header1.copyWith(
                  color: colorTheme.primaryBrand,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: '님',
                style: textTheme.header1.copyWith(color: colorTheme.grayscale900),
              ),
            ],
          ),
        ),
        toolbarHeight: 100,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCard(
              context,
              title: '숏몰',
              icon: Icons.storefront,
              items: const ['햇반 (보리)', '계란 두 개', '천하장사 소시지'],
              onTap: () => {},
            ),
            const SizedBox(height: 16),
            _buildCard(
              context,
              title: '소비기한',
              icon: Icons.kitchen_rounded,
              items: const ['계란 D-90', '계란 D-90', '계란 D-90'],
              onTap: () => Get.toNamed(Routes.EXPIRATION_DATE),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(
      BuildContext context, {
        required String title,
        required IconData icon,
        required List<String> items,
        required VoidCallback onTap,
      }) {
    final colorTheme = Theme.of(context).extension<WeseeColors>()!;
    final textTheme = Theme.of(context).extension<WeseeTypography>()!;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 240,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        decoration: BoxDecoration(
          color: colorTheme.grayscale100,
          border: Border.all(color: colorTheme.grayscale300),
          borderRadius: BorderRadius.circular(16),
        ),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: textTheme.header1.copyWith(color: colorTheme.grayscale900),
                    ),
                    const SizedBox(height: 12),
                    Icon(
                      icon,
                      color: colorTheme.primaryBrand,
                      size: 48,
                    )
                  ],
                ),
              ),
              VerticalDivider(
                width: 48,
                thickness: 1,
                color: colorTheme.grayscale300,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: colorTheme.grayscale200,
                        border: Border.all(color: colorTheme.grayscale300),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        title == '숏몰' ? '도착 정보' : '내 소비기한',
                        style: textTheme.itemTitle.copyWith(color: colorTheme.grayscale600),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ...items.map((item) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        item,
                        style: textTheme.itemDescription.copyWith(color: colorTheme.grayscale900),
                      ),
                    )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}