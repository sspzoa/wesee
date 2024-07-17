import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wesee/app/core/theme/wesee_colors.dart';
import 'package:wesee/app/core/theme/wesee_typography.dart';
import 'package:wesee/app/models/models.dart';
import 'package:wesee/app/screens/expiration_date/list/controller.dart';

class ListScreen extends GetView<ListController> {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).extension<WeseeColors>()!;
    final textTheme = Theme.of(context).extension<WeseeTypography>()!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('List'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator(color: colorTheme.primaryBrand));
        }
        if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        }
        return _buildItemList(context, textTheme, colorTheme);
      }),
    );
  }

  Widget _buildItemList(
      BuildContext context, WeseeTypography textTheme, WeseeColors colorTheme) {
    final userItems = controller.getUserItems();

    return RefreshIndicator(
      onRefresh: controller.fetchItems,
      child: userItems.isEmpty
          ? const Center(child: Text('등록된 상품이 없습니다.'))
          : ListView.builder(
              itemCount: userItems.length,
              itemBuilder: (context, index) {
                final item = userItems[index];
                return _buildItem(context, item, textTheme, colorTheme);
              },
            ),
    );
  }

  Widget _buildItem(BuildContext context, expirationDateItem item, WeseeTypography textTheme,
      WeseeColors colorTheme) {
    final daysRemaining = controller.getDaysRemaining(item.expirationDate);

    return GestureDetector(
      onTap: () => _showPostDetailDialog(context, item, textTheme, colorTheme),
      onLongPress: () => _showDeleteConfirmDialog(context, item.id),
      child: Card(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        child: Container(
          height: 80,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: textTheme.header2
                        .copyWith(color: colorTheme.grayscale800),
                  ),
                  const Spacer(),
                  Text(
                    controller.getRelativeTime(item.createdAt),
                    style: textTheme.itemDescription,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(item.expirationDate, style: textTheme.itemDescription),
                  const Spacer(),
                  Text('D-$daysRemaining',
                      style: textTheme.title
                          .copyWith(color: colorTheme.primaryBrand)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showPostDetailDialog(BuildContext context, expirationDateItem item,
      WeseeTypography textTheme, WeseeColors colorTheme) {
    final daysRemaining =
        DateTime.now().difference(DateTime.parse(item.expirationDate)).inDays;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          item.name,
          style: textTheme.header2.copyWith(color: colorTheme.grayscale800),
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(item.expirationDate, style: textTheme.itemDescription),
            Text('D-${daysRemaining.abs()}',
                style:
                    textTheme.title.copyWith(color: colorTheme.primaryBrand)),
          ],
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                controller.getRelativeTime(item.createdAt),
                style: textTheme.itemDescription,
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('닫기'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmDialog(BuildContext context, int itemId) {
    Get.dialog(
      AlertDialog(
        title: const Text('항목 삭제'),
        content: const Text('이 항목을 삭제하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              controller.deleteItem(itemId);
              Get.back();
            },
            child: const Text('삭제'),
          ),
        ],
      ),
    );
  }
}