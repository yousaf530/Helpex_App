import 'package:flutter/material.dart';

AppBar buildAppBar (BuildContext context){
  return AppBar(
    leading: BackButton(
      onPressed: (){
        Navigator.pop(context);
      },
    ),
    backgroundColor: Colors.transparent,
    elevation: 0,
  );
}