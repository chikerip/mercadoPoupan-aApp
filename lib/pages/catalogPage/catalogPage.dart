// ignore_for_file: file_names, prefer_const_constructors, camel_case_types
import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mercadopoupanca/components/AppAdvertsBar.dart';
import 'package:mercadopoupanca/components/bottomAppBar.dart';
import 'package:mercadopoupanca/pages/cartPage/models/shop.dart';
import 'package:mercadopoupanca/pages/catalogPage/models/post.dart';
import 'package:mercadopoupanca/pages/catalogPage/services/remote_services.dart';

class catalogPage extends StatefulWidget {
  const catalogPage({super.key});

  @override
  State<catalogPage> createState() => _catalogPageState();
}

class AppSeachBar extends StatefulWidget {
  const AppSeachBar({super.key});

  @override
  State<AppSeachBar> createState() => _AppSeachBar();
}

class AppBuilderContainer extends StatefulWidget {
  const AppBuilderContainer({super.key});

  @override
  State<AppBuilderContainer> createState() => _AppBuilderContainer();
}

class _catalogPageState extends State<catalogPage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
          top: false,
          //color: Color(0xffD9D9D9),
          child: Container(
            color: Color(0xffD9D9D9),
            child: Stack(
              children: [
                Column(
                  children: const [
                    AppAdvertsBar(),
                    AppSeachBar(),
                    AppBuilderContainer(),
                  ],
                ),
                Positioned(
                    left: 0,
                    bottom: 0,
                    child: SizedBox(
                      width: screenWidth,
                      height: screenheight * 0.11,
                      child: const HamburgerMenu(),
                    ))
              ],
            ),
          )),
    );
  }
}

