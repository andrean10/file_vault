import 'package:file_vault/app/modules/pin/controllers/pin_controller.dart';
import 'package:file_vault/app/modules/pin/views/widgets/builder_pin_header.dart';
import 'package:file_vault/app/widgets/buttons/custom_filled_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/builder_pin_circular.dart';
import 'widgets/builder_pin_digit_button.dart';

class RegisterPinView extends GetView<PinController> {
  const RegisterPinView({super.key});

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
                title: 'Buat PIN',
                subtitle: 'Masukkan 4 digit PIN Baru',
              ),
            ),
            const Flexible(child: BuilderPinCircular()),
            const Expanded(
              flex: 2,
              child: BuilderPinDigitButton(),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Flexible(
                child: Obx(
                  () => CustomFilledButton(
                    width: double.infinity,
                    onPressed: controller.confirmNewPin,
                    isFilledTonal: false,
                    isActive: controller.pin.length == 4,
                    child: const Text('Konfirmasi'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
