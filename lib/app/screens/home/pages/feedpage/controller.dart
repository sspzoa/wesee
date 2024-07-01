import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wesee/app/models/models.dart';
import 'package:wesee/app/services/supabase_service.dart';

class FeedPageController extends GetxController {
  final SupabaseService _supabaseService = Get.find<SupabaseService>();
  final feedItems = <FeedItem>[].obs;
  final isLoading = false.obs;
  final errorMessage = RxString('');
  final currentUser = Rxn<User>();

  @override
  void onInit() {
    super.onInit();
    fetchFeedItems();
    updateCurrentUser();
  }

  void updateCurrentUser() {
    currentUser.value = _supabaseService.getCurrentUser();
  }

  String getRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inSeconds < 60) {
      return '방금 전';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}분 전';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}시간 전';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}일 전';
    } else {
      return '${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    }
  }

  Future<void> fetchFeedItems() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final items = await _supabaseService.getFeedItems();
      feedItems.assignAll(items.map((item) => FeedItem.fromJson(item)));
    } catch (e) {
      errorMessage.value = '피드 항목을 가져오는 중 오류가 발생했습니다: $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addFeedItem(String title, String content) async {
    try {
      await _supabaseService.addFeedItem(title, content);
      await fetchFeedItems();
    } catch (e) {
      errorMessage.value = '게시물 추가 중 오류가 발생했습니다: $e';
    }
  }

  Future<void> deleteFeedItem(int itemId) async {
    try {
      await _supabaseService.deleteFeedItem(itemId);
      await fetchFeedItems();
    } catch (e) {
      errorMessage.value = '게시물 삭제 중 오류가 발생했습니다: $e';
    }
  }
}