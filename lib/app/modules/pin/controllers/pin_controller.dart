import 'package:file_vault/app/modules/init/controllers/init_controller.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../routes/app_pages.dart';

class PinController extends GetxController {
  late final InitController _initC;
  final pin = <int>[].obs;
  final isMatched = true.obs;

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

    ever(pin, (cb) {
      logger.i(cb.toString());
      if (cb.isNotEmpty && cb.length == 4) _checkPin();
    });
  }

  void addDigit(int digit) {
    if (pin.length < 4) {
      pin.add(digit);
    }
  }

  void removeDigit() {
    if (pin.isNotEmpty) {
      pin.removeLast();
      isMatched.value = true;
    }
  }

  void confirmNewPin() {
    if (!_initC.initialized) return;
    final newPin = pin.join();
    _initC.setPin(newPin).then((_) => _moveToPin());
  }

  void _checkPin() {
    if (!_initC.initialized) return;
    final currentPin = _initC.getPin();
    final inputPin = pin.join();

    if (currentPin == inputPin) {
      isMatched.value = true;
      _moveToMain();
    } else {
      isMatched.value = false;
    }
  }

  void _moveToPin() {
    pin.clear();
    Get.offAllNamed(Routes.PIN);
  }

  void _moveToMain() => Get.offAllNamed(Routes.MAIN);
}
