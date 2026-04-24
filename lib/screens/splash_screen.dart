import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kb_boolean/controllers/splash_controller.dart';
import 'package:kb_boolean/widgets/custom_text_widget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder(
        init: SplashController(),
        builder: (controller) {
          return Column(
            mainAxisAlignment: .center,
            children: [
              Center(child:  CustomTextWidget(text: "Splash Screen"),)
            ],
          );
        },
      ),
    );
  }
}
