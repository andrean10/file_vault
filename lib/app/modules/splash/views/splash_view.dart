import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import '../../../../utils/constants_asset_image.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16.0),
        alignment: Alignment.center,
        child: Image.asset(
          ConstantsAssetImage.logo,
          fit: BoxFit.cover,
          width: size.width / 2,
        ).animate().fadeIn(duration: 2000.ms),
      ),
    );
  }
}
