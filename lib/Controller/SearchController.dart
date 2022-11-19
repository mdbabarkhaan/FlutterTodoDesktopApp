import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SearchController extends GetxController{

  TextEditingController searchController  = TextEditingController();
  var query = "".obs;


  searchField(){
    return TextField(
      controller: searchController,
      cursorColor: Colors.white,
      cursorHeight: 30,
      minLines: 4,
      maxLines: 20,
      decoration: InputDecoration(
        hintText: "Search..",
        prefixIcon: Icon(Icons.search,color: Colors.green,),
        suffixIcon: IconButton(icon: Icon(Icons.cancel,color: Colors.green,),onPressed: (){searchController.clear();query.value = "";},),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.green),
        ),
        filled: true,
        fillColor: Colors.green.withOpacity(0.3),
      ),
      onChanged: (value){
        query.value = value;
      },
    );
  }

}