import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class HomeController extends GetxController {
  final user = supabase.auth.currentUser;
  String? get fullName => user?.userMetadata?['full_name'];
}