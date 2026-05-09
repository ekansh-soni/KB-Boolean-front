import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kb_boolean/controllers/splash_controller.dart';
import 'package:kb_boolean/widgets/custom_text_widget.dart';

class SplashScreen extends StatelessWidget {
    SplashScreen({super.key});

  final controller = Get.put( SplashController());
  @override
  Widget build(BuildContext context) {
    controller.sendToNextScreen();
    return Scaffold(
      body: Column(
        mainAxisAlignment: .center,
        children: [
          Center(child:  CustomTextWidget(text: "Splash Screens"),)
        ],
      ),
    );
  }
}
