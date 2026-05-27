import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kb_boolean/controllers/dashboard_controller.dart';
import 'package:kb_boolean/theme/app_colors.dart';
import 'package:kb_boolean/utils/utils.dart';
import 'package:kb_boolean/widgets/custom_text_widget.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

  final controller = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: DoubleBackToCloseApp(
        snackBar: SnackBar(
          content: CustomTextWidget(text: "Tap again to exit!"),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(28.r),
                  bottomRight: Radius.circular(28.r),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextWidget(
                    text: "Khushi Bullion",
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.whiteColor,
                  ),
                  spaceHeight(8.h),
                  CustomTextWidget(
                    text: "Jeweller premium and live market dashboard",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.unSelectedNavBarColor,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.lightBaseColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(28.r),
                    topRight: Radius.circular(28.r),
                  ),
                ),
                child: Obx(
                  () => controller.bottomNavigationScreens.elementAt(
                    controller.selectedIndex.value,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          backgroundColor: AppColors.primaryColor,
          items: controller.bottomNavigationItems,
          currentIndex: controller.selectedIndex.value,
          onTap: controller.changeIndex,
          unselectedItemColor: AppColors.unSelectedNavBarColor,
          selectedItemColor: AppColors.selectedNavBarColor,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}
