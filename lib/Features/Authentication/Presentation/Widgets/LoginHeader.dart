import 'package:flutter/material.dart';


Widget header(){
  return Column(
    children: [
      Text("Fit R",style: TextStyle(
          fontWeight: FontWeight.bold,fontSize:34
      ),),
      SizedBox(height: 20,),
      Image.asset(width: 200,height: 150,"assets/meditation.png"),
      SizedBox(height:20,),
    ],
  );
}