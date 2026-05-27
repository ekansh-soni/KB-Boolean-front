import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kb_boolean/controllers/splash_controller.dart';
import 'package:kb_boolean/utils/app_images.dart';
import 'package:kb_boolean/widgets/custom_text_widget.dart';

import '../theme/app_colors.dart';

class SplashScreen extends StatelessWidget {
    SplashScreen({super.key});

  final controller = Get.put( SplashController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Column(
        mainAxisAlignment: .center,
        children: [
          Image.asset(AppImages.icIcon)
        ],
      ),
    );
  }
}
