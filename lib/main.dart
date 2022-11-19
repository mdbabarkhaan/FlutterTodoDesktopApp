import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:testing/Models/record_model.dart';
import 'package:testing/Utilities.dart';
import 'package:window_manager/window_manager.dart';
import 'Screens/TransfarentWindow.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Window.initialize();
  Directory appDocDir = await getApplicationDocumentsDirectory();
  String appDocPath = appDocDir.path;
  print(appDocPath);
  Hive.init(appDocPath);
  Hive.registerAdapter<Record>(RecordAdapter());
  myBox = await Hive.openBox<Record>("allRecords");
  // myBox.add(Record(
  //   name: "Babar Khan",
  //   description: "Test Hive to write data",
  //   dateTime: DateTime.now(),
  // ));
  if (Platform.isWindows) {
    await Window.hideWindowControls();
  }
  runApp(MyApp());
  if (Platform.isWindows) {
    windowManager.waitUntilReadyToShow().then((_) async => await windowManager.setAsFrameless());
    doWhenWindowReady(() {
      appWindow
        ..alignment = Alignment.center
        ..show();
    });
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Awkum Cases Record",
      theme: ThemeData(
        splashFactory: InkRipple.splashFactory,
      ),
      darkTheme: ThemeData.dark().copyWith(
        splashFactory: InkRipple.splashFactory,
      ),
      themeMode: ThemeMode.dark,
      home: MyAppBody(),
    );
  }
}
