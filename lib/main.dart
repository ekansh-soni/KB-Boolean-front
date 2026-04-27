import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:kb_boolean/screens/kb_boolean.dart';
import 'package:kb_boolean/services/shared_preference_helper.dart';
import 'package:kb_boolean/services/socket_service.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesHelper().init();
  await dotenv.load(fileName: ".env");
  Get.put(SocketService(), permanent: true);
  runApp(KbBoolean());
}