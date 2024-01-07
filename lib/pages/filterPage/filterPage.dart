// ignore_for_file: file_names, camel_case_types, unnecessary_cast
import 'package:flutter/material.dart';
import 'package:mercadopoupanca/components/AppAdvertsBar.dart';

class filterPage extends StatefulWidget {
  const filterPage({super.key});

  @override
  State<filterPage> createState() => _filterPage();
}

class _filterPage extends State<filterPage> {
  bool asc = true;
  bool des = false;
  bool mercadona = false;
  bool aldi = false;
  bool lidl = false;
  bool continente = false;
  bool pingoDoce = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        children: [
          const AppAdvertsBar(),
          Container(
            color: Color(0xffD9D9D9),
            height: screenheight * 0.93,
            width: screenWidth,
            child: Container(
              child: Column(
                children: [
                  Container(
                    width: screenWidth * 0.92,
                    height: screenheight * 0.1,
                    color: Color(0xffD9D9D9),
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
                          'Filtros',
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
  
                  Container(
                    margin: EdgeInsets.fromLTRB(0, screenheight * 0.01, 0, 0),
                    width: screenWidth * 0.9,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Ordenar por'),
                        
                        GestureDetector(
                          onTap:() {
                            if(des == true){
                              setState(() {
                                des = !des;
                              });
                            }
                            setState(() {
                              asc = !asc;
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.fromLTRB(0, screenheight * 0.01, 0, 0),
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
                                        offset: Offset(0, 3), // changes position of shadow
                                      ),
                                    ],
                            ),
                            child: Row(
                              children: [
                                Container(
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
                                      color: asc ? const Color(0xffF5A636) : Colors.white,
                                      borderRadius: BorderRadius.circular(50)
                                    ),
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
                          onTap:() {
                            if(asc == true){
                              setState(() {
                                asc = !asc;
                              });
                            }
                            setState(() {
                              des = !des;
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.fromLTRB(0, screenheight * 0.01, 0, 0),
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
                                        offset: Offset(0, 3), // changes position of shadow
                                      ),
                                    ],
                            ),
                            child: Row(
                              children: [
                                Container(
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
                                      color: des ? const Color(0xffF5A636) : Colors.white,
                                      borderRadius: BorderRadius.circular(50)
                                    ),
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
                        Text('Mercados'),
                        
                        GestureDetector(
                          onTap:() {
                            setState(() {
                              mercadona = !mercadona;
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.fromLTRB(0, screenheight * 0.01, 0, 0),
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
                                        offset: Offset(0, 3), // changes position of shadow
                                      ),
                                    ],
                            ),
                            child: Row(
                              children: [
                                Container(
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
                                      color: mercadona ? const Color(0xffF5A636) : Colors.white,
                                      borderRadius: BorderRadius.circular(50)
                                    ),
                                    width: 10,
                                    height: 10,
                                  ),
                                ),
                              
                                const Text(
                                  'Mercadona',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  )
                              ],
                            ),
                          ),
                        ),
                      
                        GestureDetector(
                          onTap:() {
                            setState(() {
                              aldi = !aldi;
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.fromLTRB(0, screenheight * 0.01, 0, 0),
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
                                        offset: Offset(0, 3), // changes position of shadow
                                      ),
                                    ],
                            ),
                            child: Row(
                              children: [
                                Container(
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
                                      color: aldi ? const Color(0xffF5A636) : Colors.white,
                                      borderRadius: BorderRadius.circular(50)
                                    ),
                                    width: 10,
                                    height: 10,
                                  ),
                                ),
                              
                                const Text(
                                  'Aldi',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  )
                              ],
                            ),
                          ),
                        ),
                      
                        GestureDetector(
                          onTap:() {
                            setState(() {
                              lidl = !lidl;
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.fromLTRB(0, screenheight * 0.01, 0, 0),
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
                                        offset: Offset(0, 3), // changes position of shadow
                                      ),
                                    ],
                            ),
                            child: Row(
                              children: [
                                Container(
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
                                      color: lidl ? const Color(0xffF5A636) : Colors.white,
                                      borderRadius: BorderRadius.circular(50)
                                    ),
                                    width: 10,
                                    height: 10,
                                  ),
                                ),
                              
                                const Text(
                                  'Lidl',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  )
                              ],
                            ),
                          ),
                        ),

                        GestureDetector(
                          onTap:() {
                            setState(() {
                              continente = !continente;
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.fromLTRB(0, screenheight * 0.01, 0, 0),
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
                                        offset: Offset(0, 3), // changes position of shadow
                                      ),
                                    ],
                            ),
                            child: Row(
                              children: [
                                Container(
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
                                      color: continente ? const Color(0xffF5A636) : Colors.white,
                                      borderRadius: BorderRadius.circular(50)
                                    ),
                                    width: 10,
                                    height: 10,
                                  ),
                                ),
                              
                                const Text(
                                  'Continente',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  )
                              ],
                            ),
                          ),
                        ),

                        GestureDetector(
                          onTap:() {
                            setState(() {
                              pingoDoce = !pingoDoce;
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.fromLTRB(0, screenheight * 0.01, 0, 0),
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
                                        offset: Offset(0, 3), // changes position of shadow
                                      ),
                                    ],
                            ),
                            child: Row(
                              children: [
                                Container(
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
                                      color: pingoDoce ? const Color(0xffF5A636) : Colors.white,
                                      borderRadius: BorderRadius.circular(50)
                                    ),
                                    width: 10,
                                    height: 10,
                                  ),
                                ),
                              
                                const Text(
                                  'Pingo Doce',
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
                
                  GestureDetector(
                    onTap: () {
                        Navigator.of(context).pushNamed('/');
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.fromLTRB(0, screenheight * 0.05, 0, 0),
                      width: screenWidth * 0.4,
                      height: screenheight * 0.08,
                      decoration: BoxDecoration(
                        color: const Color(0xffF5A636),
                        borderRadius: BorderRadius.circular(50)
                      ),
                      child: const Text(
                        'APLICAR',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          )
        ],
      ),
    );
  }
}
