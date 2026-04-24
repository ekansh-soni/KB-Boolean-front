import 'package:get/get.dart';
import 'package:kb_boolean/screens/dashboard/dashboard_screen.dart';
import 'package:kb_boolean/screens/splash_screen.dart';

class AppRoutes {
  static const String splashScreen = "/splashScreen";
  static const String dashBoardScreen = "/dashBoardScreen";
  static List<GetPage> pages = [
    GetPage(name: splashScreen, page: ()=>SplashScreen()),
    GetPage(name: dashBoardScreen, page: ()=>DashboardScreen()),
  ];
}