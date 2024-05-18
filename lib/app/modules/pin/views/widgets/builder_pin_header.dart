import 'package:auto_size_text/auto_size_text.dart';
import 'package:file_vault/app/modules/pin/controllers/pin_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class BuilderPinHeader extends GetView<PinController> {
  final String title;
  final String subtitle;

  const BuilderPinHeader({
    required this.title,
    required this.subtitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton.filledTonal(
          onPressed: () {},
          icon: const Icon(Icons.lock_rounded),
          iconSize: 52,
          padding: const EdgeInsets.all(16.0),
          highlightColor: Colors.transparent,
        ),
        const Gap(32),
        AutoSizeText(
          title,
          style: textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
          minFontSize: textTheme.headlineMedium?.fontSize ?? 12,
        ),
        const Gap(4),
        AutoSizeText(
          subtitle,
          style: textTheme.bodyMedium,
        ),
      ],
    );
  }
}
