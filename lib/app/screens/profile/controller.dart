import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wesee/app/routes/routes.dart';
import 'package:google_sign_in/google_sign_in.dart';

final supabase = Supabase.instance.client;
final GoogleSignIn _googleSignIn = GoogleSignIn();

class ProfileController extends GetxController {
  final user = supabase.auth.currentUser;
  String? get profileImageUrl => user?.userMetadata?['avatar_url'];
  String? get fullName => user?.userMetadata?['full_name'];

  Future<void> signOut() async {
    await supabase.auth.signOut();
    await _googleSignIn.signOut();

    Get.offAllNamed(Routes.HOME);
  }
}