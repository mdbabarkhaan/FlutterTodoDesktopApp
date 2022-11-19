import 'dart:math';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:testing/Models/record_model.dart';

/// datebse box
late Box myBox;
Box<Record> myRecordBox = Hive.box<Record>("allRecords");
String fontStyle = "Righteous";

///Colors list for listTile
var rng = Random();
final List<Color> colorList = <Color>[
  Color.fromRGBO(255, 173, 87, 0.5),
  Color.fromRGBO(254, 236, 216, 0.5),
  Color.fromRGBO(88, 209, 132, 0.5),
  Color.fromRGBO(230, 221, 242, 0.5),
  Color.fromRGBO(106, 123, 255, 0.5),
];

appButton({VoidCallback? onPressed}) {
  return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            "SUMBIT",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ));
}


showUpdateDialog({String? description, String? name, BuildContext? context, Record? record}) {
  final TextEditingController nameController = TextEditingController(text: name??"");
  final TextEditingController descriptionController = TextEditingController(text: description??"");
  return Get.defaultDialog(
      backgroundColor: Colors.transparent,
      radius: 15,
      title: "EDIT YOUR RECORD",
      titlePadding: const EdgeInsets.only(top: 10),
      contentPadding: const EdgeInsets.all(15),
      titleStyle: TextStyle(
          color: Colors.green, fontWeight: FontWeight.bold, fontSize: 25),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          myTextField(controller: nameController, hint: "Name"),
          SizedBox(
            height: 10,
          ),
          myTextField(controller: descriptionController, hint: "Description"),
          SizedBox(
            height: 10,
          ),
          appButton(onPressed: () async {
            if(nameController.text.isEmpty){
              showSnackBar(context: context, title: "Please enter Name");
            }else{
              if(descriptionController.text.isEmpty){
                showSnackBar(context: context, title: "Please enter Description");
              }else{
                if(record != null){
                  record.name = nameController.text;
                  record.description = descriptionController.text;
                  record.save();
                  Get.back();
                  showSuccessSnackBar(context: context, title: "Your Data Update Successfully!");
                }
              }
            }
          }),
        ],
      ));
}

myTextField({TextEditingController? controller, String? hint}) {
  return TextFormField(
    validator: (value) {
      if (value!.isEmpty) {
        return "Enter value";
      } else {
        return null;
      }
    },
    controller: controller,
    cursorColor: Colors.white,
    minLines: hint!.toLowerCase() == "name" ? 1 : 4,
    maxLines: 20,
    decoration: InputDecoration(
      hintText: "$hint",
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.green),
      ),
      filled: true,
      fillColor: Colors.green.withOpacity(0.3),
    ),
  );
}

showSnackBar({String? title, String? description, BuildContext? context}) {
  return CherryToast.warning(
    title: Text(''),
    displayTitle: false,
    description:
    Text('$title',style: TextStyle(color: Colors.black),),
    toastDuration:  const Duration(seconds: 1),
    animationType: AnimationType.fromTop,
    actionHandler: () {print("12345443");},
  ).show(context!);
}

showSuccessSnackBar({String? title, String? description, BuildContext? context}) {
  return CherryToast.success(
    title: Text(''),
    displayTitle: false,
    description:
    Text('$title',style: TextStyle(color: Colors.black),),
    toastDuration:  const Duration(seconds: 1),
    animationType: AnimationType.fromTop,
    actionHandler: () {print("12345443");},
  ).show(context!);
}

