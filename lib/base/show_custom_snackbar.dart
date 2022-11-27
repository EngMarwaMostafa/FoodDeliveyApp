import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

void showCustomSnackbar(String message,{bool isError=true,String title='Error'}){

  Get.snackbar(title,message,
    titleText: BigText(text:title,color:Colors.white),
    messageText: Text(message,style: TextStyle(
      color: Colors.white,
    ),
    ),
    colorText: Colors.white,
    snackPosition: SnackPosition.TOP,
    backgroundColor: Colors.redAccent,
  );
}