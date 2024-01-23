// ignore_for_file: file_names, camel_case_types, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mercadopoupanca/pages/splashPage/service/post.dart';

class splashPage extends StatefulWidget {
  const splashPage({super.key});

  @override
  State<splashPage> createState() => _splashPage();
}

class _splashPage extends State<splashPage> {
  final _localStorage = Hive.box('localStorage');
  bool withOutConnection = false;
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    var responseAds = await RemoteServicesSplash()
        .getAds('https://mercadopoupanca.azurewebsites.net/ads');

    if (responseAds != null) {
      var getClient = await RemoteServicesSplash().getUserStatus();

      if (getClient == true) {
        _localStorage.put('searchStatus', 0);
        Navigator.of(context).pushReplacementNamed('/');
      } else if (getClient == 'Logout') {
        _localStorage.put('searchStatus', 0);
        Navigator.of(context).pushReplacementNamed('/');
        showDialog(
            context: context,
            builder: (context) => const AlertDialog(
                  content: Text("Login expirado"),
                ));
      } else {
        setState(() {
          withOutConnection = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Container(
      width: screenWidth,
      height: screenheight,
      decoration: const BoxDecoration(
        color: Color(0xffD9D9D9),
      ),
      alignment: Alignment.center,
      child: Visibility(
          visible: withOutConnection,
          replacement: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(30),
                child: Image.asset(
                  'assets/icons/icon.png',
                  width: screenWidth * 0.3,
                ),
              ),
              const CircularProgressIndicator(
                color: Colors.black,
              )
            ],
          ),
          child: Icon(
            Icons.wifi_off_outlined,
            color: const Color(0xffF5A636),
            size: screenWidth * 0.5,
          )),
    ));
  }
}
