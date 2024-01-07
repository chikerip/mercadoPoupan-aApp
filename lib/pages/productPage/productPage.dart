// ignore_for_file: file_names, camel_case_types, unnecessary_cast
import 'package:flutter/material.dart';
import 'package:mercadopoupanca/components/AppAdvertsBar.dart';

class productsPage extends StatefulWidget {
  const productsPage({super.key});

  @override
  State<productsPage> createState() => _productsPage();
}

class _productsPage extends State<productsPage> {

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
              alignment: Alignment.topCenter,
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
                          'Detalhes',
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
  
                  Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        width: screenWidth * 0.92,
                        height: screenheight * 0.7,
                      ),
                      
                      Positioned(
                        top: 0,
                        child: Container(
                          alignment: Alignment.center,
                          width: screenWidth * 0.92,
                          height: screenheight * 0.4,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0xffD9D9D9),
                                spreadRadius: 5,
                                blurRadius: 6,
                                offset: Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                        child: Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/mercadopoupanca-2aac2.appspot.com/o/products%2FdefaultImg.png?alt=media&token=87a9d1d0-0c2a-49e1-a955-b62fc63636e3',
                          width: screenWidth * 0.90,
                          height: screenheight * 0.35,
                          ),
                        ),
                      ),
                    
                      Positioned(
                        bottom: 0,
                        child: SizedBox(
                          width: screenWidth * 0.92,
                          height: screenheight * 0.45,
                          child:  Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                child: const Text(
                                  'Banana com maionese',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                              
                              Container(
                                padding: const EdgeInsets.fromLTRB(5, 5, 5, 3),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '1.99€',
                                      style: TextStyle(
                                        color: const Color(0xffF5A636),
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
                                              fontSize: (screenWidth / screenheight) * 40
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
                                ),
                              ),
                            
                              
                            ],
                          ) 
                        ),
                      )
                    ],
                  ),
                ],
              )
            )
          )
        ],
      ),
    );
  }
}
