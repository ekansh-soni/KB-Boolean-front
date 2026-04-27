import 'package:flutter_dotenv/flutter_dotenv.dart';

class ProjectSettings {
  static final production = dotenv.get('PRODUCTION_URL');
  static final preProduction = dotenv.get('PRE_PRODUCTION_URL');
  static final localUrl = dotenv.get('LOCAL_URL');
  static final baseUrl = localUrl;
  static const appName = "KB Boolean";
  static const int receiveTimeout = 150000;
  static const int connectionTimeout = 150000;
}