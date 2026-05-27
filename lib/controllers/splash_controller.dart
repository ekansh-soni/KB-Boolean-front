import 'dart:async';

import 'package:get/get.dart';
import 'package:kb_boolean/routes/app_routes.dart';

class SplashController  extends GetxController{
  void sendToNextScreen(){
    Timer(Duration(seconds: 3),(){
      Get.offAndToNamed(AppRoutes.dashBoardScreen);
    });
  }

  @override
  void onInit() {
    sendToNextScreen();
    super.onInit();
  }
}