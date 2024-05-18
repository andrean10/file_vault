import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../routes/app_pages.dart';
import '../../init/controllers/init_controller.dart';

class SplashController extends GetxController {
  late final InitController _initC;

  final logger = Logger();

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  void _init() {
    if (Get.isRegistered<InitController>()) {
      _initC = Get.find<InitController>();
    }
  }

  @override
  void onReady() {
    super.onReady();
    Future.delayed(4000.ms, () {
      if (!_initC.initialized) return;

      logger.d('debug: pin = ${_initC.getPin()}');

      if (_initC.isUserFirstUsingApplication()) {
        _moveToRegisterPin();
      } else {
        _moveToPin();
      }
    });
  }

  void _moveToRegisterPin() => Get.offAllNamed(Routes.REGISTER_PIN);

  void _moveToPin() => Get.offAllNamed(Routes.PIN);
}
