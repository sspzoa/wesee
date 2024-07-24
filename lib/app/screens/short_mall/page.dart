import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wesee/app/core/theme/wesee_colors.dart';
import 'package:wesee/app/core/theme/wesee_typography.dart';
import 'package:wesee/app/screens/short_mall/controller.dart';

class ShortMallScreen extends GetView<ShortMallController> {
  const ShortMallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).extension<WeseeColors>()!;
    final textTheme = Theme.of(context).extension<WeseeTypography>()!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '숏몰',
          style: textTheme.header1.copyWith(color: colorTheme.grayscale900),
        ),
        toolbarHeight: 100,
      ),
      body: Column(
        children: [
          SearchBar(controller: controller),
        ],
      ),
    );
  }
}



class SearchBar extends StatelessWidget {
  final ShortMallController controller;

  const SearchBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).extension<WeseeColors>()!;
    final textTheme = Theme.of(context).extension<WeseeTypography>()!;

    return Obx(() => GestureDetector(
      onTapDown: (_) => controller.startListening(),
      onTapUp: (_) => controller.stopListening(),
      onTapCancel: () => controller.stopListening(),
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          color: controller.isListening.value
              ? colorTheme.primaryBrand
              : colorTheme.grayscale100,
          border: Border.all(color: colorTheme.primaryBrand),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                controller.searchText.value.isEmpty
                    ? '탭해서 음성으로 검색'
                    : controller.searchText.value,
                style: textTheme.itemTitle.copyWith(
                  color: controller.isListening.value
                      ? Colors.white
                      : controller.searchText.value.isEmpty
                      ? colorTheme.grayscale600
                      : colorTheme.grayscale900,
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                controller.isListening.value ? Icons.mic : Icons.search,
                color: controller.isListening.value
                    ? Colors.white
                    : colorTheme.grayscale600,
              ),
              onPressed: controller.isListening.value
                  ? null
                  : controller.performSearch,
            ),
          ],
        ),
      ),
    ));
  }
}