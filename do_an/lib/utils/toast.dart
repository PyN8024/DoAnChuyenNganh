import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast(String mes) => Fluttertoast.showToast(
    msg: mes,
    fontSize: 18,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.grey,
    textColor: Colors.black,
);
