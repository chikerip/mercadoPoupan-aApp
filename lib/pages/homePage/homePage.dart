// ignore_for_file: file_names, prefer_const_constructors
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mercadopoupanca/components/AppAdvertsBar.dart';
import 'package:mercadopoupanca/components/bottomAppBar.dart';
import 'package:mercadopoupanca/pages/cartPage/models/shop.dart';
import 'package:mercadopoupanca/pages/homePage/models/post.dart';
import 'package:mercadopoupanca/pages/homePage/services/remote_services.dart';
import 'package:collection/collection.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
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

class _MyHomePageState extends State<MyHomePage> {
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

class _AppBuilderContainer extends State<AppBuilderContainer> {
  final _localStorage = Hive.box('localStorage');
  List<Post>? posts;
  List<Post>? oldPost;
  bool loaded = false;
  bool contentLoaded = false;

  @override
  void initState() {
    _localStorage.put('lastPage', '/');
    _localStorage.put('searchStatus', 0);
    super.initState();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      switch (_localStorage.get('searchStatus')) {
        case 0:
          getData('https://mercadopoupanca.azurewebsites.net/product', null);
          _localStorage.put('searchStatus', null);
        case 1:
          getData('https://mercadopoupanca.azurewebsites.net/product?type=name',
              _localStorage.get('search'));
          _localStorage.put('searchStatus', null);
        case 2:
          getData(_localStorage.get('filterUrl'), null);
          _localStorage.put('searchStatus', null);
        case 'cancel':
          timer.cancel();
        default:
          if (loaded == false) {
            setState(() {
              loaded = true;
            });
            getData('https://mercadopoupanca.azurewebsites.net/product', null);
          }
      }
    });
  }

  selectedCart(barcode) {
    if (_localStorage.get('shop') == null ||
        _localStorage.get('shop') == '[]') {
      return false;
    } else {
      List<Shop>? cart = shopFromJson(_localStorage.get('shop'));
      if (cart.firstWhereOrNull((val) => val.product == barcode) != null) {
        return true;
      } else {
        return false;
      }
    }
  }

  getData(url, body) async {
    setState(() {
      contentLoaded = false;
    });

    posts = await RemoteServices().getPosts(url, body);

    if (posts != null) {
      setState(() {
        oldPost = posts;
        contentLoaded = true;
      });
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
        visible: contentLoaded,
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
            bool incart = selectedCart(oldPost![index].barcode);
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
                                          store: oldPost![index].market[0].name,
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
                                                    .name) {
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
                                                  .name,
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
                                                    .name,
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

class _AppSeachBar extends State<AppSeachBar> {
  final _localStorage = Hive.box('localStorage');

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return SafeArea(
        top: false,
        child: Container(
          padding:
              EdgeInsets.fromLTRB(screenWidth * 0.03, 0, screenWidth * 0.03, 0),
          height: screenheight * 0.09,
          width: screenWidth,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(
                    screenWidth * 0.02, 0, screenWidth * 0.02, 0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                width: screenWidth * 0.6,
                child: TextField(
                    decoration: const InputDecoration(
                        border: InputBorder.none, hintText: "Pesquise aqui"),
                    onChanged: (text) {
                      _localStorage.put('searchStatus', 1);
                      _localStorage.put('search', {"productRef": text});
                    }),
              ),
              // ignore: sized_box_for_whitespace
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.white,
                ),
                child: IconButton(
                    onPressed: () => {
                          Navigator.of(context)
                              .pushNamed('/filter', arguments: null),
                        },
                    icon: Image.asset(
                      'assets/icons/filters.png',
                      width: screenWidth * 0.06,
                    )),
              ),

              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.white,
                ),
                child: IconButton(
                    onPressed: () => {
                          Navigator.of(context)
                              .pushNamed('/scan', arguments: null),
                        },
                    icon: Image.asset(
                      'assets/icons/scan.png',
                      width: screenWidth * 0.06,
                    )),
              ),
            ],
          ),
        ));
  }
}
