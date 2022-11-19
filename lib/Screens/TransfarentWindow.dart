import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:searchable_listview/searchable_listview.dart';
import 'package:testing/Controller/SearchController.dart';
import 'package:testing/Models/record_model.dart';
import 'package:testing/Utilities.dart';
import 'dart:io';
import 'package:testing/Widgets/DataField.dart';
import 'package:testing/Widgets/chart.dart';
import 'package:testing/Widgets/myListTile.dart';
import 'package:testing/Widgets/totalRecords.dart';
import 'package:transformable_list_view/transformable_list_view.dart';
import '../Controller/pdfApi.dart';
import '../Widgets/LineChart.dart';
import '../Widgets/RecoredReadyForPdf.dart';
import '../Widgets/listAnimation.dart';


enum InterfaceBrightness {
  light,
  dark,
  auto,
}

extension InterfaceBrightnessExtension on InterfaceBrightness {
  bool getIsDark(BuildContext? context) {
    if (this == InterfaceBrightness.light) return false;
    if (this == InterfaceBrightness.auto) {
      if (context == null) return true;
      return MediaQuery.of(context).platformBrightness == Brightness.dark;
    }

    return true;
  }

  Color getForegroundColor(BuildContext? context) {
    return getIsDark(context) ? Colors.white : Colors.black;
  }
}

class MyAppBody extends StatefulWidget {
  MyAppBody({Key? key}) : super(key: key);

  @override
  MyAppBodyState createState() => MyAppBodyState();
}

class MyAppBodyState extends State<MyAppBody> {
  WindowEffect effect = WindowEffect.aero;
  Color color = Platform.isWindows ? Colors.transparent : Colors.transparent;
  InterfaceBrightness brightness =
  Platform.isMacOS ? InterfaceBrightness.auto : InterfaceBrightness.dark;

  final searchController  = Get.put(SearchController());
  List lst = [];
  List<Record> characters = [];

  // static final DateTime todaysDate = DateTime.now();
  // static final DateTime yesterdayDate = DateTime.utc(todaysDate.year, todaysDate.month, todaysDate.day);



  @override
  void initState() {
    super.initState();
    this.setWindowEffect(this.effect);
  }

  void setWindowEffect(WindowEffect? value) {
    Window.setEffect(
      effect: value!,
      color: this.color,
      dark: brightness == InterfaceBrightness.light,
    );
    if (Platform.isMacOS) {
      if (brightness != InterfaceBrightness.auto) {
        Window.overrideMacOSBrightness(
            dark: brightness == InterfaceBrightness.dark);
      }
    }
    this.setState(() => this.effect = value);
  }

