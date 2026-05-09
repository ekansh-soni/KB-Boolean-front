import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kb_boolean/routes/app_routes.dart';
import 'package:kb_boolean/screens/menu_view/bank_details_bottom_sheet.dart';
import 'package:kb_boolean/theme/app_colors.dart';
import 'package:kb_boolean/widgets/custom_card_container.dart';

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
              leading: Icon(Icons.phone),
              dense: true,
              title: CustomTextWidget(text: "Contact us"),
              trailing: Icon(Icons.chevron_right_outlined),
            ),
            ListTile(
              onTap: () => Get.bottomSheet(StatefulBuilder(builder: (context, setState) => BankDetailsBottomSheet(),), backgroundColor: AppColors.bottomSheetBgColor),
              leading: Icon(Icons.house_outlined),
              dense: true,
              title: CustomTextWidget(text: "Bank Details"),
              trailing: Icon(Icons.chevron_right_outlined),
            ),
          ],
        )
      ),
    );
  }
}
