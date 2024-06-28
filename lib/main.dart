import 'package:wesee/app/core/theme/dark.dart';
import 'package:wesee/app/core/theme/light.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/core/utils/loader.dart';
import 'app/routes/pages.dart';
import 'app/routes/routes.dart';

String getInintialRoute({bool debug = false}) {
  return debug ? Routes.TEST : Routes.HOME;
}

Future<void> main() async {
  await AppLoader().load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: '위시',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: WeseeLightThemeColors().primaryBrand),
        useMaterial3: true,
        brightness: Brightness.light,
        fontFamily: 'SUITv1',
        extensions: [
          WeseeLightThemeColors(),
          WeseeLightThemeTypography(),
        ],
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        extensions: [
          WeseeDarkThemeColors(),
          WeseeDarkThemeTypography(),
        ],
      ),
      initialRoute: getInintialRoute(debug: !kReleaseMode),
      getPages: AppPages.pages,
    );
  }
}