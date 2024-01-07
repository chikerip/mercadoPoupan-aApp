// ignore_for_file: file_names, prefer_const_constructors, camel_case_types
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mercadopoupanca/components/AppAdvertsBar.dart';
import 'package:mercadopoupanca/components/bottomAppBar.dart';

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
                Expanded(
                  child: AppBuilderContainer()
                ),
              ],
            ),
            Positioned(
                  left: 0, 
                  bottom: 0, 
                  child: Container(
                    width: screenWidth,
                    height: screenheight * 0.11,
                    child: const HamburgerMenu(),
                  )
            )
          ],
        ),
        )
      ),
    );
  }
}

class _AppSeachBar extends State<AppSeachBar>{
  
  String formText = 'aa';

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return SafeArea(
      top: false,
      right: false,
      child: Container(
        margin: EdgeInsets.fromLTRB(screenWidth * 0.02, screenheight * 0.03, screenWidth * 0.02, 0),
        height: screenheight * 0.07,
        child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, screenWidth * 0.03, 0),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Color(0xffF5A636),
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: screenWidth * 0.43,
                    child: Image.network('https://firebasestorage.googleapis.com/v0/b/mercadopoupanca-2aac2.appspot.com/o/stores%2Fpingo%20doce.png?alt=media&token=8afba80c-a6af-4dcb-8cf4-b8d205ced295'),
                  ),
                ),

                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, screenWidth * 0.03, 0),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Color(0xffF5A636),
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: screenWidth * 0.43,
                    child: Image.network('https://firebasestorage.googleapis.com/v0/b/mercadopoupanca-2aac2.appspot.com/o/stores%2Fmercadona.png?alt=media&token=8312a14c-a01c-46dd-883c-cb1175c776c9'),
                  ),
                ),

                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, screenWidth * 0.03, 0),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Color(0xffF5A636),
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: screenWidth * 0.43,
                    child: Image.network('https://firebasestorage.googleapis.com/v0/b/mercadopoupanca-2aac2.appspot.com/o/stores%2Flidl.png?alt=media&token=6285ae8c-dae9-438b-af27-a4802c47afc1'),
                  ),
                ),

                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, screenWidth * 0.03, 0),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Color(0xffF5A636),
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: screenWidth * 0.43,
                    child: Image.network('https://firebasestorage.googleapis.com/v0/b/mercadopoupanca-2aac2.appspot.com/o/stores%2Fcontinente.png?alt=media&token=dd4115f8-f87b-4279-92f9-af59030bdc5e'),
                  ),
                ),

                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, screenWidth * 0.03, 0),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Color(0xffF5A636),
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: screenWidth * 0.43,
                    child: Image.network('https://firebasestorage.googleapis.com/v0/b/mercadopoupanca-2aac2.appspot.com/o/stores%2Faldi.png?alt=media&token=53e982d8-1f1a-48f0-98ee-11138b967b74'),
                  ),
                ),
              ],
          ),
      ),
    );
  }
}

