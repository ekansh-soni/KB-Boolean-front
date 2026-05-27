import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kb_boolean/theme/app_colors.dart';
import 'package:kb_boolean/widgets/custom_text_widget.dart';

class CustomTextContainer extends StatelessWidget {
  final String text;
  final double? fontSize;
  const CustomTextContainer({super.key, required this.text, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:.all(4.sp) ,
      decoration: BoxDecoration(
        color: Color(0xFFB78D3A),
        borderRadius: .circular(16.r)
      ),
      child: CustomTextWidget(
        text: text,
        color: AppColors.whiteColor,
        fontWeight: FontWeight.w600,
        fontSize: fontSize,
      ),
    );
  }
}
