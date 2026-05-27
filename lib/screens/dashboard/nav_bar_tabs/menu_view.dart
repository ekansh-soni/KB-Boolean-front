import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kb_boolean/routes/app_routes.dart';
import 'package:kb_boolean/screens/menu_view/bank_details_bottom_sheet.dart';
import 'package:kb_boolean/theme/app_colors.dart';
import 'package:kb_boolean/widgets/custom_card_container.dart';

import '../../../utils/app_images.dart';
import '../../../widgets/custom_text_widget.dart';

class MenuView extends StatelessWidget {
  const MenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: .all(16.sp),
      child: CustomCardContainer(
        child: Column(
          children: [
            ListTile(
              onTap: ()=> Get.toNamed(AppRoutes.contactUsScreen),
              leading: Image.asset(AppImages.icContactUs, height: 18.sp, color: AppColors.iconColor,),
              dense: true,
              title: CustomTextWidget(text: "Contact us",fontSize: 14.sp, fontWeight: FontWeight.w500,),
              trailing: Icon(Icons.chevron_right_outlined),
            ),
            ListTile(
              onTap: () => Get.bottomSheet(StatefulBuilder(builder: (context, setState) => BankDetailsBottomSheet(),), backgroundColor: AppColors.bottomSheetBgColor),
              leading: Image.asset(AppImages.icBank, height: 18.sp,color: AppColors.iconColor,),
              dense: true,
              title: CustomTextWidget(text: "Bank Details", fontSize: 14.sp, fontWeight: FontWeight.w500,),
              trailing: Icon(Icons.chevron_right_outlined),
            ),
          ],
        )
      ),
    );
  }
}
