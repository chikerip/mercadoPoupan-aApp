// ignore_for_file: file_names, camel_case_types, unnecessary_cast
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mercadopoupanca/components/AppAdvertsBar.dart';
import 'package:mercadopoupanca/pages/homePage/models/post.dart';
import 'package:mercadopoupanca/pages/homePage/services/remote_services.dart';

class productsPage extends StatefulWidget {
  final String data;
  const productsPage({Key? key,
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

  @override
  void initState(){
    super.initState();

    Timer.periodic(const Duration(seconds: 5), (timer) {
        if(isLoaded == false){
          setState(() {
            newProduct = true;
          });
          timer.cancel();
        }
    });
  }

  getData(productRef) async{
    posts = await RemoteServices().getPosts('${_localStorage.get('urlApi')}/product?type=barcode', {"productRef": productRef});

      if(posts != null){
        setState(() {
          oldPost = posts;
          isLoaded = true;
          array.add(posts![0].barcode);
          array.add(posts![0].name);
          array.add(posts![0].image);
        });
      }
  }
  
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    String product = widget.data;
    getData(product);

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
                            if(_localStorage.get('backProduct') == true){
                              _localStorage.put('backProduct', null);
                              _localStorage.put('searchStatus', 'cancel');
                              Navigator.of(context).pushReplacementNamed('/');
                            } else {
                              Navigator.pop(context);
                            }
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
                            visible: (_localStorage.get('admin') == 1 && isLoaded == true),
                            child: IconButton(
                              onPressed: () => {
                                Navigator.of(context).pushReplacementNamed('/addPrice', arguments: array),
                              }, 
                              icon: Icon(Icons.add)
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
  
                  Visibility(
                    visible: isLoaded,
                    replacement: Visibility(
                      visible: (newProduct),
                      replacement: const Center(child: CircularProgressIndicator(),),
                      child: Visibility(
                        visible: (_localStorage.get('admin') == 1),
                        replacement: Container(
                          alignment: Alignment.center,
                          height: screenheight * 0.8,
                          width: screenWidth,
                          child: const Column(
                              children: [
                                Icon(Icons.close,color: Colors.black,),
                                Text("O produto não foi achado",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold
                                ),)
                              ],
                            )
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushReplacementNamed('/addProduct', arguments: widget.data);
                          },
                          child: const Center(child: Icon(Icons.add, color: Colors.black,),),
                        )
                      ),
                    ),
                    child: Stack(
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
                            '${oldPost?[0].image}',
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
                                  child: Text(
                                    '${oldPost?[0].name}',
                                    style: const TextStyle(
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
