import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kb_boolean/repository/api_endpoints.dart';
import 'package:kb_boolean/screens/dashboard/nav_bar_tabs/live_rate_view.dart';
import 'package:kb_boolean/screens/dashboard/nav_bar_tabs/menu_view.dart';
import 'package:kb_boolean/screens/dashboard/nav_bar_tabs/news_view.dart';
import 'package:kb_boolean/screens/dashboard/nav_bar_tabs/trades_view.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

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

  late WebSocketChannel channel;


  List<Widget> bottomNavigationScreens = const [
    LiveRateView(),
    TradesView(),
    NewsView(),
    MenuView()
  ];

  @override
  void onInit() {
    channel = WebSocketChannel.connect(
      Uri.parse(Endpoints.websocketUrl),
    );

    channel.stream.listen((message) {
      final data = jsonDecode(message);
      print(data);
    });
    super.onInit();
  }

  @override
  void onClose() {
    channel.sink.close();
    super.onClose();
  }
}