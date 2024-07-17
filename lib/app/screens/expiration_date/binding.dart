import 'package:get/get.dart';
import 'package:wesee/app/screens/expiration_date/controller.dart';

class ExpirationDateBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ExpirationDateController());
  }
}
