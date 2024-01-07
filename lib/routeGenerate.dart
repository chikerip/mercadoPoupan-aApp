// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:mercadopoupanca/pages/accountPage/accountPage.dart';
import 'package:mercadopoupanca/pages/barcodeScanPage/barcodeScanPage.dart';
import 'package:mercadopoupanca/pages/catalogPage/catalogPage.dart';
import 'package:mercadopoupanca/pages/filterPage/filterPage.dart';
import 'package:mercadopoupanca/pages/homePage/homePage.dart';
import 'package:mercadopoupanca/pages/loginPage/loginPage.dart';
import 'package:mercadopoupanca/pages/productPage/productPage.dart';
import 'package:mercadopoupanca/pages/registerPage/registerPage.dart';
import 'package:mercadopoupanca/pages/settingsPage/settingsPage.dart';
// ignore: unused_import

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    
    // ignore: unused_local_variable
    final args = settings.arguments;

    switch(settings.name){
      case '/':
        return MaterialPageRoute(builder: (_) => const MyHomePage());
        //Navigator.of(context).pushNamed(
        //'/scan',
        //arguments: data
        //);
      case '/scan':
       return MaterialPageRoute(builder: (_)=> const barcodeScan());
      
      case '/filter':
        return MaterialPageRoute(builder: (_)=> const filterPage());

      case '/product':
        return MaterialPageRoute(builder: (_)=>const productsPage());
      
      case '/catalog':
        return MaterialPageRoute(builder: (_)=> const catalogPage());
      
      case '/register':
        return MaterialPageRoute(builder: (_)=> const registerPage());
      
      case '/login':
        return MaterialPageRoute(builder: (_)=> const loginPage());
      
      case '/account':
        return MaterialPageRoute(builder: (_)=> const accountPage());

      case '/settings':
        return MaterialPageRoute(builder: (_)=> const settingsPage());

      default:
      
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_){
      return Scaffold(
        appBar: AppBar(
          title: const Text('error'),
        ),
        body: const Center(
          child: Text('error'),
        ),
      );
    });
  }
}