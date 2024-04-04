import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:todo/model.dart';
import 'core/controllers/db_controller.dart';
import 'home_page.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:timezone/data/latest.dart' as tz;


Future<void> init() async {
  tz.initializeTimeZones();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();

  final AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('app_icon');

  final InitializationSettings initializationSettings =
  InitializationSettings(android: initializationSettingsAndroid,);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(TodoAdapter());
  //noftioncation init
  await init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});
   DBController controller = Get.put(DBController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amberAccent.shade100),
        useMaterial3: true,
      ),
      home:  HomePage(),
    );
  }
}

