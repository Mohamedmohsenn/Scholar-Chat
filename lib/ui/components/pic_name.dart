import 'package:flutter/material.dart';

Widget picName(String picName, String str) => Column(children: [
      Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(picName), fit: BoxFit.fill),
        ),
      ),
      Text(
        str,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 35,
            fontStyle: FontStyle.italic),
      )
    ]);
