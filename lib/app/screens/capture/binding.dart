import 'package:wesee/app/screens/capture/controller.dart';
import 'package:get/get.dart';

class CaptureBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CaptureController());
  }
}
