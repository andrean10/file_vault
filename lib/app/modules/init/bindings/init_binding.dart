import 'package:file_vault/app/modules/init/controllers/init_controller.dart';
import 'package:get/get.dart';

class InitBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<InitController>(
      InitController(),
      permanent: true,
    );
  }
}
