import 'package:get/get.dart';
import 'package:wesee/app/screens/short_mall/controller.dart';

class ShortMallBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ShortMallController());
  }
}
