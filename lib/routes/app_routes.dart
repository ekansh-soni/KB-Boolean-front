import 'package:get/get.dart';
import 'package:kb_boolean/screens/dashboard/dashboard_screen.dart';
import 'package:kb_boolean/screens/splash_screen.dart';

import '../screens/menu_view/contact_us_screen.dart';

class AppRoutes {
  static const String splashScreen = "/splashScreen";
  static const String dashBoardScreen = "/dashBoardScreen";
  static const String contactUsScreen = "/contactUsScreen";
  static List<GetPage> pages = [
    GetPage(name: splashScreen, page: ()=>SplashScreen()),
    GetPage(name: dashBoardScreen, page: ()=>DashboardScreen()),
    GetPage(name: contactUsScreen, page: ()=>ContactUsScreen()),
  ];
}