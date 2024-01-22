// ignore_for_file: file_names, camel_case_types, unnecessary_cast, avoid_unnecessary_containers
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mercadopoupanca/components/AppAdvertsBar.dart';

class filterPage extends StatefulWidget {
  const filterPage({super.key});

  @override
  State<filterPage> createState() => _filterPage();
}

class _filterPage extends State<filterPage> {
  final _localStorage = Hive.box('localStorage');
  String url = 'https://mercadopoupanca.azurewebsites.net/product?';
  String finalUrl = '';
  bool plusOrder = false;
  bool asc = true;
  bool des = false;
  bool mercadona = false;
  bool aldi = false;
  bool lidl = false;
  bool continente = false;
  bool pingoDoce = false;

  void addUrl(value) {
    setState(() {
      if (des == true) {
        finalUrl = '${url}type=order&order=true&market=$value';
      } else {
        finalUrl = '${url}type=order&market=$value';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        children: [
          const AppAdvertsBar(),
          Container(
              color: const Color(0xffD9D9D9),
              height: screenheight * 0.93,
              width: screenWidth,
              child: Container(
                child: Column(
                  children: [
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
                            'Filtros',
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
                    Container(
                      margin: EdgeInsets.fromLTRB(0, screenheight * 0.01, 0, 0),
                      width: screenWidth * 0.9,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Ordenar por'),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (des == true) {
                                  des = !des;
                                }
                                if (asc != true) {
                                  asc = !asc;
                                }
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.fromLTRB(
                                  0, screenheight * 0.01, 0, 0),
                              width: screenWidth * 0.9,
                              height: screenheight * 0.07,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 9,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.fromLTRB(
                                        screenWidth * 0.04,
                                        0,
                                        screenWidth * 0.04,
                                        0),
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(
                                          color: const Color(0xffF5A636),
                                          width: 3),
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: asc
                                              ? const Color(0xffF5A636)
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      width: 10,
                                      height: 10,
                                    ),
                                  ),
                                  const Text(
                                    'Preço ascendente',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (asc == true) {
                                  asc = !asc;
                                }
                                if (des != true) {
                                  des = !des;
                                  finalUrl = '${url}type=order&order=true';
                                }
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.fromLTRB(
                                  0, screenheight * 0.01, 0, 0),
                              width: screenWidth * 0.9,
                              height: screenheight * 0.07,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 9,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.fromLTRB(
                                        screenWidth * 0.04,
                                        0,
                                        screenWidth * 0.04,
                                        0),
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(
                                          color: const Color(0xffF5A636),
                                          width: 3),
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: des
                                              ? const Color(0xffF5A636)
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      width: 10,
                                      height: 10,
                                    ),
                                  ),
                                  const Text(
                                    'Preço descendente',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, screenheight * 0.02, 0, 0),
                      width: screenWidth * 0.9,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Mercados'),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (mercadona == true) {
                                  mercadona = !mercadona;
                                } else {
                                  pingoDoce = false;
                                  aldi = false;
                                  lidl = false;
                                  continente = false;
                                  mercadona = !mercadona;
                                  addUrl('Mercadona');
                                }
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.fromLTRB(
                                  0, screenheight * 0.01, 0, 0),
                              width: screenWidth * 0.9,
                              height: screenheight * 0.07,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 9,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.fromLTRB(
                                        screenWidth * 0.04,
                                        0,
                                        screenWidth * 0.04,
                                        0),
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(
                                          color: const Color(0xffF5A636),
                                          width: 3),
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: mercadona
                                              ? const Color(0xffF5A636)
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      width: 10,
                                      height: 10,
                                    ),
                                  ),
                                  Image.network(
                                    'https://firebasestorage.googleapis.com/v0/b/mercadopoupanca-2aac2.appspot.com/o/stores%2Fmercadona.png?alt=media&token=8312a14c-a01c-46dd-883c-cb1175c776c9',
                                    width: screenWidth * 0.4,
                                    height: screenheight * 0.04,
                                  )
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (aldi == true) {
                                  aldi = !aldi;
                                } else {
                                  pingoDoce = false;
                                  aldi = !aldi;
                                  lidl = false;
                                  continente = false;
                                  mercadona = false;
                                  addUrl('Aldi');
                                }
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.fromLTRB(
                                  0, screenheight * 0.01, 0, 0),
                              width: screenWidth * 0.9,
                              height: screenheight * 0.07,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 9,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.fromLTRB(
                                        screenWidth * 0.04,
                                        0,
                                        screenWidth * 0.04,
                                        0),
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(
                                          color: const Color(0xffF5A636),
                                          width: 3),
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: aldi
                                              ? const Color(0xffF5A636)
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      width: 10,
                                      height: 10,
                                    ),
                                  ),
                                  Image.network(
                                    'https://firebasestorage.googleapis.com/v0/b/mercadopoupanca-2aac2.appspot.com/o/stores%2Faldi.png?alt=media&token=53e982d8-1f1a-48f0-98ee-11138b967b74',
                                    width: screenWidth * 0.2,
                                    height: screenheight * 0.04,
                                  )
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (lidl == true) {
                                  lidl = !lidl;
                                } else {
                                  pingoDoce = false;
                                  aldi = false;
                                  lidl = !lidl;
                                  continente = false;
                                  mercadona = false;
                                  addUrl('Lidl');
                                }
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.fromLTRB(
                                  0, screenheight * 0.01, 0, 0),
                              width: screenWidth * 0.9,
                              height: screenheight * 0.07,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 9,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.fromLTRB(
                                        screenWidth * 0.04,
                                        0,
                                        screenWidth * 0.04,
                                        0),
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(
                                          color: const Color(0xffF5A636),
                                          width: 3),
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: lidl
                                              ? const Color(0xffF5A636)
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      width: 10,
                                      height: 10,
                                    ),
                                  ),
                                  Image.network(
                                    'https://firebasestorage.googleapis.com/v0/b/mercadopoupanca-2aac2.appspot.com/o/stores%2Flidl.png?alt=media&token=6285ae8c-dae9-438b-af27-a4802c47afc1',
                                    width: screenWidth * 0.2,
                                    height: screenheight * 0.04,
                                  )
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (continente == true) {
                                  continente = !continente;
                                } else {
                                  pingoDoce = false;
                                  aldi = false;
                                  lidl = false;
                                  continente = !continente;
                                  mercadona = false;
                                  addUrl('Continente');
                                }
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.fromLTRB(
                                  0, screenheight * 0.01, 0, 0),
                              width: screenWidth * 0.9,
                              height: screenheight * 0.07,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 9,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.fromLTRB(
                                        screenWidth * 0.04,
                                        0,
                                        screenWidth * 0.04,
                                        0),
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(
                                          color: const Color(0xffF5A636),
                                          width: 3),
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: continente
                                              ? const Color(0xffF5A636)
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      width: 10,
                                      height: 10,
                                    ),
                                  ),
                                  Image.network(
                                    'https://firebasestorage.googleapis.com/v0/b/mercadopoupanca-2aac2.appspot.com/o/stores%2Fcontinente.png?alt=media&token=dd4115f8-f87b-4279-92f9-af59030bdc5e',
                                    width: screenWidth * 0.4,
                                    height: screenheight * 0.04,
                                  )
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (pingoDoce == true) {
                                pingoDoce = !pingoDoce;
                              } else {
                                pingoDoce = !pingoDoce;
                                aldi = false;
                                lidl = false;
                                continente = false;
                                mercadona = false;
                                addUrl('Pingo Doce');
                              }
                            },
                            child: Container(
                              margin: EdgeInsets.fromLTRB(
                                  0, screenheight * 0.01, 0, 0),
                              width: screenWidth * 0.9,
                              height: screenheight * 0.07,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 9,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.fromLTRB(
                                        screenWidth * 0.04,
                                        0,
                                        screenWidth * 0.04,
                                        0),
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(
                                          color: const Color(0xffF5A636),
                                          width: 3),
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: pingoDoce
                                              ? const Color(0xffF5A636)
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      width: 10,
                                      height: 10,
                                    ),
                                  ),
                                  Image.network(
                                    'https://firebasestorage.googleapis.com/v0/b/mercadopoupanca-2aac2.appspot.com/o/stores%2Fpingo%20doce.png?alt=media&token=8afba80c-a6af-4dcb-8cf4-b8d205ced295',
                                    width: screenWidth * 0.4,
                                    height: screenheight * 0.04,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        _localStorage.put('filterUrl', finalUrl);
                        _localStorage.put('searchStatus', 2);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        margin:
                            EdgeInsets.fromLTRB(0, screenheight * 0.05, 0, 0),
                        width: screenWidth * 0.4,
                        height: screenheight * 0.08,
                        decoration: BoxDecoration(
                            color: const Color(0xffF5A636),
                            borderRadius: BorderRadius.circular(50)),
                        child: const Text(
                          'APLICAR',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
