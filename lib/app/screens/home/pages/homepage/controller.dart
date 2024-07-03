import 'package:get/get.dart';
import 'package:wesee/app/routes/routes.dart';

class HomePageController extends GetxController {
  void startCamera() {
    Get.toNamed(Routes.CAPTURE);
  }
}