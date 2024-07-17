import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wesee/app/core/theme/wesee_colors.dart';
import 'package:wesee/app/core/theme/wesee_typography.dart';
import 'package:wesee/app/models/models.dart';
import 'package:wesee/app/routes/routes.dart';
import 'package:wesee/app/screens/expiration_date/controller.dart';

class ExpirationDateScreen extends GetView<ExpirationDateController> {
  const ExpirationDateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).extension<WeseeColors>()!;
    final textTheme = Theme.of(context).extension<WeseeTypography>()!;

    return Scaffold(
      appBar: AppBar(
            title: Text('소비기한',
                style: textTheme.header1.copyWith(color: colorTheme.grayscale900)
            ),
      ),
        body: Obx(() {
          if (controller.isLoading.value) {
            return Center(
                child:
                    CircularProgressIndicator(color: colorTheme.primaryBrand));
          }
          if (controller.errorMessage.isNotEmpty) {
            return Center(child: Text(controller.errorMessage.value));
          }
          return _buildItemList(context, textTheme, colorTheme);
        }),
        floatingActionButton: FloatingActionButton(
          backgroundColor: colorTheme.primaryBrand,
          onPressed: () => Get.toNamed(Routes.CAPTURE),
          child: Icon(
            Icons.add,
            color: colorTheme.grayscale100,
          ),
        ));
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

  Widget _buildItem(BuildContext context, expirationDateItem item,
      WeseeTypography textTheme, WeseeColors colorTheme) {
    final daysRemaining = controller.getDaysRemaining(item.expirationDate);

    return GestureDetector(
      onTap: () => {},
      onLongPress: () => _showDeleteConfirmDialog(context, item.id),
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        decoration: BoxDecoration(
          color: colorTheme.grayscale100,
          border: Border.all(color: colorTheme.grayscale300),
          borderRadius: BorderRadius.circular(16),
        ),
        child: SizedBox(
          height: 65,
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