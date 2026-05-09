import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kb_boolean/services/socket_service.dart';
import 'package:kb_boolean/theme/app_colors.dart';
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
            if (socket.comexList.isEmpty) {
              return spaceHeight(0);
            }

            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.h / 1.2.w,
                crossAxisSpacing: 10.w,
              ),
              itemCount: socket.comexList.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                var comexList = socket.comexList[index];
                return CustomCardContainer(
                  padding: .all(6.sp),
                  child: Column(
                    children: [

                      setComexName(comexList.symbol),
                      spaceHeight(5.h),

                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: getTickColor(
                            comexList.symbol ?? '',
                            comexList.ltp,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: CustomTextWidget(
                          text: comexList.ltp ?? '-',
                          fontSize: 12.sp,
                        ),
                      ),

                      spaceHeight(5.h),
                      Row(
                        crossAxisAlignment: .center,
                        mainAxisAlignment: .center,
                        children: [
                          CustomTextWidget(
                            text: comexList.low,
                            fontSize: 10.sp,
                          ),
                          spaceWidth(5.w),
                          CustomTextWidget(text: "|", fontSize: 10.sp),
                          spaceWidth(5.w),
                          CustomTextWidget(
                            text: comexList.high,
                            fontSize: 10.sp,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          }),

          CustomCardContainer(
            bgColor: AppColors.lightBaseColor,
            child: Row(
              children: [
                Expanded(
                  flex:2,
                  child: CustomTextWidget(
                    text:   "Rates",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Expanded(
                  child: CustomTextWidget(
                    text:  "Bid",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Expanded(
                  child: CustomTextWidget(
                    text: "Ask",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Expanded(
                  child: CustomTextWidget(
                    text: "H/L",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Obx(
            () => ListView.builder(
              itemCount: socket.webSocketResponseBean.value?.rates?.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                var rates = socket.webSocketResponseBean.value?.rates?[index];
                return CustomCardContainer(
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: .start,
                          children: [
                            CustomTextWidget(
                              text: rates?.symbol ?? "",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            CustomTextWidget(
                              text: rates?.time ?? "",
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          CustomCardContainer(
            bgColor: AppColors.lightBaseColor,
            child: Row(
              children: [
                Expanded(
                  flex:2,
                  child: CustomTextWidget(
                    text:   "Future Bid",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Expanded(
                  child: CustomTextWidget(
                    text:  "Bid",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Expanded(
                  child: CustomTextWidget(
                    text: "Ask",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Expanded(
                  child: CustomTextWidget(
                    text: "H/L",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          spaceHeight(6.h),
          Obx(
            () => ListView.builder(
              itemCount: socket.futureList.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                var rates = socket.futureList[index];
                return CustomCardContainer(
                  child: Row(
                    children: [
                      Expanded(
                        flex:2,
                        child: Column(
                          crossAxisAlignment: .start,
                          children: [
                            CustomTextWidget(
                              text: rates.symbol ?? "",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            CustomTextWidget(
                              text: rates.time ?? "",
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: CustomTextWidget(
                          text: rates.bid ?? "",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Expanded(
                        child: CustomTextWidget(
                          text: rates.ask ?? "",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            CustomTextWidget(
                              text: rates.high ?? "",
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w300,
                            ),
                            CustomTextWidget(
                              text: rates.low ?? "",
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w300,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget setComexName(String value){
    if(value.toLowerCase() == "xauusd"){
      return CustomTextWidget(text: "Gold Comex (\$)");
    }
    else if(value.toLowerCase() == "xagusd"){
      return CustomTextWidget(text: "Silver Comex");
    }
    else if(value.toLowerCase() == "inrspot"){
      return CustomTextWidget(text: "INR Spot");
    }

    return spaceHeight(0);
  }

}
