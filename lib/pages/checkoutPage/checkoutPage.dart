// ignore_for_file: file_names, camel_case_types, unnecessary_cast, unnecessary_new, non_constant_identifier_names, use_build_context_synchronously
import 'dart:async';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mercadopoupanca/components/AppAdvertsBar.dart';
import 'package:mercadopoupanca/pages/accountPage/models/post.dart';
import 'package:mercadopoupanca/pages/accountPage/services/remote_services.dart';
import 'package:mercadopoupanca/pages/checkoutPage/models/post.dart';
import 'package:mercadopoupanca/pages/checkoutPage/services/remote_services.dart';
import 'package:mercadopoupanca/pages/statusShopPage/model/post.dart';

class checkoutPage extends StatefulWidget {
  final double data;
  const checkoutPage({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<checkoutPage> createState() => _checkoutPage();
}

class _checkoutPage extends State<checkoutPage> {
  final _localStorage = Hive.box('localStorage');
  Timer? searchOnStoppedTyping;
  List<Post>? apiPost;
  List<Promo>? promo;
  List<AddCart>? msgCart;
  bool isLoaded = false;
  bool typePromo = true;
  bool isPost = false;
  double totalInt = 0;
  String total = '';
  String discount = '---';
  String name = '';
  String postal = '';
  String cidade = '';

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    apiPost = await RemoteServicesAccount().getPosts(
        'https://mercadopoupanca.azurewebsites.net/user?type=userInfo',
        _localStorage.get('token'));

    if (apiPost != null) {
      separateAdress(apiPost![0].adress);
    } else {
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
                content: Text("Login expirado"),
              ));
      _localStorage.put("token", null);
      Navigator.of(context).pushNamed('/login');
    }
  }

  void separateAdress(adress) {
    int length = adress.length - 1;
    int find = 0;
    bool loop = false;
    String Word = '';

    while (loop == false) {
      if (adress[length] == ',') {
        setState(() {
          find++;
        });
      } else {
        setState(() {
          Word += adress[length];
        });
      }

      length--;

      switch (find) {
        case 1:
          List<String> characters = Word.split('');
          setState(() {
            cidade = characters.reversed.join();
            Word = '';
            find++;
          });
        case 3:
          List<String> characters = Word.split('');
          setState(() {
            name = adress.substring(0, length + 1);
            postal = characters.reversed.join();
            loop = true;
            isLoaded = true;
          });
      }
    }
  }

  void postData() async {
    setState(() {
      isPost = true;
    });
    msgCart = await RemoteServicesCart().postCart(
        'https://mercadopoupanca.azurewebsites.net/order',
        _localStorage.get('token'),
        _localStorage.get('shop'));
    if (msgCart != null) {
      Navigator.of(context).pushReplacementNamed('/resultShop',
          arguments: [true, msgCart![0].id, total]);
      _localStorage.put('shop', null);
    } else {
      Navigator.of(context)
          .pushReplacementNamed('/resultShop', arguments: [false, 0, 0]);
    }
  }

  void getDiscount(code) async {
    promo = await RemoteServicesCart().getDiscount(
        'https://mercadopoupanca.azurewebsites.net/promo?code=$code');

    if (promo != null) {
      setState(() {
        discount = (totalInt * (promo![0].promoCode / 100)).toStringAsFixed(2);
        total = (totalInt - (totalInt * (promo![0].promoCode / 100)))
            .toStringAsFixed(2);
      });
    }
  }

  _onChangeHandler(value) {
    const duration = Duration(
        milliseconds:
            800); // set the duration that you want call search() after that.
    if (searchOnStoppedTyping != null) {
      setState(() => searchOnStoppedTyping!.cancel()); // clear timer
    }
    setState(() =>
        searchOnStoppedTyping = new Timer(duration, () => getDiscount(value)));
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    if (isLoaded == false) {
      setState(() {
        totalInt = widget.data;
        total = (widget.data).toString();
      });
    }

    return Scaffold(
      body: Container(
          color: const Color(0xffD9D9D9),
          child: Stack(
            children: [
              Column(
                children: [
                  const AppAdvertsBar(),
                  Container(
                    width: screenWidth * 0.92,
                    height: screenheight * 0.1,
                    color: const Color(0xffD9D9D9),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.arrow_back_ios)),
                        const Text(
                          'Checkout',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: screenWidth * 0.1,
                          height: screenheight * 0.1,
                          child: Visibility(
                            visible: false,
                            child: IconButton(
                                onPressed: () =>
                                    {Navigator.of(context).pushNamed('/')},
                                icon: const Icon(Icons.add)),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Visibility(
                        visible: isLoaded,
                        replacement: const Center(
                          child: CircularProgressIndicator(),
                        ),
                        child: ListView(
                          scrollDirection: Axis.vertical,
                          children: [
                            Container(
                              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                'Enviar para',
                                style: TextStyle(
                                    color: Color(0xff888888),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.fromLTRB(20, 3, 20, 10),
                              child: Container(
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: const Color(0xffF5A636),
                                          width: 3),
                                      borderRadius: BorderRadius.circular(15)),
                                  height: screenheight * 0.14,
                                  child: Stack(
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'CASA',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(name),
                                          Text(postal),
                                          Text(cidade)
                                        ],
                                      ),
                                      Positioned(
                                        top: 0,
                                        right: -10,
                                        child: Container(
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.fromLTRB(
                                              screenWidth * 0.04,
                                              0,
                                              screenWidth * 0.04,
                                              0),
                                          width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            border: Border.all(
                                                color: const Color(0xffF5A636),
                                                width: 3),
                                          ),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: const Color(0xffF5A636),
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                            width: 10,
                                            height: 10,
                                          ),
                                        ),
                                      )
                                    ],
                                  )),
                            ),
                            Container(
                              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                'Pagar com',
                                style: TextStyle(
                                    color: Color(0xff888888),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.fromLTRB(20, 3, 20, 10),
                              child: Container(
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: const Color(0xffF5A636),
                                          width: 3),
                                      borderRadius: BorderRadius.circular(15)),
                                  height: screenheight * 0.07,
                                  child: Stack(
                                    children: [
                                      const Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'CONTRA-REEMBOLSO',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      Positioned(
                                        top: 0,
                                        right: -10,
                                        child: Container(
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.fromLTRB(
                                              screenWidth * 0.04,
                                              0,
                                              screenWidth * 0.04,
                                              0),
                                          width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            border: Border.all(
                                                color: const Color(0xffF5A636),
                                                width: 3),
                                          ),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: const Color(0xffF5A636),
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                            width: 10,
                                            height: 10,
                                          ),
                                        ),
                                      )
                                    ],
                                  )),
                            ),
                          ],
                        )),
                  ),
                ],
              ),
              Visibility(
                visible: isLoaded,
                child: Positioned(
                    bottom: 0,
                    child: SizedBox(
                      height: screenheight * 0.35,
                      width: screenWidth,
                      child: Column(
                        children: [
                          Visibility(
                            visible: isPost,
                            replacement: GestureDetector(
                              onTap: () {
                                postData();
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: screenheight * 0.06,
                                width: screenWidth * 0.45,
                                decoration: BoxDecoration(
                                    color: const Color(0xffF5A636),
                                    borderRadius: BorderRadius.circular(50)),
                                child: const Text(
                                  'PAGAR',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                            ),
                            child: Container(
                                alignment: Alignment.center,
                                height: screenheight * 0.06,
                                width: screenWidth * 0.45,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50)),
                                child: const CircularProgressIndicator()),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(
                                0, screenheight * 0.03, 0, 0),
                            height: screenheight * 0.26,
                            width: screenWidth,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                                color: Color(0xffF5A636),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(20))),
                            child: SizedBox(
                              height: screenheight * 0.2,
                              width: screenWidth * 0.9,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  DottedBorder(
                                    borderType: BorderType.RRect,
                                    radius: const Radius.circular(20),
                                    color: Colors.white,
                                    dashPattern: const [15, 8],
                                    strokeWidth: 2,
                                    child: SizedBox(
                                      width: screenWidth * 0.9,
                                      height: screenheight * 0.05,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Visibility(
                                            visible: typePromo,
                                            child: const Icon(
                                              Icons.discount,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(
                                            width: screenWidth * 0.5,
                                            child: Expanded(
                                              child: TextField(
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  decoration: const InputDecoration(
                                                      border: InputBorder.none,
                                                      hintText:
                                                          ' Promo code (opcional)',
                                                      hintStyle: TextStyle(
                                                          color: Colors.white)),
                                                  onChanged: (text) {
                                                    _onChangeHandler(text);
                                                    setState(() {
                                                      typePromo = false;
                                                    });
                                                  }),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: screenWidth * 0.9,
                                    height: screenheight * 0.04,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Descontos:',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Text(
                                          '$discount€',
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: screenWidth * 0.9,
                                    height: 1,
                                    decoration: ShapeDecoration(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(2)),
                                    ),
                                  ),
                                  SizedBox(
                                    width: screenWidth * 0.9,
                                    height: screenheight * 0.04,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'TOTAL:',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          '$total€',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              )
            ],
          )),
    );
  }
}
