import 'package:do_an/pages/CatalogPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Đồ án chuyên ngành',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: CatalogPage());
  }
}
