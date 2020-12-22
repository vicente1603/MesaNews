import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mesa_news/screens/entrar_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MesaNews',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: HexColor("##010A53"),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: EntrarScreen(),
    );
  }
}