class _AppSeachBar extends State<AppSeachBar> {
  final _localStorage = Hive.box('localStorage');
  String lastClick = '';
  bool pingodoce = false;
  bool mercadona = false;
  bool aldi = false;
  bool lidl = false;
  bool continente = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return SafeArea(
      top: false,
      right: false,
      child: Container(
        margin: EdgeInsets.fromLTRB(screenWidth * 0.02, screenheight * 0.03,
            screenWidth * 0.02, screenheight * 0.03),
        height: screenheight * 0.07,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            GestureDetector(
              onTap: () {
                if (lastClick == 'pingoDoce') {
                  _localStorage.put('catalogStatus', 'all');
                  setState(() {
                    lastClick = '';
                    pingodoce = false;
                  });
                } else {
                  setState(() {
                    lastClick = 'pingoDoce';
                    pingodoce = true;
                    mercadona = false;
                    lidl = false;
                    aldi = false;
                    continente = false;
                  });
                  _localStorage.put('catalogStatus', 'pingoDoce');
                }
              },
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 0, screenWidth * 0.03, 0),
                child: AnimatedContainer(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: pingodoce ? Color(0xffF5A636) : Colors.white,
                    border: Border.all(
                      color: Color(0xffF5A636),
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: screenWidth * 0.43,
                  duration: Duration(milliseconds: 300),
                  child: Image.network(
                      'https://firebasestorage.googleapis.com/v0/b/mercadopoupanca-2aac2.appspot.com/o/stores%2Fpingo%20doce.png?alt=media&token=8afba80c-a6af-4dcb-8cf4-b8d205ced295'),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (lastClick == 'mercadona') {
                  _localStorage.put('catalogStatus', 'all');
                  setState(() {
                    lastClick = '';
                    mercadona = false;
                  });
                } else {
                  setState(() {
                    lastClick = 'mercadona';
                    pingodoce = false;
                    mercadona = true;
                    lidl = false;
                    aldi = false;
                    continente = false;
                  });
                  _localStorage.put('catalogStatus', 'mercadona');
                }
              },
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 0, screenWidth * 0.03, 0),
                child: AnimatedContainer(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: mercadona ? Color(0xffF5A636) : Colors.white,
                    border: Border.all(
                      color: Color(0xffF5A636),
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: screenWidth * 0.43,
                  duration: Duration(milliseconds: 300),
                  child: Image.network(
                      'https://firebasestorage.googleapis.com/v0/b/mercadopoupanca-2aac2.appspot.com/o/stores%2Fmercadona.png?alt=media&token=8312a14c-a01c-46dd-883c-cb1175c776c9'),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (lastClick == 'lidl') {
                  _localStorage.put('catalogStatus', 'all');
                  setState(() {
                    lastClick = '';
                    lidl = false;
                  });
                } else {
                  setState(() {
                    lastClick = 'lidl';
                    pingodoce = false;
                    mercadona = false;
                    lidl = true;
                    aldi = false;
                    continente = false;
                  });
                  _localStorage.put('catalogStatus', 'lidl');
                }
              },
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 0, screenWidth * 0.03, 0),
                child: AnimatedContainer(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: lidl ? Color(0xffF5A636) : Colors.white,
                    border: Border.all(
                      color: Color(0xffF5A636),
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: screenWidth * 0.43,
                  duration: Duration(milliseconds: 300),
                  child: Image.network(
                      'https://firebasestorage.googleapis.com/v0/b/mercadopoupanca-2aac2.appspot.com/o/stores%2Flidl.png?alt=media&token=6285ae8c-dae9-438b-af27-a4802c47afc1'),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (lastClick == 'continente') {
                  _localStorage.put('catalogStatus', 'all');
                  setState(() {
                    lastClick = '';
                    continente = false;
                  });
                } else {
                  setState(() {
                    lastClick = 'continente';
                    pingodoce = false;
                    mercadona = false;
                    lidl = false;
                    aldi = false;
                    continente = true;
                  });
                  _localStorage.put('catalogStatus', 'continente');
                }
              },
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 0, screenWidth * 0.03, 0),
                child: AnimatedContainer(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: continente ? Color(0xffF5A636) : Colors.white,
                    border: Border.all(
                      color: Color(0xffF5A636),
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: screenWidth * 0.43,
                  duration: Duration(milliseconds: 300),
                  child: Image.network(
                      'https://firebasestorage.googleapis.com/v0/b/mercadopoupanca-2aac2.appspot.com/o/stores%2Fcontinente.png?alt=media&token=dd4115f8-f87b-4279-92f9-af59030bdc5e'),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (lastClick == 'aldi') {
                  _localStorage.put('catalogStatus', 'all');
                  setState(() {
                    lastClick = '';
                    aldi = false;
                  });
                } else {
                  setState(() {
                    lastClick = 'aldi';
                    pingodoce = false;
                    mercadona = false;
                    lidl = false;
                    aldi = true;
                    continente = false;
                  });
                  _localStorage.put('catalogStatus', 'aldi');
                }
              },
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 0, screenWidth * 0.03, 0),
                child: AnimatedContainer(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: aldi ? Color(0xffF5A636) : Colors.white,
                    border: Border.all(
                      color: Color(0xffF5A636),
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: screenWidth * 0.43,
                  duration: Duration(milliseconds: 300),
                  child: Image.network(
                      'https://firebasestorage.googleapis.com/v0/b/mercadopoupanca-2aac2.appspot.com/o/stores%2Faldi.png?alt=media&token=53e982d8-1f1a-48f0-98ee-11138b967b74'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AppBuilderContainer extends State<AppBuilderContainer> {
  final _localStorage = Hive.box('localStorage');
  List<Post>? posts;
  List<Post>? oldPost;
  bool isLoaded = false;
  int count = 0;

  @override
  void initState() {
    _localStorage.put('lastPage', '/catalog');
    super.initState();
    _localStorage.put('catalogStatus', 'all');
    Timer.periodic(const Duration(seconds: 1), (timer) {
      switch (_localStorage.get('catalogStatus')) {
        case 'all':
          getData('https://mercadopoupanca.azurewebsites.net/catalog', null);
          _localStorage.put('catalogStatus', null);
        case 'pingoDoce':
          getData(
              'https://mercadopoupanca.azurewebsites.net/catalog?market=Pingo Doce',
              null);
          _localStorage.put('catalogStatus', null);
        case 'mercadona':
          getData(
              'https://mercadopoupanca.azurewebsites.net/catalog?market=Mercadona',
              null);
          _localStorage.put('catalogStatus', null);
        case 'lidl':
          getData(
              'https://mercadopoupanca.azurewebsites.net/catalog?market=Lidl',
              null);
          _localStorage.put('catalogStatus', null);
        case 'continente':
          getData(
              'https://mercadopoupanca.azurewebsites.net/catalog?market=Continente',
              null);
          _localStorage.put('catalogStatus', null);
        case 'aldi':
          getData(
              'https://mercadopoupanca.azurewebsites.net/catalog?market=Aldi',
              null);
          _localStorage.put('catalogStatus', null);
        case 'cancel':
          timer.cancel();
        default:
      }
    });
  }

  selectedCart(barcode, market) {
    if (_localStorage.get('shop') == null ||
        _localStorage.get('shop') == '[]') {
      return false;
    } else {
      List<Shop>? cart = shopFromJson(_localStorage.get('shop'));
      if (cart.firstWhereOrNull((val) => val.product == barcode) != null) {
        if (cart.firstWhereOrNull((val) => val.store == market) != null) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    }
  }

  getData(url, body) async {
    setState(() {
      isLoaded = false;
    });
    posts = await RemoteServicesCatalog().getPosts(url, body);

    if (posts != null) {
      setState(() {
        oldPost = posts;
        isLoaded = true;
      });
    } else {
      // ignore: use_build_context_synchronously
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                content: Text("Mercado sem promoções"),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Expanded(
      child: Visibility(
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
        visible: isLoaded,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // number of items in each row
            mainAxisSpacing: screenheight * 0.01, // spacing between rows
            crossAxisSpacing: screenWidth * 0.05, // spacing between columns
            childAspectRatio: (0.78),
          ),
          padding:
              EdgeInsets.fromLTRB(screenWidth * 0.03, 0, screenWidth * 0.03, 0),
          itemCount: oldPost?.length,
          itemBuilder: (context, index) {
            bool incart = selectedCart(
                oldPost![index].barcode, oldPost![index].market[0].market);
            return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                width: screenWidth * 0.45,
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed('/product',
                                  arguments:
                                      oldPost![index].barcode.toString());
                            },
                            child: Container(
                              margin: EdgeInsets.fromLTRB(0,
                                  screenheight * 0.01, 0, screenheight * 0.01),
                              child: Image.network('${oldPost?[index].image}',
                                  height: screenheight * 0.13,
                                  width: screenWidth * 0.40),
                            )),
                        Container(
                          padding: EdgeInsets.all(screenWidth * 0.01),
                          width: screenWidth * 0.45,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${oldPost?[index].name}',
                                    style: TextStyle(
                                      fontSize:
                                          (screenWidth / screenheight) * 40,
                                    ),
                                  ),
                                  Text(
                                    '${oldPost?[index].size}',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '${oldPost?[index].market[0].price}€',
                                    style: TextStyle(
                                        color: Color(0xffF5A636),
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            (screenWidth / screenheight) * 40),
                                  ),
                                  Visibility(
                                      visible:
                                          (oldPost![index].market[0].promo > 0),
                                      child: Stack(
                                        children: [
                                          Text(
                                            '${((oldPost?[index].market[0].price)! + (oldPost![index].market[0].price * (oldPost![index].market[0].promo / 100))).toStringAsFixed(2)}€',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: (screenWidth /
                                                        screenheight) *
                                                    25),
                                          ),
                                          Positioned(
                                            bottom: screenheight * 0.005,
                                            child: Text(
                                              '_______',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: (screenWidth /
                                                          screenheight) *
                                                      25),
                                            ),
                                          ),
                                        ],
                                      )),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Visibility(
                      visible: (oldPost![index].market[0].promo > 0),
                      child: Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            height: screenheight * 0.05,
                            width: screenWidth * 0.15,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10)),
                              color: Color(0xffF5A636),
                            ),
                            child: Text(
                              '${oldPost?[index].market[0].promo}%',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: (screenWidth / screenheight) * 35,
                                  color: Colors.white),
                            ),
                          )),
                    ),
                    Positioned(
                        bottom: screenheight * 0.01,
                        child: Container(
                          margin: EdgeInsets.fromLTRB(screenWidth * 0.03,
                              screenheight * 0.01, screenWidth * 0.03, 0),
                          width: screenWidth * 0.38,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(oldPost![index].market[0].image,
                                      height: screenheight * 0.04,
                                      width: screenWidth * 0.20),
                                  Visibility(
                                      visible:
                                          (oldPost![index].market.length > 1),
                                      child: Text(
                                        'e mais outros',
                                        style: TextStyle(fontSize: (10)),
                                      )),
                                ],
                              ),
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      incart = true;
                                    });
                                    if (_localStorage.get('shop') == null ||
                                        _localStorage.get('shop') == '[]') {
                                      List<Shop> cart = [];

                                      cart.add(Shop(
                                          image: oldPost![index].image,
                                          product: oldPost![index].barcode,
                                          name: oldPost![index].name,
                                          size: oldPost![index].size,
                                          store:
                                              oldPost![index].market[0].market,
                                          storeImg:
                                              oldPost![index].market[0].image,
                                          price:
                                              oldPost![index].market[0].price,
                                          promo:
                                              oldPost![index].market[0].promo,
                                          amount: 1));

                                      final resultShop = shopToJson(cart);
                                      _localStorage.put('shop', resultShop);
                                    } else {
                                      int count = 0;
                                      bool foundItem = false;
                                      List<Shop> cart = shopFromJson(
                                          _localStorage.get('shop'));
                                      List<Shop> newCart = [];

                                      for (var element in cart) {
                                        if (element.product ==
                                                oldPost?[index].barcode &&
                                            element.store ==
                                                oldPost?[index]
                                                    .market[0]
                                                    .market) {
                                          setState(() {
                                            foundItem = true;
                                          });
                                          newCart.add(Shop(
                                              image: oldPost![index].image,
                                              product: oldPost![index].barcode,
                                              name: oldPost![index].name,
                                              size: oldPost![index].size,
                                              store: oldPost![index]
                                                  .market[0]
                                                  .market,
                                              storeImg: oldPost![index]
                                                  .market[0]
                                                  .image,
                                              price: oldPost![index]
                                                  .market[0]
                                                  .price,
                                              promo: oldPost![index]
                                                  .market[0]
                                                  .promo,
                                              amount: element.amount + 1));
                                        } else {
                                          if (cart.isNotEmpty) {
                                            newCart.add(Shop(
                                                image: element.image,
                                                product: element.product,
                                                name: element.name,
                                                size: element.size,
                                                store: element.store,
                                                storeImg: element.storeImg,
                                                price: element.price,
                                                promo: element.promo,
                                                amount: element.amount));
                                          }
                                        }
                                        setState(() {
                                          count++;
                                        });
                                        if (count == cart.length) {
                                          if (foundItem == false) {
                                            newCart.add(Shop(
                                                image: oldPost![index].image,
                                                product:
                                                    oldPost![index].barcode,
                                                name: oldPost![index].name,
                                                size: oldPost![index].size,
                                                store: oldPost![index]
                                                    .market[0]
                                                    .market,
                                                storeImg: oldPost![index]
                                                    .market[0]
                                                    .image,
                                                price: oldPost![index]
                                                    .market[0]
                                                    .price,
                                                promo: oldPost![index]
                                                    .market[0]
                                                    .promo,
                                                amount: 1));
                                          }

                                          final resultShop =
                                              shopToJson(newCart);
                                          _localStorage.put('shop', resultShop);
                                        }
                                      }
                                    }
                                  },
                                  child: Image.asset(
                                    incart
                                        ? 'assets/icons/bagpainted.png'
                                        : 'assets/icons/bag.png',
                                    width: screenWidth * 0.05,
                                  )),
                            ],
                          ),
                        ))
                  ],
                ));
          },
        ),
      ),
    );
  }
}
