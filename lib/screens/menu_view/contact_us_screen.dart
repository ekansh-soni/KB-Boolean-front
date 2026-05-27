import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kb_boolean/theme/app_colors.dart';
import 'package:kb_boolean/utils/utils.dart';
import 'package:kb_boolean/widgets/custom_card_container.dart';
import 'package:kb_boolean/widgets/custom_text_widget.dart';

import '../../controllers/contact_us_controller.dart';

class ContactUsScreen extends StatelessWidget {
  ContactUsScreen({super.key});
  final controller = Get.put(ContactUsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: CustomTextWidget(text: "Contact Us", fontSize: 20.sp, fontWeight: FontWeight.w600,),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.sp),
        child: Column(
          children: [
            CustomCardContainer(
              borderColor: AppColors.borderOrange,
              child: Row(
                children: [
                  Icon(Icons.location_on_outlined, color: AppColors.iconColor,),
                  spaceWidth(10.w),
                  Column(
                    crossAxisAlignment: .start,
                    children: [
                      CustomTextWidget(text: "Address"),
                      CustomTextWidget(text: "Sujangarh"),
                    ],
                  )
                ],
              )
            ),
            spaceHeight(5.h),
            CustomCardContainer(
                borderColor: AppColors.borderOrange,
                child: Row(
                  children: [
                    Icon(Icons.phone, color: AppColors.iconColor,),
                    spaceWidth(10.w),
                    Column(
                      crossAxisAlignment: .start,
                      children: [
                        CustomTextWidget(text: "Phone No."),
                        CustomTextWidget(text: "+91 1234 56789"),
                      ],
                    )
                  ],
                )
            ),

            ExpansionTile(
              title: CustomTextWidget(text: "Enquire Now"),
              children: [

              ],
            )
          ],
        ),
      ),
    );
  }
}
