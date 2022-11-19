import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:testing/Models/record_model.dart';
import 'package:testing/Utilities.dart';
import 'package:get/get.dart';
import '../Controller/SearchController.dart';

class MyListTile extends StatefulWidget {
  Record? record;
  int? index;
  String? qquery = "";
  MyListTile({this.record, this.index,this.qquery,Key? key}) : super(key: key);

  @override
  State<MyListTile> createState() => _MyListTileState();
}

class _MyListTileState extends State<MyListTile> {
  final searchController  = Get.find<SearchController>();
  @override
  Widget build(BuildContext context) {

    return widget.record!.name.toString().toLowerCase().contains(widget.qquery!.toLowerCase()) ?
    Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 10,left: 20),
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: 70,
      ),
      decoration: BoxDecoration(
        color: colorList[rng.nextInt(5)],
        borderRadius: BorderRadius.circular(10)
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.record!.name.toString(),style: TextStyle(fontFamily: fontStyle,fontSize: 17),),
                SizedBox(height: 5,),
                Text(widget.record!.description.toString(),style: TextStyle(fontFamily: fontStyle),),
                Text(widget.record!.dateTime.toString(),style: TextStyle(fontFamily: fontStyle),),
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Row(
              children: [
                IconButton(
                  onPressed: (){showUpdateDialog(name: widget.record!.name, description: widget.record!.description,context: context,record:widget.record);},
                  icon: Icon(Icons.edit),
                ),
                IconButton(onPressed: (){widget.record!.delete();}, icon: const Icon(Icons.delete),)
              ],
            )
          )
        ],
      ),
    )
        : Container();
  }
}
