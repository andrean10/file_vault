import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/pin_controller.dart';
import 'widgets/builder_pin_circular.dart';
import 'widgets/builder_pin_digit_button.dart';
import 'widgets/builder_pin_header.dart';

class PinView extends GetView<PinController> {
  const PinView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 21,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Flexible(
              child: BuilderPinHeader(
                title: 'Masukkan PIN',
                subtitle: 'Masukkan 4 digit PIN anda',
              ),
            ),
            Flexible(
              child: Obx(
                () => BuilderPinCircular(
                  isError: !controller.isMatched.value,
                ),
              ),
            ),
            const Expanded(
              flex: 2,
              child: BuilderPinDigitButton(),
            ),
          ],
        ),
      ),
    );
  }
}
