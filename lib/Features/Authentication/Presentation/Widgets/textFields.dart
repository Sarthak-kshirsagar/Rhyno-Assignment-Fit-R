import 'package:flutter/material.dart';
import 'package:info_popup/info_popup.dart';
import 'package:info_widget/info_widget.dart';

const String errorEmailMessage = 'Please enter a valid email address.';
const String errorMobileNumberMessage = 'Please enter a valid Indian mobile number.';
const String errorUsernameMessage = 'Username must be 3 to 20 characters long and may contain alphanumeric characters, underscores, and hyphens.';
const String errorAgeMessage = 'Please enter a valid age (1 to 99).';
const String errorHeightMessage = 'Please enter a valid height (50 to 250)cm.';
const String errorWeightMessage = 'Please enter a valid weight (35 - 150)kg.';
const String errorPasswordMessage = 'Password must be \nminimum of 8 characters,\nat least one alphabet,\nand at least one digit. ';

Widget inputTextFileds(errorMessage,label,TextEditingController c,isValidFunc){
  return Column(
    children: [

      Container(
        width: 250,
        child: Column(
          children: [

            SizedBox(height:5,),
            TextFormField(

              validator: (value){
                if(value!.isEmpty){
                  return "Field cannot be empty";
                }else if(!isValidFunc(value)){
                  return "$errorMessage";
                }
                return null;
              },
              controller: c,

              decoration: InputDecoration(prefixIcon: Icon(Icons.email),border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey,),
                borderRadius: BorderRadius.circular(20)
              ),label:Row(
                children: [
                  Text("${label}",



                  ),
                ],
              )),
            ),
          ],
        ),
      ),
      SizedBox(height:20,)
    ],
  );
}