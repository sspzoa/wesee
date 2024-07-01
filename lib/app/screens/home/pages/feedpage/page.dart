import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wesee/app/core/theme/wesee_colors.dart';
import 'package:wesee/app/core/theme/wesee_typography.dart';
import 'package:wesee/app/screens/home/pages/feedpage/controller.dart';
import 'package:wesee/app/models/models.dart';

class FeedPage extends GetView<FeedPageController> {
  const FeedPage({super.key});

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
            style: textTheme.description.copyWith(color: colorTheme.primaryBrand),
          ));
        }
        return _buildFeedList(context, textTheme, colorTheme);
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddPostDialog(context, colorTheme, textTheme),
        backgroundColor: colorTheme.primaryBrand,
        child: Icon(Icons.add, color: colorTheme.grayscale100),
      ),
    );
  }

  Widget _buildFeedList(BuildContext context, WeseeTypography textTheme, WeseeColors colorTheme) {
    return RefreshIndicator(
      onRefresh: controller.fetchFeedItems,
      color: colorTheme.primaryBrand,
      child: ListView.builder(
        itemCount: controller.feedItems.length,
        itemBuilder: (context, index) {
          final item = controller.feedItems[index];
          return _buildFeedItem(context, item, textTheme, colorTheme);
        },
      ),
    );
  }

  Widget _buildFeedItem(BuildContext context, FeedItem item, WeseeTypography textTheme, WeseeColors colorTheme) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(
          item.title,
          style: textTheme.itemTitle.copyWith(color: colorTheme.primaryBrand),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '작성자: ${item.authorName}',
              style: textTheme.itemDescription.copyWith(color: colorTheme.primaryBrand),
            ),
            Text(
              controller.getRelativeTime(item.createdAt),
              style: textTheme.token.copyWith(color: colorTheme.primaryBrand),
            ),
          ],
        ),
        trailing: controller.currentUser.value?.id == item.authorId
            ? IconButton(
          icon: Icon(Icons.delete, color: colorTheme.primaryBrand),
          onPressed: () => _showDeleteConfirmDialog(context, item.id, textTheme, colorTheme),
        )
            : null,
        onTap: () => _showPostDetailDialog(context, item, textTheme, colorTheme),
      ),
    );
  }

  void _showDeleteConfirmDialog(BuildContext context, int itemId, WeseeTypography textTheme, WeseeColors colorTheme) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('게시물 삭제', style: textTheme.header2.copyWith(color: colorTheme.primaryBrand)),
        content: Text('이 게시물을 삭제하시겠습니까?', style: textTheme.paragraph1.copyWith(color: colorTheme.primaryBrand)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('취소', style: textTheme.paragraph2.copyWith(color: colorTheme.primaryBrand)),
          ),
          TextButton(
            onPressed: () {
              controller.deleteFeedItem(itemId);
              Navigator.of(context).pop();
            },
            child: Text('삭제', style: textTheme.paragraph2.copyWith(color: colorTheme.primaryBrand)),
          ),
        ],
      ),
    );
  }

  void _showPostDetailDialog(BuildContext context, FeedItem item, WeseeTypography textTheme, WeseeColors colorTheme) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(item.title, style: textTheme.header1.copyWith(color: colorTheme.primaryBrand)),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(item.content, style: textTheme.paragraph1.copyWith(color: colorTheme.primaryBrand)),
              const SizedBox(height: 16),
              Text('작성자: ${item.authorName}', style: textTheme.readable.copyWith(color: colorTheme.primaryBrand)),
              Text(controller.getRelativeTime(item.createdAt), style: textTheme.token.copyWith(color: colorTheme.primaryBrand)),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('닫기', style: textTheme.paragraph2.copyWith(color: colorTheme.primaryBrand)),
          ),
        ],
      ),
    );
  }

  void _showAddPostDialog(BuildContext context, WeseeColors colorTheme, WeseeTypography textTheme) {
    final titleController = TextEditingController();
    final contentController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('새 게시물 작성', style: textTheme.header2.copyWith(color: colorTheme.primaryBrand)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: '제목',
                labelStyle: textTheme.readable.copyWith(color: colorTheme.primaryBrand),
              ),
            ),
            TextField(
              controller: contentController,
              decoration: InputDecoration(
                labelText: '내용',
                labelStyle: textTheme.readable.copyWith(color: colorTheme.primaryBrand),
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('취소', style: textTheme.paragraph2.copyWith(color: colorTheme.primaryBrand)),
          ),
          TextButton(
            onPressed: () {
              controller.addFeedItem(titleController.text, contentController.text);
              Navigator.of(context).pop();
            },
            child: Text(
              '게시',
              style: textTheme.paragraph2.copyWith(color: colorTheme.primaryBrand),
            ),
          ),
        ],
      ),
    );
  }
}