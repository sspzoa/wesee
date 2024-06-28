import 'package:wesee/app/screens/test/controller.dart';
import 'package:get/get.dart';

class TestBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TestController());
  }
}
