// ignore_for_file: file_names, camel_case_types, unnecessary_cast
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mercadopoupanca/components/AppAdvertsBar.dart';
import 'package:mercadopoupanca/pages/cartPage/models/shop.dart';

class checkoutPage extends StatefulWidget {
  const checkoutPage({super.key});

  @override
  State<checkoutPage> createState() => _checkoutPage();
}

class _checkoutPage extends State<checkoutPage> {
  final _localStorage = Hive.box('localStorage');
  bool isLoaded = true;
  double total = 11.99;
  String discount = '---';
  String adress = 'Av. da republica, 333, Habitacao 6, 4430-646, Vila Nova de Gaia';
  String name = 'abc';
  String postal = 'cba';
  String cidade = 'porca';


  void initState(){
    super.initState();
  }

  void separateAdress(){
    int length = adress.length - 1;
    int find = 0;
    bool loop = false;
    String Word = '';

    while(loop == false){
      if(adress[length] == ','){
        setState(() {
          find++;
        });
      } else {
        setState(() {
          Word += adress[length];
        });
      }

      length--;

      switch(find){
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
                          icon: Icon(Icons.arrow_back_ios)
                        ),
                      
                        const Text(
                          'Checkout',
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                          ),

                        Container(
                          width: screenWidth * 0.1,
                          height: screenheight * 0.1,
                          child: Visibility(
                            visible: false,
                            child: IconButton(
                              onPressed: () => {
                                Navigator.of(context).pushNamed('/')
                              }, 
                              icon: Icon(Icons.add)
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                
               
                Expanded(
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      children: [
                        Container(
                          padding: const EdgeInsets.fromLTRB(20,0,0,0),
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            'Enviar para',
                            style: TextStyle(
                              color: Color(0xff888888),
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),

                        Container(
                          padding: const EdgeInsets.fromLTRB(20, 3, 20, 10),
                          child: Container(
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: const Color(0xffF5A636),
                                width: 3
                              ),
                              borderRadius: BorderRadius.circular(15)
                            ),
                            height: screenheight * 0.14,
                            child: Stack(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'CASA',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold
                                      ),
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
                                    margin: EdgeInsets.fromLTRB(screenWidth * 0.04, 0, screenWidth * 0.04, 0),
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(
                                        color: const Color(0xffF5A636),
                                        width: 3
                                      ),
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: const Color(0xffF5A636),
                                        borderRadius: BorderRadius.circular(50)
                                      ),
                                      width: 10,
                                      height: 10,
                                    ),
                                  ),
                                )

                              ],
                            )
                          ),
                        ),

                        Container(
                          padding: const EdgeInsets.fromLTRB(20,0,0,0),
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            'Pagar com',
                            style: TextStyle(
                              color: Color(0xff888888),
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),

                        Container(
                          padding: const EdgeInsets.fromLTRB(20, 3, 20, 10),
                          child: Container(
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: const Color(0xffF5A636),
                                width: 3
                              ),
                              borderRadius: BorderRadius.circular(15)
                            ),
                            height: screenheight * 0.07,
                            child: Stack(
                              children: [
                                const Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                     Text(
                                      'CONTRA-REEMBOLSO',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold
                                      ),
                                      ),
                                  ],
                                ),

                                Positioned(
                                  top: 0,
                                  right: -10,
                                  child: Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.fromLTRB(screenWidth * 0.04, 0, screenWidth * 0.04, 0),
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(
                                        color: const Color(0xffF5A636),
                                        width: 3
                                      ),
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: const Color(0xffF5A636),
                                        borderRadius: BorderRadius.circular(50)
                                      ),
                                      width: 10,
                                      height: 10,
                                    ),
                                  ),
                                )

                              ],
                            )
                          
                          ),
                        ),
                      
                      ],
                    )
                )
              ],
            ),

            Visibility(
              visible: isLoaded,
              child: Positioned(
              bottom: 0,
              child: Container(
                height: screenheight * 0.35,
                width: screenWidth,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if(_localStorage.get('token') != null){
                 
                        }

                        separateAdress();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: screenheight * 0.06,
                        width: screenWidth * 0.45,
                        decoration: BoxDecoration(
                          color: const Color(0xffF5A636),
                          borderRadius: BorderRadius.circular(50)
                        ),
                        child: const Text(
                          'PAGAR',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, screenheight * 0.03, 0, 0),
                      height: screenheight * 0.26,
                      width: screenWidth,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Color(0xffF5A636),
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight:Radius.circular(20))
                      ),
                      child: Container(
                        height: screenheight * 0.2,
                        width: screenWidth * 0.9,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            DottedBorder(
                              borderType: BorderType.RRect,
                              radius: Radius.circular(20),
                              color: Colors.white,
                              dashPattern: [15,8],
                              strokeWidth: 2,
                              child: Container(
                                width: screenWidth * 0.9,
                                height: screenheight * 0.05,
                                padding: EdgeInsets.fromLTRB(screenWidth * 0.2, 0, 0, 0),
                                child: Row(
                                  children: [
                                    const Icon(Icons.discount, color: Colors.white,),
                                    Expanded(
                                      child: TextField(
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: ' Promo code (opcional)',
                                          hintStyle: TextStyle(
                                            color: Colors.white
                                          )
                                        ),
                                        onChanged: (text) {
                                          
                                        },
                                        onTap: () {
                                          
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            
                            SizedBox(
                              width: screenWidth * 0.9,
                              height: screenheight * 0.04,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Descontos:',
                                    style: TextStyle(
                                      color: Colors.white
                                    ),
                                  ),
                                  Text(
                                    '$discount€',
                                    style: TextStyle(
                                      color: Colors.white
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            
                            SizedBox(
                              width: screenWidth * 0.9,
                              height: screenheight * 0.04,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '________________________________________________',
                                    style: TextStyle(
                                      color: Colors.white
                                    ),
                                  )
                                ],
                              ),
                            ),
                            
                            SizedBox(
                              width: screenWidth * 0.9,
                              height: screenheight * 0.04,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'TOTAL:',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '$total€',
                                    style: TextStyle(
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
              )
            ),
          
            )
          ],
        )
      ),
    );
  }
}