import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wesee/app/core/theme/wesee_colors.dart';
import 'package:wesee/app/core/theme/wesee_typography.dart';
import 'package:wesee/app/models/models.dart';
import 'package:wesee/app/screens/home/pages/listpage/controller.dart';

class ListPage extends GetView<ListPageController> {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).extension<WeseeColors>()!;
    final textTheme = Theme.of(context).extension<WeseeTypography>()!;

    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator(color: colorTheme.primaryBrand));
        }
        if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text(
            controller.errorMessage.value,
          ));
        }
        return _buildItemList(context, textTheme, colorTheme);
      }),
    );
  }

  Widget _buildItemList(
      BuildContext context, WeseeTypography textTheme, WeseeColors colorTheme) {
    final userItems = controller.itemList
        .where((item) => controller.currentUser.value?.id == item.authorId)
        .toList();

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

  Widget _buildItem(BuildContext context, Item item, WeseeTypography textTheme,
      WeseeColors colorTheme) {
    final daysRemaining =
        DateTime.now().difference(DateTime.parse(item.expirationDate)).inDays;

    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(
          item.name,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              controller.getRelativeTime(item.createdAt),
            ),
          ],
        ),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(item.expirationDate),
            Text('D-${daysRemaining.abs()}', style: textTheme.header1),
          ],
        ),
        onTap: () => _showPostDetailDialog(context, item, textTheme, colorTheme),
        onLongPress: () =>
            _showDeleteConfirmDialog(context, item.id, textTheme, colorTheme),
      ),
    );
  }

  void _showDeleteConfirmDialog(BuildContext context, int itemId, WeseeTypography textTheme, WeseeColors colorTheme) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('항목 삭제'),
        content: const Text('이 항목을 삭제하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              controller.deleteItem(itemId);
              Navigator.of(context).pop();
            },
            child: const Text('삭제'),
          ),
        ],
      ),
    );
  }

  void _showPostDetailDialog(BuildContext context, Item item,
      WeseeTypography textTheme, WeseeColors colorTheme) {
    final daysRemaining =
        DateTime.now().difference(DateTime.parse(item.expirationDate)).inDays;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(item.name),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(item.expirationDate),
              Text('D-${daysRemaining.abs()}', style: textTheme.header1),
              const SizedBox(height: 16),
              Text(controller.getRelativeTime(item.createdAt)),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('닫기'),
          ),
        ],
      ),
    );
  }
}