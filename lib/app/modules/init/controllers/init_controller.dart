import 'dart:typed_data';

import 'package:async/async.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';

class InitController extends GetxController {
  late final GetStorage _localStorage;

  final Map<String, AsyncMemoizer<Uint8List>> memoizerMap = {};

  final logger = Logger();

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  void _init() {
    _localStorage = GetStorage();
  }

  bool isUserFirstUsingApplication() => !_localStorage.hasData('pin');

  String? getPin() => _localStorage.read<String?>('pin');

  Future<void> setPin(String value) => _localStorage.write('pin', value);

  Future<void> resetPin() => _localStorage.remove('pin');
}
