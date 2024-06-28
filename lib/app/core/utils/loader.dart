import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_strategy/url_strategy.dart';

final supabase = Supabase.instance.client;

class AppLoader {
  Future<void> load() async {
    WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

    await dotenv.load(fileName: ".env");
    setPathUrlStrategy();

    await Supabase.initialize(
      url: dotenv.get('SUPABASE_URL'),
      anonKey: dotenv.get('SUPABASE_ANON_KEY'),
    );

    if (!kIsWeb) {
      if (Platform.isAndroid) {
        await FlutterDisplayMode.setHighRefreshRate();
      }
    }
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    FlutterNativeSplash.remove();
  }
}
