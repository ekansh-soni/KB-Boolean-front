import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kb_boolean/utils/utils.dart';
import 'package:kb_boolean/widgets/custom_card_container.dart';
import 'package:kb_boolean/widgets/custom_text_widget.dart';

class BankDetailsBottomSheet extends StatelessWidget {
  const BankDetailsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: .all(16.sp),
      child: Column(
        crossAxisAlignment: .start,
      children: [

        CustomTextWidget(text: "Contact Us", fontSize: 20.sp, fontWeight: FontWeight.w700,),
        spaceHeight(16.h),

        ListView.builder(
          itemCount: 2,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return CustomCardContainer(
              child: Column(
                children: [
                  customRow("Bank Name", "Icici Bank"),
                  customRow("A/c Name", "Kb boolean"),
                  customRow("A/c No", "123456789"),
                  customRow("Ifsc Code", "1234"),
                  customRow("Branch Name", "america"),
                ],
              )
            );
          },
        )
      ],
    ),);
  }
}
