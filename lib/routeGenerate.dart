// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:mercadopoupanca/pages/accountPage/accountPage.dart';
import 'package:mercadopoupanca/pages/addPricePage/addPricePage.dart';
import 'package:mercadopoupanca/pages/addProductPage/addProductPage.dart';
import 'package:mercadopoupanca/pages/barcodeScanPage/barcodeScanPage.dart';
import 'package:mercadopoupanca/pages/cartPage/cartPage.dart';
import 'package:mercadopoupanca/pages/catalogPage/catalogPage.dart';
import 'package:mercadopoupanca/pages/checkoutPage/checkoutPage.dart';
import 'package:mercadopoupanca/pages/filterPage/filterPage.dart';
import 'package:mercadopoupanca/pages/homePage/homePage.dart';
import 'package:mercadopoupanca/pages/loginPage/loginPage.dart';
import 'package:mercadopoupanca/pages/productPage/productPage.dart';
import 'package:mercadopoupanca/pages/registerPage/registerPage.dart';
import 'package:mercadopoupanca/pages/settingsPage/settingsPage.dart';
import 'package:mercadopoupanca/pages/splashPage/splashPage.dart';
import 'package:mercadopoupanca/pages/statusShopPage/statusShopPage.dart';
// ignore: unused_import

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // ignore: unused_local_variable
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const MyHomePage());

      case '/spash':
        return MaterialPageRoute(builder: (_) => const splashPage());

      case '/scan':
        return MaterialPageRoute(builder: (_) => const barcodeScan());

      case '/filter':
        return MaterialPageRoute(builder: (_) => const filterPage());

      case '/product':
        if (args is String) {
          return MaterialPageRoute(
              builder: (_) => productsPage(data: args.toString()));
        } else {
          return _errorRoute();
        }

      case '/addProduct':
        if (args is String) {
          return MaterialPageRoute(
              builder: (_) => addProductPage(data: args.toString()));
        } else {
          return _errorRoute();
        }

      case '/addPrice':
        if (args is List) {
          return MaterialPageRoute(builder: (_) => addPricePage(data: args));
        } else {
          return _errorRoute();
        }

      case '/catalog':
        return MaterialPageRoute(builder: (_) => const catalogPage());

      case '/cart':
        return MaterialPageRoute(builder: (_) => const cartPage());

      case '/checkout':
        if (args is double) {
          return MaterialPageRoute(builder: (_) => checkoutPage(data: args));
        } else {
          return _errorRoute();
        }

      case '/resultShop':
        if (args is List) {
          return MaterialPageRoute(builder: (_) => statusShopPage(data: args));
        } else {
          return _errorRoute();
        }

      case '/register':
        return MaterialPageRoute(builder: (_) => const registerPage());

      case '/login':
        return MaterialPageRoute(builder: (_) => const loginPage());

      case '/account':
        return MaterialPageRoute(builder: (_) => const accountPage());

      case '/settings':
        return MaterialPageRoute(builder: (_) => const settingsPage());

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
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
