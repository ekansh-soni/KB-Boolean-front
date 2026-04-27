import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kb_boolean/services/socket_service.dart';
import 'package:kb_boolean/utils/utils.dart';
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
        crossAxisAlignment: .start,
        children: [

          Obx(() {
            if(socket.comexList.isEmpty){
              return spaceHeight(0);
            }

            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 1.h/1.2.w, crossAxisSpacing: 10.w  ),
              itemCount: socket.comexList.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                var comexList = socket.comexList[index];
                return CustomCardContainer(
                  padding: .all(6.sp),
                    child: Column(
                      children: [
                        CustomTextWidget(text: comexList.symbol),
                        spaceHeight(5.h),

                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: getTickColor(comexList.symbol ?? '', comexList.ltp),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: CustomTextWidget(
                            text:  comexList.ltp ?? '-',
                            fontSize: 12.sp,
                          ),
                        ),

                        spaceHeight(5.h),
                        Row(
                          crossAxisAlignment: .center,
                          mainAxisAlignment: .center,
                          children: [
                            CustomTextWidget(text: comexList.low, fontSize: 10.sp,),
                            spaceWidth(5.w),
                            CustomTextWidget(text: "|", fontSize: 10.sp,),
                            spaceWidth(5.w),
                            CustomTextWidget(text: comexList.high, fontSize: 10.sp,),
                          ],
                        )
                      ],
                    ));
              },
            );

          },),



          Obx(() => ListView.builder(
            itemCount: socket.webSocketResponseBean.value?.rates?.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              var rates = socket.webSocketResponseBean.value?.rates?[index];
              return CustomCardContainer(child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        CustomTextWidget(text: rates?.symbol ?? "", fontSize: 14.sp, fontWeight: FontWeight.w600,),
                        CustomTextWidget(text: rates?.time ?? "", fontSize: 10.sp, fontWeight: FontWeight.w400,),
                      ],
                    ),
                  ),
                ],
              ));
            },
          ),),


          CustomTextWidget(text: "Future Rate", fontSize: 16.sp, fontWeight: FontWeight.w600,),
          spaceHeight(6.h),
          Obx(() => ListView.builder(
            itemCount: socket.futureList.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              var rates = socket.futureList[index];
              return CustomCardContainer(child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        CustomTextWidget(text: rates.symbol ?? "", fontSize: 14.sp, fontWeight: FontWeight.w600,),
                        CustomTextWidget(text: rates.time ?? "", fontSize: 10.sp, fontWeight: FontWeight.w400,),
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
