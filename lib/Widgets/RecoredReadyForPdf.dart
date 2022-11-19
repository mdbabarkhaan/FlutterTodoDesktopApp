import 'package:flutter/material.dart';

import '../Utilities.dart';

class RecoredReadyForPdf extends StatefulWidget {
  int? record;
  RecoredReadyForPdf({this.record,Key? key}) : super(key: key);

  @override
  State<RecoredReadyForPdf> createState() => _RecoredReadyForPdfState();
}

class _RecoredReadyForPdfState extends State<RecoredReadyForPdf> {
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
            alignment: Alignment.bottomLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text("${widget.record??""}",style: TextStyle(fontSize: 40,fontFamily: fontStyle),),
                    SizedBox(width: 20,),
                    Icon(Icons.local_printshop_outlined)
                  ],
                ),
                Text("Records Ready for Print",style: TextStyle(fontSize: 30,fontFamily: fontStyle),),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
