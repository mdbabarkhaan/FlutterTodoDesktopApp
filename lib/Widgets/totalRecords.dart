import 'package:flutter/material.dart';

import '../Utilities.dart';

class TotalRecords extends StatefulWidget {
  int? record;
  TotalRecords({this.record,Key? key}) : super(key: key);

  @override
  State<TotalRecords> createState() => _TotalRecordsState();
}

class _TotalRecordsState extends State<TotalRecords> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10,left: 20,bottom: 10,right: 10),
      margin: EdgeInsets.only(left: 20,bottom: 10),
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.teal.withOpacity(0.3),
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text("Total Records",style: TextStyle(fontSize: 40,fontFamily: fontStyle),),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Text("${widget.record??""}",style: TextStyle(fontSize: 40,fontFamily: fontStyle),),
          ),

        ],
      ),
    );
  }
}
