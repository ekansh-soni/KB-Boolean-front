import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kb_boolean/screens/kb_boolean.dart';
import 'package:kb_boolean/services/shared_preference_helper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesHelper().init();
  await dotenv.load(fileName: ".env");
  runApp(KbBoolean());
}