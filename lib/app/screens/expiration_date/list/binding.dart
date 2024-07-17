import 'package:get/get.dart';
import 'package:wesee/app/screens/expiration_date/list/controller.dart';

class ListBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ListController());
  }
}
