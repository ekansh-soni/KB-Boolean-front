import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../widgets/custom_text_widget.dart';

class TradesView extends StatelessWidget {
  const TradesView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: .all(16.sp),
      child: CustomTextWidget(text: "Trade view"),
    );
  }
}
