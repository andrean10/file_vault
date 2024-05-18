import 'package:file_vault/app/modules/pin/controllers/pin_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PinCircular extends GetView<PinController> {
  final bool isActive;
  final bool isError;

  const PinCircular({
    this.isActive = false,
    this.isError = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final theme = context.theme;
    const size = 26;

    return Container(
      width: width / size,
      height: width / size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _checkState(theme),
      ),
    );
  }

  Color _checkState(ThemeData theme) {
    final colorScheme = theme.colorScheme;
    if (isError) {
      return colorScheme.error;
    } else if (isActive) {
      return colorScheme.primary;
    } else {
      return theme.disabledColor;
    }
  }
}
