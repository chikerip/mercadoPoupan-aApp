// ignore_for_file: file_names, camel_case_types, unnecessary_cast
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mercadopoupanca/components/AppAdvertsBar.dart';
import 'package:mercadopoupanca/pages/cartPage/models/shop.dart';

class cartPage extends StatefulWidget {
  const cartPage({super.key});

  @override
  State<cartPage> createState() => _cartPage();
}

class _cartPage extends State<cartPage> {
  final _localStorage = Hive.box('localStorage');
  List<Shop>? cart;
  List<Shop>? newCart;
  double totalProducts = 0;
  int items = 0;
  bool isLoaded = false;
  bool withoutCart = false;

  @override
  void initState() {
    super.initState();

    if (_localStorage.get('shop') != null) {
      getData(shopFromJson(_localStorage.get('shop')));
    } else {
      setState(() {
        withoutCart = true;
      });
    }
  }

  void getData(data) {
    setState(() {
      items = 0;
      totalProducts = 0;
    });
    int count = 0;
    cart = data;

    if (cart!.isNotEmpty) {
      for (var element in cart!) {
        setState(() {
          totalProducts += element.price * element.amount;
          items += element.amount;
          count++;
        });

        if (count == cart?.length) {
          setState(() {
            newCart = cart;
            isLoaded = true;
          });
        }
      }
    } else {
      setState(() {
        withoutCart = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

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
                              Navigator.of(context).pushReplacementNamed(
                                  _localStorage.get('lastPage'));
                            },
                            icon: const Icon(Icons.arrow_back_ios)),
                        const Text(
                          'Cesto',
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
                    child: SizedBox(
                      width: screenWidth * 0.9,
                      child: Visibility(
                        visible: isLoaded,
                        replacement: Visibility(
                            visible: withoutCart,
                            replacement: const Center(
                              child: CircularProgressIndicator(),
                            ),
                            child: const Center(
                              child: Text('Não tem nenhum artigo no carrinho'),
                            )),
                        child: ListView.builder(
                            itemCount: newCart?.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.fromLTRB(
                                    0,
                                    screenheight * 0.01,
                                    0,
                                    screenheight * 0.01),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 1,
                                      offset: const Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                height: screenheight * 0.13,
                                child: Row(
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          width: screenWidth * 0.3,
                                          height: screenheight * 0.13,
                                          alignment: Alignment.center,
                                          child: Image.network(
                                            newCart![index].image,
                                            width: screenWidth * 0.29,
                                            height: screenheight * 0.12,
                                          ),
                                        ),
                                        Visibility(
                                          visible: (newCart![index].promo > 0),
                                          child: Positioned(
                                              top: 0,
                                              right: 0,
                                              child: Container(
                                                height: screenheight * 0.05,
                                                width: screenWidth * 0.15,
                                                alignment: Alignment.center,
                                                decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  10),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  10)),
                                                  color: Color(0xffF5A636),
                                                ),
                                                child: Text(
                                                  '${newCart![index].promo}%',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: (screenWidth /
                                                              screenheight) *
                                                          35,
                                                      color: Colors.white),
                                                ),
                                              )),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      width: screenWidth * 0.6,
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: screenWidth * 0.6,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        newCart![index].name,
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18),
                                                      ),
                                                      Text(
                                                        newCart![index].size,
                                                        style: const TextStyle(
                                                            color: Colors.grey),
                                                      ),
                                                    ],
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.of(context)
                                                          .pushReplacementNamed(
                                                              '/cart');
                                                      List<Shop> reformCart =
                                                          [];
                                                      int i = 0;
                                                      for (var element
                                                          in newCart!) {
                                                        if (element.product !=
                                                                newCart![index]
                                                                    .product &&
                                                            element.store !=
                                                                newCart![index]
                                                                    .store) {
                                                          reformCart.add(Shop(
                                                              image:
                                                                  element.image,
                                                              product: element
                                                                  .product,
                                                              name:
                                                                  element.name,
                                                              size:
                                                                  element.size,
                                                              store:
                                                                  element.store,
                                                              storeImg: element
                                                                  .storeImg,
                                                              price:
                                                                  element.price,
                                                              promo:
                                                                  element.promo,
                                                              amount: element
                                                                  .amount));
                                                        }

                                                        setState(() {
                                                          i++;
                                                        });

                                                        if (i ==
                                                            newCart!.length) {
                                                          _localStorage.put(
                                                              'shop',
                                                              shopToJson(
                                                                  reformCart));
                                                          getData(reformCart);
                                                        }
                                                      }
                                                    },
                                                    child: const Icon(
                                                        Icons.delete),
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: screenWidth * 0.6,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '${newCart![index].price * newCart![index].amount}€',
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0xffF5A636),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15),
                                                  ),
                                                  Visibility(
                                                      visible: (newCart![index]
                                                              .promo >
                                                          0),
                                                      child: Stack(
                                                        children: [
                                                          Text(
                                                            '${(((newCart![index].price) + (newCart![index].price * (newCart![index].promo / 100))) * newCart![index].amount).toStringAsFixed(2)}€',
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontSize:
                                                                        12),
                                                          ),
                                                          const Positioned(
                                                            bottom: 2.6,
                                                            child: Text(
                                                              '_______',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                        ],
                                                      )),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: screenWidth * 0.6,
                                              height: screenheight * 0.03,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Image.network(
                                                    newCart![index].storeImg,
                                                    height: screenWidth * 0.1,
                                                    width: screenWidth * 0.3,
                                                  ),
                                                  Text(
                                                    '${newCart![index].amount}',
                                                    style: const TextStyle(
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ]),
                                    )
                                  ],
                                ),
                              );
                            }),
                      ),
                    ),
                  )
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
                          GestureDetector(
                            onTap: () {
                              if (_localStorage.get('token') != null) {
                                Navigator.of(context).pushNamed('/checkout',
                                    arguments: (totalProducts + 2.50));
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (context) => const AlertDialog(
                                          content: Text(
                                              "Percisa de uma conta para continua a compra"),
                                        ));
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: screenheight * 0.06,
                              width: screenWidth * 0.45,
                              decoration: BoxDecoration(
                                  color: const Color(0xffF5A636),
                                  borderRadius: BorderRadius.circular(50)),
                              child: const Text(
                                'CHECKOUT',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                            ),
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
                                children: [
                                  SizedBox(
                                    width: screenWidth * 0.9,
                                    height: screenheight * 0.04,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Subtotal:',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Text(
                                          '$totalProducts€',
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: screenWidth * 0.9,
                                    height: screenheight * 0.04,
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Taxa de envio:',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Text(
                                          '2,50€',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
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
                                          'Numero de artigos:',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Text(
                                          '$items',
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
                                          '${(totalProducts + 2.50).toStringAsFixed(2)}€',
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
