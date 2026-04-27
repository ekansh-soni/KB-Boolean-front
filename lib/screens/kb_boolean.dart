import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kb_boolean/routes/app_routes.dart';

import '../theme/app_colors.dart';
import '../theme/app_fonts.dart';

class KbBoolean extends StatelessWidget {
  const KbBoolean({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: SafeArea(
        child: GetMaterialApp(
          title: 'KB Boolean',
          theme: ThemeData(
            fontFamily: AppFonts.poppins,
            dividerColor: Colors.transparent,
            appBarTheme: const AppBarTheme(
              backgroundColor: AppColors.whiteColor,
            ),
            scaffoldBackgroundColor: AppColors.whiteColor,
            textSelectionTheme: TextSelectionThemeData(
              selectionColor: AppColors.primaryColor.withValues(alpha: 0.6),
              selectionHandleColor: AppColors.primaryColor,
            ),
          ),
          debugShowCheckedModeBanner: false,
          getPages: AppRoutes.pages,
          initialRoute: AppRoutes.splashScreen,
          useInheritedMediaQuery: true,
        
        ),
      ),
    );
  }
}
