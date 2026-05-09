import 'package:kb_boolean/repository/project_settings.dart';

class Endpoints {
  static String localUrl = "192.168.1.26:8000";
  static String websocketUrl = "ws://$localUrl/ws/liveFeed";
  static String economicTimesWeb = "/economic-calender";
  static String webViewUrl = "${ProjectSettings.localUrl}$economicTimesWeb";
}