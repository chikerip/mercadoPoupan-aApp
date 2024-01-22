// ignore_for_file: file_names, camel_case_types, unnecessary_cast, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mercadopoupanca/components/AppAdvertsBar.dart';
import 'package:mercadopoupanca/pages/addPricePage/services/remote_services.dart';

class addPricePage extends StatefulWidget {
  final List<dynamic> data;
  const addPricePage({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<addPricePage> createState() => _addPricePage();
}

class _addPricePage extends State<addPricePage> {
  final _localStorage = Hive.box('localStorage');
  String productRef = '';
  double price = 0.00;
  String productName = '';
  String productImage = '';
  String productSize = '';
  int promo = 0;

  postData(body) async {
    final result = await RemoteServicesAddPrice().postDB(
        'https://mercadopoupanca.azurewebsites.net/product',
        _localStorage.get('token'),
        body);

    if (result != null) {
      _localStorage.put('backProduct', true);
      Navigator.of(context)
          .pushReplacementNamed('/product', arguments: productRef.toString());
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
                content: Text("Preço criado"),
              ));
    } else {
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
                content: Text("erro ao criar produto"),
              ));
    }
  }

  invalidParams() {
    showDialog(
        context: context,
        builder: (context) => const AlertDialog(
              content: Text("Algum parametro foi mal preenchido"),
            ));
  }

  putValuesInVar(listProduct) {
    setState(() {
      productRef = listProduct[0];
      productName = listProduct[1];
      productImage = listProduct[2];
      productSize = listProduct[3];
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    putValuesInVar(widget.data);

    return Scaffold(
      body: Column(
        children: [
          const AppAdvertsBar(),
          Expanded(
              child: Container(
                  color: const Color(0xffD9D9D9),
                  height: screenheight * 0.93,
                  width: screenWidth,
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      Column(
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
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(Icons.arrow_back_ios)),
                                const Text(
                                  'Adicionar preço',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: screenWidth * 0.1,
                                  height: screenheight * 0.1,
                                  child: Visibility(
                                    visible: false,
                                    child: IconButton(
                                        onPressed: () => {
                                              Navigator.of(context)
                                                  .pushNamed('/')
                                            },
                                        icon: const Icon(Icons.add)),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: 150,
                            width: 150,
                            child: Image.network(
                              productImage,
                              fit: BoxFit.cover,
                              width: 150,
                              height: 150,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(
                                0, screenheight * 0.03, 0, 0),
                            width: screenWidth * 0.9,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Codigo de barras'),
                                Container(
                                    margin: EdgeInsets.fromLTRB(
                                        0, screenheight * 0.01, 0, 0),
                                    padding: EdgeInsets.fromLTRB(
                                        screenWidth * 0.03, 0, 0, 0),
                                    alignment: Alignment.centerLeft,
                                    width: screenWidth * 0.9,
                                    height: screenheight * 0.07,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.5),
                                          spreadRadius: 3,
                                          blurRadius: 3,
                                          offset: const Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Text(
                                      productRef.toString(),
                                    )),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(
                                0, screenheight * 0.03, 0, 0),
                            width: screenWidth * 0.9,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Nome do produto'),
                                Container(
                                    margin: EdgeInsets.fromLTRB(
                                        0, screenheight * 0.01, 0, 0),
                                    padding: EdgeInsets.fromLTRB(
                                        screenWidth * 0.03, 0, 0, 0),
                                    alignment: Alignment.centerLeft,
                                    width: screenWidth * 0.9,
                                    height: screenheight * 0.07,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.5),
                                          spreadRadius: 3,
                                          blurRadius: 3,
                                          offset: const Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Text(
                                      productName.toString(),
                                    )),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(
                                0, screenheight * 0.03, 0, 0),
                            width: screenWidth * 0.9,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Tamanho do produto'),
                                Container(
                                    margin: EdgeInsets.fromLTRB(
                                        0, screenheight * 0.01, 0, 0),
                                    padding: EdgeInsets.fromLTRB(
                                        screenWidth * 0.03, 0, 0, 0),
                                    alignment: Alignment.centerLeft,
                                    width: screenWidth * 0.9,
                                    height: screenheight * 0.07,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.5),
                                          spreadRadius: 3,
                                          blurRadius: 3,
                                          offset: const Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Text(
                                      productSize.toString(),
                                    )),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(
                                0, screenheight * 0.03, 0, 0),
                            width: screenWidth * 0.9,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Preço do produto'),
                                Container(
                                  margin: EdgeInsets.fromLTRB(
                                      0, screenheight * 0.01, 0, 0),
                                  padding: EdgeInsets.fromLTRB(
                                      screenWidth * 0.03, 0, 0, 0),
                                  alignment: Alignment.centerLeft,
                                  width: screenWidth * 0.9,
                                  height: screenheight * 0.07,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.5),
                                        spreadRadius: 3,
                                        blurRadius: 3,
                                        offset: const Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: TextField(
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'x.xx',
                                      ),
                                      onChanged: (text) {
                                        setState(() {
                                          price = double.parse(text);
                                        });
                                      }),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(
                                0, screenheight * 0.03, 0, 0),
                            width: screenWidth * 0.9,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Promoção do produto'),
                                Container(
                                  margin: EdgeInsets.fromLTRB(
                                      0, screenheight * 0.01, 0, 0),
                                  padding: EdgeInsets.fromLTRB(
                                      screenWidth * 0.03, 0, 0, 0),
                                  alignment: Alignment.centerLeft,
                                  width: screenWidth * 0.9,
                                  height: screenheight * 0.07,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.5),
                                        spreadRadius: 3,
                                        blurRadius: 3,
                                        offset: const Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: TextField(
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText:
                                            'Insira caso tenha (numero inteiro sem %)',
                                      ),
                                      onChanged: (text) {
                                        setState(() {
                                          if (text == '') {
                                            promo = 0;
                                          } else {
                                            promo = int.parse(text);
                                          }
                                        });
                                      }),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (productImage == '' ||
                                  productName == '' ||
                                  price == 0.00 ||
                                  productRef == '') {
                                invalidParams();
                              } else {
                                final obj = {
                                  "productRef": productRef,
                                  "productImage": productImage,
                                  "productName": productName,
                                  "price": price,
                                  "promo": promo
                                };
                                postData(obj);
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.fromLTRB(0,
                                  screenheight * 0.05, 0, screenheight * 0.05),
                              width: screenWidth * 0.4,
                              height: screenheight * 0.08,
                              decoration: BoxDecoration(
                                  color: const Color(0xffF5A636),
                                  borderRadius: BorderRadius.circular(50)),
                              child: const Text(
                                'APLICAR',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ))),
        ],
      ),
    );
  }
}
