import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testing/Models/record_model.dart';

import '../Utilities.dart';

class DataFiled extends StatefulWidget {
  const DataFiled({Key? key}) : super(key: key);

  @override
  State<DataFiled> createState() => _DataFiledState();
}

class _DataFiledState extends State<DataFiled> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        border: Border.all(
          color: Colors.white,
          width: 1,
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Enter Record",style: TextStyle(fontFamily: fontStyle,fontSize: 20),),
          SizedBox(height: 10),
          TextField(
            controller: nameController,
            cursorColor: Colors.white,
            decoration: InputDecoration(
              hintText: "name",
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.green),
              ),
              filled: true,
              fillColor: Colors.green.withOpacity(0.3),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: descriptionController,
            cursorColor: Colors.white,
            minLines: 4,
            maxLines: 20,
            decoration: InputDecoration(
              hintText: "description",
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.green),
              ),
              filled: true,
              fillColor: Colors.green.withOpacity(0.3),
            ),
          ),
          const SizedBox(height: 30),
          appButton(onPressed: () async {
            var newRecord = Record(name: nameController.text,description: descriptionController.text,dateTime: DateTime.now(),done: true,);
            if(nameController.text.isEmpty){
              showSnackBar(context: context, title: "Please enter Name");
            }else{
              if(descriptionController.text.isEmpty){
                showSnackBar(context: context, title: "Please enter Description");
              }else{
               await myRecordBox.add(newRecord);
                showSuccessSnackBar(context: context, title: "Your Data Add Successfully!");
                nameController.clear();
                descriptionController.clear();
              }
            }
          })
        ],
      ),
    );
  }
}
