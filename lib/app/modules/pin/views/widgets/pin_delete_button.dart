import 'package:file_vault/app/modules/pin/controllers/pin_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PinDeleteButton extends GetView<PinController> {
  const PinDeleteButton({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    const size = 6;

    return SizedBox(
      width: width / size,
      height: width / size,
      child: IconButton(
        onPressed: () => controller.removeDigit(),
        icon: const Icon(Icons.backspace_rounded),
      ),
    );
  }
}
