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
      body: Padding(
        padding: EdgeInsets.all(16.sp),
        child: Column(
          children: [
            CustomCardContainer(
              borderColor: AppColors.borderOrange,
              child: Row(
                children: [
                  Icon(Icons.location_on_outlined),
                  Column(
                    children: [
                      CustomTextWidget(text: "Address"),
                      CustomTextWidget(text: "Sujangarh"),
                    ],
                  )
                ],
              )
            ),
            spaceHeight(10.h),
            CustomCardContainer(
                borderColor: AppColors.borderOrange,
                child: Row(
                  children: [
                    Icon(Icons.location_on_outlined),
                    Column(
                      children: [
                        CustomTextWidget(text: "Address"),
                        CustomTextWidget(text: "Sujangarh"),
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