class _AppBuilderContainer extends State<AppBuilderContainer>{
  //container1 2 * index, container2 (2 * index) + 1;
  bool abc = true;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return ListView.builder(
        itemCount: 25,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.fromLTRB(0, 8, 0, 0),
            width: screenWidth,
            child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
                ),
                width: screenWidth * 0.45,
                height: screenheight * 0.26,
                child: Stack(
                  children: [
                    Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.network('https://firebasestorage.googleapis.com/v0/b/mercadopoupanca-2aac2.appspot.com/o/products%2FdefaultImg.png?alt=media&token=87a9d1d0-0c2a-49e1-a955-b62fc63636e3',
                    height: screenheight * 0.13,
                    width: screenWidth * 0.40
                    ),
                   
                    Container(
                      padding: EdgeInsets.all(screenWidth * 0.01),
                      width: screenWidth * 0.45,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Banana',
                          style: TextStyle(
                            fontSize: (screenWidth / screenheight) * 40,
                          ),),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '1.99€',
                              style: TextStyle(
                                color: Color(0xffF5A636),
                                fontWeight: FontWeight.bold,
                                fontSize: (screenWidth / screenheight) * 40
                                ),
                              ),
                            Stack(
                              children: [
                                Visibility(
                                  visible: false,
                                  child: Text(
                                    '2.99€',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: (screenWidth / screenheight) * 25
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                  bottom: screenheight * 0.005,
                                  child: Text(
                                  '_______',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: (screenWidth / screenheight) * 25
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                    ),
                    

                  ],
                ),
                   
                    Visibility(
                      visible: (0 > 0),
                      child: Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        height: screenheight * 0.05,
                        width: screenWidth * 0.15,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomLeft: Radius.circular(10)),
                          color: Color(0xffF5A636),
                        ),
                        child: Text(
                          '25%',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: (screenWidth / screenheight) * 35,
                            color: Colors.white
                          ),
                        ),
                      )
                    ),
                    ),
                    
                    Positioned(
                      bottom: screenheight * 0.01,
                      child: Container(
                        padding: EdgeInsets.only(top: !abc ? screenheight * 0.02 : 0),
                        margin:EdgeInsets.fromLTRB(screenWidth * 0.03, screenheight * 0.01, screenWidth * 0.03, 0),
                        width: screenWidth * 0.38,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network('https://firebasestorage.googleapis.com/v0/b/mercadopoupanca-2aac2.appspot.com/o/stores%2Fpingo%20doce.png?alt=media&token=8afba80c-a6af-4dcb-8cf4-b8d205ced295',
                                  height: screenheight * 0.04,
                                  width: screenWidth * 0.20
                                ),
                                Visibility(
                                  visible: false,
                                  child: Text(
                                    'e mais outros',
                                    style: TextStyle(
                                      fontSize: (10)
                                    ),
                                    )
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () => {
                                Navigator.of(context).pushNamed('/product', arguments: null)
                              },
                              child: const Icon(Icons.shopping_basket, color: Colors.black,)
                            ),
                          ],
                      ),
                      )
                    )
                  ],
                  )
              ),
              
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
                ),
                width: screenWidth * 0.45,
                height: screenheight * 0.26,
                child: Stack(
                  children: [
                    Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.network('https://firebasestorage.googleapis.com/v0/b/mercadopoupanca-2aac2.appspot.com/o/products%2FdefaultImg.png?alt=media&token=87a9d1d0-0c2a-49e1-a955-b62fc63636e3',
                    height: screenheight * 0.13,
                    width: screenWidth * 0.40
                    ),
                    
                    Container(
                      padding: EdgeInsets.all(screenWidth * 0.01),
                      width: screenWidth * 0.45,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Banana',
                          style: TextStyle(
                            fontSize: (screenWidth / screenheight) * 40,
                          ),),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '1.99€',
                              style: TextStyle(
                                color: Color(0xffF5A636),
                                fontWeight: FontWeight.bold,
                                fontSize: (screenWidth / screenheight) * 40
                                ),
                              ),
                            Stack(
                              children: [
                                Visibility(
                                  visible: true,
                                  child: Text(
                                    '2.99€',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: (screenWidth / screenheight) * 25
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                  bottom: screenheight * 0.005,
                                  child: Text(
                                  '_______',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: (screenWidth / screenheight) * 25
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                    ),
                   
                  ],
                ),
                  
                    Visibility(
                      visible: (1 > 0),
                      child: Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        height: screenheight * 0.05,
                        width: screenWidth * 0.15,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomLeft: Radius.circular(10)),
                          color: Color(0xffF5A636),
                        ),
                        child: Text(
                          '25%',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: (screenWidth / screenheight) * 35,
                            color: Colors.white
                          ),
                        ),
                      )
                    ),
                    ),
                    
                    Positioned(
                      bottom: screenheight * 0.01,
                      child: Container(
                        padding: EdgeInsets.only(top: !abc ? screenheight * 0.02 : 0),
                        margin:EdgeInsets.fromLTRB(screenWidth * 0.03, screenheight * 0.01, screenWidth * 0.03, 0),
                        width: screenWidth * 0.38,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network('https://firebasestorage.googleapis.com/v0/b/mercadopoupanca-2aac2.appspot.com/o/stores%2Fpingo%20doce.png?alt=media&token=8afba80c-a6af-4dcb-8cf4-b8d205ced295',
                                  height: screenheight * 0.04,
                                  width: screenWidth * 0.20
                                ),
                                Visibility(
                                  visible: true,
                                  child: Text(
                                    'e mais outros',
                                    style: TextStyle(
                                      fontSize: (10)
                                    ),
                                    )
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () => {
                                Navigator.of(context).pushNamed('/product', arguments: null)
                              },
                              child: const Icon(Icons.shopping_basket, color: Colors.black,)
                            ),
                          ],
                      ),
                      )
                    )
                  ],
                  )
              ),
              
            ],
          ),
          );
        },
      );
  }

}
