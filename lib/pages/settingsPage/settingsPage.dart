// ignore_for_file: file_names, camel_case_types, unnecessary_cast
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mercadopoupanca/components/AppAdvertsBar.dart';

class settingsPage extends StatefulWidget {
  const settingsPage({super.key});

  @override
  State<settingsPage> createState() => _settingsPage();
}

class _settingsPage extends State<settingsPage> {
  final _localStorage = Hive.box('localStorage');
  bool asc = false;
  
  bool des = false;

  void initState(){
    super.initState();

    if(_localStorage.get('hamburgerDirection') == true){
      setState(() {
        asc = true;
      });
    } else {
      setState(() {
        des = true;
      });
    }
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
                          'Definições',
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
                        Text('Orientação do Menu'),
                        
                        GestureDetector(
                          onTap:() {
                            if(des == true){
                              setState(() {
                                des = !des;
                              });
                            }
                            if(asc != true){
                              setState(() {
                                _localStorage.put('hamburgerDirection', true);
                                asc = !asc;
                              });
                            }
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
                                  'Destro',
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
                            if(des != true){
                              setState(() {
                                _localStorage.put('hamburgerDirection', false);
                                des = !des;
                              });
                            }
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
                                  'Esquerdino',
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
                        Navigator.pop(context);
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