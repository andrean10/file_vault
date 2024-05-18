import 'package:auto_size_text/auto_size_text.dart';
import 'package:file_vault/app/modules/pin/controllers/pin_controller.dart';
import 'package:file_vault/app/widgets/buttons/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PinDigitButton extends GetView<PinController> {
  final int? digit;

  const PinDigitButton({this.digit, super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final textTheme = context.textTheme;
    const size = 6;

    if (digit == null) {
      return SizedBox(
        width: width / size,
        height: width / size,
      );
    }

    return CustomElevatedButton(
      width: width / size,
      height: width / size,
      onPressed: () => controller.addDigit(digit!),
      child: AutoSizeText(
        '$digit',
        style: textTheme.headlineMedium?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
