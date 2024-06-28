import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/route_middleware.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wesee/app/routes/routes.dart';

final supabase = Supabase.instance.client;

class LoginMiddleware extends GetMiddleware {
  LoginMiddleware({super.priority});

  @override
  RouteSettings? redirect(String? route) {
    final session = supabase.auth.currentSession;
    if (session == null) {
      return RouteSettings(name: Routes.LOGIN, arguments: {'redirect': route});
    }
    return null;
  }
}