  @override
  Widget build(BuildContext context) {
    // print("---------------${yesterdayDate}");
    return TitlebarSafeArea(
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
             WindowTitleBar(brightness: brightness),
              Expanded(
                child: Padding(padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          DataFiled(),
                          SizedBox(height: 20,),
                          ValueListenableBuilder<Box<Record>>(
                            valueListenable: Hive.box<Record>("allRecords").listenable(),
                            builder: (context, value, child) {
                              DateTime todaysDate = DateTime.now();
                              final DateTime yesterdayDate = DateTime.utc(todaysDate.year, todaysDate.month, todaysDate.day);
                              // lst = myRecordBox.values
                              //     .where((value) => value.dateTime!.day == yesterdayDate.day)
                              //     .toList();
                              // print(filteredUsers.length);
                              print(yesterdayDate.day);
                              return Expanded(child: LineChartWW(
                                mondayRecord: myRecordBox.values.where((element) => element.dateTime!.day >=1).where((element) => element.dateTime!.day <= 5).toList().length,
                                tuesdayRecord: myRecordBox.values.where((element) => element.dateTime!.day >=6).where((element) => element.dateTime!.day <= 10).toList().length,
                                wednesdayRecord: myRecordBox.values.where((element) => element.dateTime!.day >=11).where((element) => element.dateTime!.day <= 15).toList().length,
                                thursdayRecord: myRecordBox.values.where((element) => element.dateTime!.day >= 16).where((element) => element.dateTime!.day <= 20).toList().length,
                                fridayRecord: myRecordBox.values.where((element) => element.dateTime!.day >=21).where((element) => element.dateTime!.day <= 25).toList().length,
                                saturdayRecord: myRecordBox.values.where((element) => element.dateTime!.day >=26).where((element) => element.dateTime!.day <= 31).toList().length,
                                // sundayRecord: myRecordBox.values.where((element) => element.dateTime!.day == yesterdayDate.day).toList().length, sun: "Sun",
                              ));
                            },
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 10,
                      child: ValueListenableBuilder<Box<Record>>(
                        valueListenable: Hive.box<Record>("allRecords").listenable(),
                        builder: (context, value, child) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(child: TotalRecords(record: myBox.values.length,)),
                                  Expanded(child: InkWell(child: RecoredReadyForPdf(record: myBox.values.length,),
                                    onTap: () async {
                                      List<RecordForPrint> lst2 = <RecordForPrint>[];
                                      var characters = myRecordBox.toMap().values.toList();
                                      lst2.clear();
                                      for(var item in characters){
                                        lst2.add(RecordForPrint(name: item.name, description: item.description, dateTime: item.dateTime, id: item.key));
                                      }
                                    final pdfFile = await PdfApi.generateCenteredText(lst2);
                                    PdfApi.openFile(pdfFile);
                                  },)),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 20,bottom: 10),
                                width: double.infinity,height: 50,child: searchController.searchField(),),
                              Expanded(
                                child: TransformableListView.builder(
                                  getTransformMatrix: getTransformMatrix,
                                  itemBuilder: (context, index) {
                                    int reverse = myBox.values.length - 1 - index;
                                    Record currentRecord = myBox.getAt(reverse);
                                    return Obx(() => MyListTile(record: currentRecord,index: reverse,qquery:searchController.query.toString(),));
                                  },
                                  itemCount: myBox.values.length,
                                )
                              )
                            ],
                          );
                        },
                      ),
                    )
                  ],
                )
                ),
              ),
            ],
          )
      ),
    );
  }

}

  class WindowTitleBar extends StatelessWidget {
  final InterfaceBrightness brightness;
  const WindowTitleBar({Key? key, required this.brightness}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isWindows
        ? Container(
      width: MediaQuery.of(context).size.width,
      height: 32.0,
      color: Colors.transparent,
      child: MoveWindow(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 10,top: 5),
                child: Text("Awkum Cases Record"),
              ),
            ),
            MinimizeWindowButton(
              colors: WindowButtonColors(
                iconNormal: brightness == InterfaceBrightness.light
                    ? Colors.black
                    : Colors.white,
                iconMouseDown: brightness == InterfaceBrightness.light
                    ? Colors.black
                    : Colors.white,
                iconMouseOver: brightness == InterfaceBrightness.light
                    ? Colors.black
                    : Colors.white,
                normal: Colors.teal.withOpacity(0.5),
                mouseOver: brightness == InterfaceBrightness.light
                    ? Colors.black.withOpacity(0.04)
                    : Colors.white.withOpacity(0.04),
                mouseDown: brightness == InterfaceBrightness.light
                    ? Colors.black.withOpacity(0.08)
                    : Colors.white.withOpacity(0.08),
              ),
            ),
            MaximizeWindowButton(
              colors: WindowButtonColors(
                iconNormal: brightness == InterfaceBrightness.light
                    ? Colors.black
                    : Colors.white,
                iconMouseDown: brightness == InterfaceBrightness.light
                    ? Colors.black
                    : Colors.white,
                iconMouseOver: brightness == InterfaceBrightness.light
                    ? Colors.black
                    : Colors.white,
                normal: Colors.black38,
                mouseOver: brightness == InterfaceBrightness.light
                    ? Colors.black.withOpacity(0.04)
                    : Colors.white.withOpacity(0.04),
                mouseDown: brightness == InterfaceBrightness.light
                    ? Colors.black.withOpacity(0.08)
                    : Colors.white.withOpacity(0.08),
              ),
            ),
            CloseWindowButton(
              onPressed: () {
                appWindow.close();
              },
              colors: WindowButtonColors(
                iconNormal: brightness == InterfaceBrightness.light
                    ? Colors.black
                    : Colors.white,
                iconMouseDown: brightness == InterfaceBrightness.light
                    ? Colors.black
                    : Colors.white,
                iconMouseOver: brightness == InterfaceBrightness.light
                    ? Colors.black
                    : Colors.white,
                normal: Colors.grey,
                mouseOver: brightness == InterfaceBrightness.light
                    ? Colors.black.withOpacity(0.04)
                    : Colors.red,
                mouseDown: brightness == InterfaceBrightness.light
                    ? Colors.black.withOpacity(0.08)
                    : Colors.white.withOpacity(0.08),
              ),
            ),
          ],
        ),
      ),
    )
        : Container();
  }
}