import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wesee/app/models/models.dart';
import 'package:wesee/app/services/supabase_service.dart';

final supabase = Supabase.instance.client;

class HomeController extends GetxController {
  final user = supabase.auth.currentUser;
  String? get fullName => user?.userMetadata?['full_name'];
  final isLoadingTopItems = false.obs;

  final SupabaseService _supabaseService = Get.find<SupabaseService>();
  final itemList = <ExpirationDateItem>[].obs;
  final isLoading = false.obs;
  final errorMessage = RxString('');
  final currentUser = Rxn<User>();
  final topThreeExpirationItems = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    refreshData();
  }

  Future<void> refreshData() async {
    await fetchItems();
    await updateTopThreeExpirationItems();
  }

  Future<void> fetchItems() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final items = await _supabaseService.getExpirationDateItems();
      itemList.assignAll(items.map((item) => ExpirationDateItem.fromJson(item)));
    } catch (e) {
      errorMessage.value = '피드 항목을 가져오는 중 오류가 발생했습니다: $e';
    } finally {
      isLoading.value = false;
    }
  }

  int getDaysRemaining(String expirationDate) {
    final difference = DateTime.parse(expirationDate).difference(DateTime.now());
    return difference.inDays;
  }

  String getDaysRemainingText(String expirationDate) {
    final difference = DateTime.parse(expirationDate).difference(DateTime.now());
    final daysRemaining = difference.inDays;

    if (daysRemaining < 0) {
      return 'D+${-daysRemaining}';
    } else if (daysRemaining == 0) {
      return 'D-DAY';
    } else {
      return 'D-$daysRemaining';
    }
  }

  Future<void> updateTopThreeExpirationItems() async {
    isLoadingTopItems.value = true;
    try {
      if (itemList.isEmpty) {
        topThreeExpirationItems.value = [];
      } else {
        final sortedItems = itemList.toList()
          ..sort((a, b) => getDaysRemaining(a.expirationDate).compareTo(getDaysRemaining(b.expirationDate)));

        topThreeExpirationItems.value = sortedItems.take(3).map((item) {
          final daysText = getDaysRemainingText(item.expirationDate);
          return '${item.name} $daysText';
        }).toList();
      }
    } finally {
      isLoadingTopItems.value = false;
    }
  }
}