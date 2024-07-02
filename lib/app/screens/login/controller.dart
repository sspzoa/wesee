import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wesee/app/routes/routes.dart';
import 'package:wesee/app/services/supabase_service.dart';

class LoginController extends GetxController {
  final SupabaseService supabaseService = Get.find<SupabaseService>();

  @override
  void onInit() {
    _setupAuthListener();
    super.onInit();
  }

  void _setupAuthListener() {
    supabaseService.onAuthStateChange.listen((data) {
      final event = data.event;
      if (event == AuthChangeEvent.signedIn) {
        Get.offAllNamed(Routes.HOME);
      }
    });
  }

  Future<AuthResponse> googleSignInNative() async {
    final webClientId = dotenv.get('GOOGLE_WEB_CLIENT_ID');
    final iosClientId = dotenv.get('GOOGLE_IOS_CLIENT_ID');

    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: iosClientId,
      serverClientId: webClientId,
    );
    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null) {
      throw 'No Access Token found.';
    }
    if (idToken == null) {
      throw 'No ID Token found.';
    }

    return supabaseService.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );
  }

  Future googleSignInWeb() async {
    supabaseService.signInWithOAuth('google');
  }
}