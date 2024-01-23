// ignore_for_file: file_names, camel_case_types, unnecessary_cast, avoid_unnecessary_containers
import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mercadopoupanca/components/AppAdvertsBar.dart';
import 'package:mercadopoupanca/pages/cartPage/models/shop.dart';
import 'package:mercadopoupanca/pages/homePage/models/post.dart';
import 'package:mercadopoupanca/pages/homePage/services/remote_services.dart';

class productsPage extends StatefulWidget {
  final String data;
  const productsPage({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<productsPage> createState() => _productsPage();
}

class _productsPage extends State<productsPage> {
  final _localStorage = Hive.box('localStorage');
  List<Post>? posts;
  List<Post>? oldPost;
  List<dynamic> array = [];
  bool isLoaded = false;
  bool newProduct = false;
  int marketLength = 0;

  @override
  void initState() {
    super.initState();

    Timer.periodic(const Duration(seconds: 5), (timer) {
      if (isLoaded == false) {
        setState(() {
          newProduct = true;
        });
        timer.cancel();
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

  getData(productRef) async {
    posts = await RemoteServices().getPosts(
        'https://mercadopoupanca.azurewebsites.net/product?type=barcode',
        {"productRef": productRef});

    if (posts != null) {
      setState(() {
        oldPost = posts;
        isLoaded = true;
        marketLength = posts![0].market.length;
        array.add(posts![0].barcode);
        array.add(posts![0].name);
        array.add(posts![0].image);
        array.add(posts![0].size);
      });
    }
  }

  productInCart(index) {
    if (_localStorage.get('shop') == null ||
        _localStorage.get('shop') == '[]') {
      List<Shop> cart = [];

      cart.add(Shop(
          image: posts![0].image,
          product: posts![0].barcode,
          name: posts![0].name,
          size: posts![0].size,
          store: posts![0].market[index].name,
          storeImg: posts![0].market[index].image,
          price: posts![0].market[index].price,
          promo: posts![0].market[index].promo,
          amount: 1));

      final resultShop = shopToJson(cart);
      _localStorage.put('shop', resultShop);
    } else {
      int count = 0;
      bool foundItem = false;
      List<Shop> cart = shopFromJson(_localStorage.get('shop'));
      List<Shop> newCart = [];

      for (var element in cart) {
        if (element.product == posts?[0].barcode &&
            element.store == posts?[0].market[index].name) {
          setState(() {
            foundItem = true;
          });
          newCart.add(Shop(
              image: posts![0].image,
              product: posts![0].barcode,
              name: posts![0].name,
              size: posts![0].size,
              store: posts![0].market[index].name,
              storeImg: posts![0].market[index].image,
              price: posts![0].market[index].price,
              promo: posts![0].market[index].promo,
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
                image: posts![0].image,
                product: posts![0].barcode,
                name: posts![0].name,
                size: posts![0].size,
                store: posts![0].market[index].name,
                storeImg: posts![0].market[index].image,
                price: posts![0].market[index].price,
                promo: posts![0].market[index].promo,
                amount: 1));
          }

          final resultShop = shopToJson(newCart);
          _localStorage.put('shop', resultShop);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    String product = widget.data;
    if (isLoaded == false) {
      getData(product);
    }

    return Scaffold(
      backgroundColor: const Color(0xffD9D9D9),
      body: Column(
        children: [
          const AppAdvertsBar(),
          SizedBox(
            width: screenWidth * 0.92,
            height: screenheight * 0.1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      if (_localStorage.get('backProduct') == true) {
                        _localStorage.put('backProduct', null);
                        _localStorage.put('searchStatus', 'cancel');
                        Navigator.of(context).pushReplacementNamed('/');
                      } else {
                        Navigator.of(context).pushReplacementNamed('/scan');
                        _localStorage.put('scanned', false);
                      }
                    },
                    icon: const Icon(Icons.arrow_back_ios)),
                const Text(
                  'Detalhes',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: screenWidth * 0.1,
                  height: screenheight * 0.1,
                  child: Visibility(
                    visible:
                        (_localStorage.get('admin') == 1 && isLoaded == true),
                    child: IconButton(
                        onPressed: () => {
                              Navigator.of(context).pushReplacementNamed(
                                  '/addPrice',
                                  arguments: array),
                            },
                        icon: const Icon(Icons.add)),
                  ),
                )
              ],
            ),
          ),
          Expanded(
              child: Visibility(
                  visible: isLoaded,
                  replacement: Center(
                    child: Visibility(
                      visible: newProduct,
                      replacement: const CircularProgressIndicator(),
                      child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed('/addProduct',
                                arguments: widget.data);
                          },
                          child: const Icon(Icons.add)),
                    ),
                  ),
                  child: ListView.builder(
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        bool inCart = selectedCart(
                            posts![0].barcode, posts![0].market[0].name);
                        return Container(
                          padding: EdgeInsets.all(screenWidth * 0.05),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(screenWidth * 0.05),
                                width: screenWidth * 0.9,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 3,
                                      offset: const Offset(
                                          0, 5), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Image.network(
                                  posts![0].image,
                                  width: screenWidth * 0.8,
                                ),
                              ),
                              Container(
                                  width: screenWidth * 0.9,
                                  padding: EdgeInsets.all(screenWidth * 0.05),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        posts![0].name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      Text(
                                        posts![0].size,
                                        style: const TextStyle(
                                            fontSize: 18, color: Colors.grey),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.fromLTRB(
                                            0, 15, 0, 15),
                                        width: screenWidth * 0.8,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Image.network(
                                              posts![0].market[0].image,
                                              width: screenWidth * 0.3,
                                            ),
                                            SizedBox(
                                              width:
                                                  (posts![0].market[0].promo >
                                                          0)
                                                      ? screenWidth * 0.31
                                                      : screenWidth * 0.23,
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Visibility(
                                                    visible: posts![0]
                                                            .market[0]
                                                            .promo >
                                                        0,
                                                    child: Stack(
                                                      children: [
                                                        Text(
                                                          '${((posts?[0].market[0].price)! + (posts![0].market[0].price * (posts![0].market[0].promo / 100))).toStringAsFixed(2)}€',
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                        const Positioned(
                                                          bottom: 5,
                                                          child: Text(
                                                            '_______',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Text(
                                                    '${posts![0].market[0].price}€',
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0xFFF5A636),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        inCart = true;
                                                      });
                                                      productInCart(0);
                                                    },
                                                    child: Image.asset(
                                                      inCart
                                                          ? 'assets/icons/bagpainted.png'
                                                          : 'assets/icons/bag.png',
                                                      width: screenWidth * 0.05,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Visibility(
                                        visible: (posts![0].market.length >= 2),
                                        child: const Text(
                                          'Outros Vendedores',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                      ),
                                      SingleChildScrollView(
                                        child: Column(
                                          children: <Widget>[
                                            ListView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemCount:
                                                    (posts![0].market.length -
                                                        1),
                                                itemBuilder: (context, index) {
                                                  bool inCart2 = selectedCart(
                                                      posts![0].barcode,
                                                      posts![0]
                                                          .market[index + 1]
                                                          .name);
                                                  return Container(
                                                    margin: const EdgeInsets
                                                        .fromLTRB(0, 15, 0, 15),
                                                    width: screenWidth * 0.8,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Image.network(
                                                          posts![0]
                                                              .market[index + 1]
                                                              .image,
                                                          width:
                                                              screenWidth * 0.3,
                                                        ),
                                                        SizedBox(
                                                          width: (posts![0]
                                                                      .market[
                                                                          index +
                                                                              1]
                                                                      .promo >
                                                                  0)
                                                              ? screenWidth *
                                                                  0.31
                                                              : screenWidth *
                                                                  0.23,
                                                          child: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .end,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Visibility(
                                                                visible: posts![
                                                                            0]
                                                                        .market[
                                                                            index +
                                                                                1]
                                                                        .promo >
                                                                    0,
                                                                child: Stack(
                                                                  children: [
                                                                    Text(
                                                                      '${((posts?[0].market[index + 1].price)! + (posts![0].market[index + 1].price * (posts![0].market[index + 1].promo / 100))).toStringAsFixed(2)}€',
                                                                      style:
                                                                          const TextStyle(
                                                                        color: Colors
                                                                            .grey,
                                                                      ),
                                                                    ),
                                                                    const Positioned(
                                                                      bottom: 5,
                                                                      child:
                                                                          Text(
                                                                        '_______',
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.grey,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Text(
                                                                '${posts![0].market[index + 1].price}€',
                                                                style: const TextStyle(
                                                                    color: Color(
                                                                        0xFFF5A636),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        18),
                                                              ),
                                                              GestureDetector(
                                                                onTap: () {
                                                                  setState(() {
                                                                    inCart2 =
                                                                        true;
                                                                  });
                                                                  productInCart(
                                                                      index +
                                                                          1);
                                                                },
                                                                child:
                                                                    Image.asset(
                                                                  inCart2
                                                                      ? 'assets/icons/bagpainted.png'
                                                                      : 'assets/icons/bag.png',
                                                                  width:
                                                                      screenWidth *
                                                                          0.05,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                }),
                                          ],
                                        ),
                                      )
                                    ],
                                  )),
                            ]),
                          ),
                        );
                      }))),
        ],
      ),
    );
  }
}
