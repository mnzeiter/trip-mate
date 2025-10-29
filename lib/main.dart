import 'package:e_tourism/UserDate.dart';
import 'package:e_tourism/pages/AdminLoginPage.dart';
import 'package:e_tourism/pages/MyToursPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/LoginPage.dart';
import 'pages/RegisterPage.dart';
import 'pages/AdminCrudPage.dart';
import 'pages/ToursListPage.dart';
import 'pages/SearchPage.dart';
import 'pages/ReportsPage.dart';
//import 'package:provider/provider.dart';
//import 'my_model.dart';

void main() {
  
  runApp( ChangeNotifierProvider(
      create: (context) => UserData(),
      child: MyApp(),));

  //runApp(
  //MultiProvider(
  //providers: [
  //ChangeNotifierProvider(create: (_) => MyModel()),
  //],
  //child: MyApp(),
  //),
  //);


}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Tourism App',
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/adminLogin': (context) => AdminLoginPage(),
        '/register': (context) => RegisterPage(),
        '/admin': (context) => AdminCRUDPage(),
        '/tours': (context) => ToursListPage(),
        '/search': (context) => SearchPage(),
        '/reports': (context) => ReportsPage(),
        '/myTours': (context) => MyToursPage(),
        '/report': (context) => ReportsPage(),
      },
    );
  }
}
