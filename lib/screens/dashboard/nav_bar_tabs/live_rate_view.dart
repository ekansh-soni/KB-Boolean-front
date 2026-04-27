import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kb_boolean/services/socket_service.dart';
import 'package:kb_boolean/widgets/custom_card_container.dart';
import 'package:kb_boolean/widgets/custom_text_widget.dart';

class LiveRateView extends StatelessWidget {
  LiveRateView({super.key});
  final socket = SocketService.to;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: .all(16.sp),
      child: Column(
        children: [
          Obx(() => ListView.builder(
            itemCount: socket.webSocketResponseBean.value?.rates?.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              var rates = socket.webSocketResponseBean.value?.rates?[index];
              return CustomCardContainer(child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        CustomTextWidget(text: rates?.symbol ?? ""),
                        CustomTextWidget(text: rates?.time ?? ""),
                      ],
                    ),
                  ),
                ],
              ));
            },
          ),)
        ],
      )
    );
  }
}
