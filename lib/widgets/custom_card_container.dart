import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_colors.dart';

class CustomCardContainer extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final double? width, height;
  final EdgeInsetsGeometry? padding;
  final Color? borderColor;
  const CustomCardContainer({super.key, required this.child, this.onTap, this.width, this.padding, this.borderColor, this.height});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        margin: EdgeInsets.only(bottom: 10.h),
        clipBehavior: .antiAlias,
        foregroundDecoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(color: AppColors.borderColor, width: 1.w),
        ),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(15.r),
        ),
        padding: padding ?? .all(16.sp),
        child: child,
      ),
    );
  }
}
