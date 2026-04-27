import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kb_boolean/screens/dashboard/nav_bar_tabs/live_rate_view.dart';
import 'package:kb_boolean/screens/dashboard/nav_bar_tabs/menu_view.dart';
import 'package:kb_boolean/screens/dashboard/nav_bar_tabs/news_view.dart';
import 'package:kb_boolean/screens/dashboard/nav_bar_tabs/trades_view.dart';

class DashboardController extends GetxController{
  var selectedIndex = 0.obs;

  void changeIndex(int index){
    selectedIndex.value = index;
  }

  List<BottomNavigationBarItem> bottomNavigationItems = const [
    BottomNavigationBarItem(icon: Icon(Icons.multiline_chart), label: "Live rates"),
    BottomNavigationBarItem(icon: Icon(Icons.add_chart), label: "Trades"),
    BottomNavigationBarItem(icon: Icon(Icons.newspaper), label: "News"),
    BottomNavigationBarItem(icon: Icon(Icons.menu), label: "Menu"),
  ];

  List<Widget> bottomNavigationScreens = const [
    LiveRateView(),
    TradesView(),
    NewsView(),
    MenuView()
  ];
}