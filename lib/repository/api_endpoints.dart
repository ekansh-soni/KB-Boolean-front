import 'package:kb_boolean/repository/project_settings.dart';

class Endpoints {

  // Authentication
  static String websocketUrl = "ws://${ProjectSettings.localUrl}/ws/liveFeed";
}