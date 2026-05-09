import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TradeViewController  extends GetxController{
  late final WebViewController controller;

  @override
  void onInit() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..loadRequest(
        Uri.parse(
          "https://www.tradays.com/en/economic-calendar/widget?mode=2&fw=html",
        ),
      );
    super.onInit();
  }
}