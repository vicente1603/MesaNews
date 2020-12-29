import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bloc/favoritos_bloc.dart';
import 'screens/credenciais/entrar_screen.dart';

void main() {
  SharedPreferences.setMockInitialValues({});
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: FavoritosBloc(),
      child: MaterialApp(
        title: 'MesaNews',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: HexColor("##010A53"),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: EntrarScreen(),
      ),
    );
  }
}
