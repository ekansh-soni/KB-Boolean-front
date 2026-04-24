import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kb_boolean/controllers/dashboard_controller.dart';
import 'package:kb_boolean/theme/app_colors.dart';
import 'package:kb_boolean/widgets/custom_text_widget.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

  final controller = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: .center,
        children: [
          Center(child: CustomTextWidget(text: "KB Boolean", fontSize: 24.sp, fontWeight: FontWeight.w700,)),

          Expanded(child:  Align(
            alignment: AlignmentGeometry.topLeft,
            child: Obx(
                 () => controller.bottomNavigationScreens.elementAt(
               controller.selectedIndex.value,
             ),
                     ),
          ),)
        ],
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          backgroundColor: AppColors.primaryColor,
          items: controller.bottomNavigationItems,
          currentIndex: controller.selectedIndex.value,
          onTap: controller.changeIndex,
          unselectedItemColor: AppColors.unSelectedNavBarColor,
          selectedItemColor: AppColors.selectedNavBarColor,
          type: .fixed,
        ),
      ),
    );
  }
}
