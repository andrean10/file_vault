import 'package:file_vault/app/modules/pin/controllers/pin_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'pin_delete_button.dart';
import 'pin_digit_button.dart';

class BuilderPinDigitButton extends GetView<PinController> {
  const BuilderPinDigitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            PinDigitButton(digit: 1),
            PinDigitButton(digit: 2),
            PinDigitButton(digit: 3),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            PinDigitButton(digit: 4),
            PinDigitButton(digit: 5),
            PinDigitButton(digit: 6),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            PinDigitButton(digit: 7),
            PinDigitButton(digit: 8),
            PinDigitButton(digit: 9),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            PinDigitButton(),
            PinDigitButton(digit: 0),
            PinDeleteButton(),
          ],
        ),
      ],
    );
  }
}
