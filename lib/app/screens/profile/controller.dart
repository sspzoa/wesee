import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wesee/app/routes/routes.dart';

final supabase = Supabase.instance.client;

class ProfileController extends GetxController {
  final user = supabase.auth.currentUser;
  String? get profileImageUrl => user?.userMetadata?['avatar_url'];
  String? get fullName => user?.userMetadata?['full_name'];

  Future<void> signOut() async {
    await supabase.auth.signOut();
    Get.offAllNamed(Routes.HOME);
  }
}
