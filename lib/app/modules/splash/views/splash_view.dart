import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import '../../../../utils/constants_asset_image.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    MediaQuery.sizeOf(context);

    return Scaffold(
      body: Image.asset(
        ConstantsAssetImage.logo,
        alignment: Alignment.center,
        fit: BoxFit.fitHeight,
        width: double.infinity,
        height: double.infinity,
      ).animate().fadeIn(duration: 2000.ms),
      // body: Center(
      //     child: Column(
      //   mainAxisSize: MainAxisSize.min,
      //   children: [
      //     Hero(
      //       tag: 'splash_logo',
      //       child: Image.asset(
      //         ConstantsAssetImage.logo,
      //         width: size.width * 0.5,
      //       ),
      //     ),
      //     const Gap(42),
      //     AutoSizeText(
      //       ConstantsValues.appName,
      //       style: textTheme.titleLarge,
      //       maxFontSize: 32,
      //     ),
      //   ],
      // )
      //     // .animate().fadeIn(duration: 2000.ms),
      //     ),
    );
  }
}
