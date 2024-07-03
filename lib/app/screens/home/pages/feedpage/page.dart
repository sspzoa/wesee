import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wesee/app/core/theme/wesee_colors.dart';
import 'package:wesee/app/core/theme/wesee_typography.dart';
import 'package:wesee/app/models/models.dart';
import 'package:wesee/app/screens/home/pages/feedpage/controller.dart';

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
          ));
        }
        return _buildFeedList(context, textTheme, colorTheme);
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddPostDialog(context, colorTheme, textTheme),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildFeedList(BuildContext context, WeseeTypography textTheme, WeseeColors colorTheme) {
    return RefreshIndicator(
      onRefresh: controller.fetchFeedItems,
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
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '작성자: ${item.authorName}',
            ),
            Text(
              controller.getRelativeTime(item.createdAt),
            ),
          ],
        ),
        trailing: controller.currentUser.value?.id == item.authorId
            ? IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => _showDeleteConfirmDialog(
                    context, item.id, textTheme, colorTheme),
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
        title: const Text('게시물 삭제'),
        content: const Text('이 게시물을 삭제하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              controller.deleteFeedItem(itemId);
              Navigator.of(context).pop();
            },
            child: const Text('삭제'),
          ),
        ],
      ),
    );
  }

  void _showPostDetailDialog(BuildContext context, FeedItem item, WeseeTypography textTheme, WeseeColors colorTheme) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(item.title),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(item.content),
              const SizedBox(height: 16),
              Text(
                '작성자: ${item.authorName}',
              ),
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

  void _showAddPostDialog(BuildContext context, WeseeColors colorTheme, WeseeTypography textTheme) {
    final titleController = TextEditingController();
    final contentController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('새 게시물 작성'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: '제목',
              ),
            ),
            TextField(
              controller: contentController,
              decoration: const InputDecoration(
                labelText: '내용',
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              controller.addFeedItem(titleController.text, contentController.text);
              Navigator.of(context).pop();
            },
            child: const Text(
              '게시',
            ),
          ),
        ],
      ),
    );
  }
}