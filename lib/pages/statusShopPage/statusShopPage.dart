// ignore_for_file: camel_case_types, file_names

import 'package:flutter/material.dart';
import 'package:mercadopoupanca/components/AppAdvertsBar.dart';

class statusShopPage extends StatefulWidget {
  final List<dynamic> data;
  const statusShopPage({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<statusShopPage> createState() => _statusShopPage();
}

class _statusShopPage extends State<statusShopPage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        children: [
          const AppAdvertsBar(),
          Container(
              alignment: Alignment.center,
              color: const Color(0xffD9D9D9),
              height: screenheight * 0.93,
              width: screenWidth,
              child: Visibility(
                  visible: widget.data[0],
                  replacement: SizedBox(
                    height: screenheight * 0.45,
                    width: screenWidth * 0.9,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: screenheight * 0.15,
                          width: screenheight * 0.15,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(150),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                              border: Border.all(
                                  color: const Color(0xffF5A636), width: 8)),
                          child: Container(
                            height: screenheight * 0.115,
                            width: screenheight * 0.115,
                            decoration: BoxDecoration(
                              color: const Color(0xffF5A636),
                              borderRadius: BorderRadius.circular(150),
                            ),
                            child: const Icon(
                              Icons.close_rounded,
                              color: Colors.white,
                              size: 75,
                            ),
                          ),
                        ),
                        const Text(
                          'Pagamento não sucedido!',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Color(0xffF5A636),
                              fontSize: 16),
                        ),
                        const Text(
                          'Infelizmente o seu pagamento não teve sucesso, tente novamente para processar a sua encomenda.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          width: screenWidth * 0.9,
                          height: 1,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFF5A636),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(2)),
                          ),
                        ),
                        Container(
                          height: screenheight * 0.08,
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: screenheight * 0.06,
                            width: screenWidth * 0.35,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: const Color(0xffF5A636),
                              borderRadius: BorderRadius.circular(100),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: const Text(
                              'Voltar',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  child: SizedBox(
                    height: screenheight * 0.55,
                    width: screenWidth * 0.9,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: screenheight * 0.15,
                          width: screenheight * 0.15,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(150),
                              border: Border.all(
                                  color: const Color(0xffF5A636), width: 8)),
                          child: Container(
                            height: screenheight * 0.115,
                            width: screenheight * 0.115,
                            decoration: BoxDecoration(
                              color: const Color(0xffF5A636),
                              borderRadius: BorderRadius.circular(150),
                            ),
                            child: Icon(
                              Icons.done_rounded,
                              color: Colors.white,
                              size: (screenWidth / screenheight) * 150,
                            ),
                          ),
                        ),
                        Text(
                          'Pagamento concluído com Sucesso!',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: const Color(0xffF5A636),
                              fontSize: (screenWidth / screenheight) * 35),
                        ),
                        Text(
                          'O processamento do seu pagamento foi concluído com sucesso e as suas compras estão a caminho.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: (screenWidth / screenheight) * 30,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Número de encomenda: ',
                                style: TextStyle(
                                  color: const Color(0xFF888888),
                                  fontSize: (screenWidth / screenheight) * 30,
                                  fontWeight: FontWeight.w500,
                                )),
                            Text('#${widget.data[1].toString()}',
                                style: TextStyle(
                                  color: const Color(0xFFF5A636),
                                  fontSize: (screenWidth / screenheight) * 30,
                                  fontWeight: FontWeight.w600,
                                ))
                          ],
                        ),
                        Container(
                          width: screenWidth * 0.9,
                          height: 1,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFF5A636),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(2)),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              child: Row(
                                children: [
                                  Text(
                                    'Valor pago: ',
                                    style: TextStyle(
                                      color: const Color(0xFF888888),
                                      fontSize:
                                          (screenWidth / screenheight) * 28,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    '${widget.data[2]}€',
                                    style: TextStyle(
                                      color: const Color(0xFFF5A636),
                                      fontSize:
                                          (screenWidth / screenheight) * 28,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              child: Row(
                                children: [
                                  Text(
                                    'Pago por: ',
                                    style: TextStyle(
                                      color: const Color(0xFF888888),
                                      fontSize:
                                          (screenWidth / screenheight) * 28,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    'CONTRA-REEMBOLSO',
                                    style: TextStyle(
                                      color: const Color(0xFFF5A636),
                                      fontSize:
                                          (screenWidth / screenheight) * 28,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushReplacementNamed('/');
                          },
                          child: Container(
                            height: screenheight * 0.1,
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: screenheight * 0.06,
                              width: screenWidth * 0.35,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: const Color(0xffF5A636),
                                  borderRadius: BorderRadius.circular(100),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      offset: const Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ]),
                              child: Text(
                                'Voltar',
                                style: TextStyle(
                                    fontSize: (screenWidth / screenheight) * 40,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )))
        ],
      ),
    );
  }
}
