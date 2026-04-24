import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kb_boolean/routes/app_routes.dart';
import 'package:kb_boolean/theme/app_colors.dart';

class KbBoolean extends StatelessWidget {
  const KbBoolean({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: SafeArea(
        child: GetMaterialApp(
          title: 'KB Boolean',
          theme: ThemeData(
            splashColor: Colors.transparent
          ),
          debugShowCheckedModeBanner: false,
          getPages: AppRoutes.pages,
          initialRoute: AppRoutes.splashScreen,
        
        ),
      ),
    );
  }
}
