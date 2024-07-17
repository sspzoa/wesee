import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wesee/app/models/models.dart';
import 'package:wesee/app/services/supabase_service.dart';

class ExpirationDateController extends GetxController {
  final SupabaseService _supabaseService = Get.find<SupabaseService>();
  final itemList = <ExpirationDateItem>[].obs;
  final isLoading = false.obs;
  final errorMessage = RxString('');
  final currentUser = Rxn<User>();

  @override
  void onInit() {
    super.onInit();
    fetchItems();
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
      return '${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}';
    }
  }

  Future<void> fetchItems() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final items = await _supabaseService.getItems();
      itemList.assignAll(items.map((item) => ExpirationDateItem.fromJson(item)));
    } catch (e) {
      errorMessage.value = '피드 항목을 가져오는 중 오류가 발생했습니다: $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteItem(int itemId) async {
    try {
      await _supabaseService.deleteItem(itemId);
      await fetchItems();
    } catch (e) {
      errorMessage.value = '게시물 삭제 중 오류가 발생했습니다: $e';
    }
  }

  List<ExpirationDateItem> getUserItems() {
    return itemList.where((item) => currentUser.value?.id == item.authorId).toList();
  }

  int getDaysRemaining(String expirationDate) {
    return DateTime.now().difference(DateTime.parse(expirationDate)).inDays.abs();
  }
}