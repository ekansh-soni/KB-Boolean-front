import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../controllers/trade_view_controller.dart';
import '../../../widgets/custom_text_widget.dart';

class TradesView extends StatelessWidget {
  TradesView({super.key});
  final controller = Get.put(TradeViewController());

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: controller.controller,);
  }
}
