import 'package:file_vault/app/modules/pin/controllers/pin_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import 'pin_circular.dart';

class BuilderPinCircular extends GetView<PinController> {
  final bool isError;

  const BuilderPinCircular({this.isError = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final lengthPin = controller.pin.length;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            PinCircular(
              isActive: lengthPin >= 1,
              isError: isError,
            ),
            PinCircular(
              isActive: lengthPin >= 2,
              isError: isError,
            ),
            PinCircular(
              isActive: lengthPin >= 3,
              isError: isError,
            ),
            PinCircular(
              isActive: lengthPin == 4,
              isError: isError,
            ),
          ],
        )
            .animate(
                onComplete: (ctr) {
                  ctr.reset();
                },
                target: isError ? 1 : 0)
            .shakeX(duration: 300.ms);
      },
    );
  }
}
