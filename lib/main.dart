import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wesee/app/core/theme/dark.dart';
import 'package:wesee/app/core/theme/light.dart';
import 'package:wesee/app/core/utils/loader.dart';
import 'package:wesee/app/routes/pages.dart';
import 'package:wesee/app/routes/routes.dart';

void main() async {
  await AppLoader().load();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WeSee',
      theme: _buildTheme(true),
      darkTheme: _buildTheme(false),
      initialRoute: kReleaseMode ? Routes.HOME : Routes.TEST,
      getPages: AppPages.pages,
    );
  }

  ThemeData _buildTheme(bool isLight) {
    final colors = isLight ? WeseeLightThemeColors() : WeseeDarkThemeColors();
    final typography = isLight ? WeseeLightThemeTypography() : WeseeDarkThemeTypography();
    final brightness = isLight ? Brightness.light : Brightness.dark;

    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: colors.primaryBrand,
        brightness: brightness,
      ),
      useMaterial3: true,
      brightness: brightness,
      fontFamily: 'SUITv1',
      extensions: [colors, typography],
      scaffoldBackgroundColor: colors.grayscale200,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: isLight ? Brightness.dark : Brightness.light,
          statusBarBrightness: isLight ? Brightness.light : Brightness.dark,
        ),
      ),
    );
  }
}