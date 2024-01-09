// ignore_for_file: file_names, prefer_const_constructors
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mercadopoupanca/components/AppAdvertsBar.dart';
import 'package:mercadopoupanca/components/bottomAppBar.dart';
import 'package:mercadopoupanca/pages/homePage/models/post.dart';
import 'package:mercadopoupanca/pages/homePage/services/remote_services.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
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

class _MyHomePageState extends State<MyHomePage> {

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
                AppBuilderContainer(),
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

class _AppBuilderContainer extends State<AppBuilderContainer>{
  final _localStorage = Hive.box('localStorage');
  List<Post>? posts;
  List<Post>? oldPost;
  bool isLoaded = false;

  @override
  
  void initState(){

    super.initState();
      _localStorage.put('searchStatus', false);
      Timer.periodic(const Duration(seconds: 1), (timer) {
        switch(_localStorage.get('searchStatus')){
          case false:
            getData('http://192.168.137.1:8080/product?type=all', null);
            _localStorage.put('searchStatus', null);
          case true:
            getData('http://192.168.137.1:8080/product?type=name', _localStorage.get('search'));
            _localStorage.put('searchStatus', null);
          case 'cancel':
            timer.cancel();
        }
      });
  }

  getData(url, body) async{
      posts = await RemoteServices().getPosts(url, body);

      if(posts != null){
        setState(() {
          oldPost = posts;
          isLoaded = true;
        });
      }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Expanded(
          child: Visibility(
          replacement: const Center(child: CircularProgressIndicator(),),
          visible: isLoaded,
          child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // number of items in each row
                  mainAxisSpacing: screenheight * 0.01, // spacing between rows
                  crossAxisSpacing: screenWidth * 0.05, // spacing between columns
                  childAspectRatio: (0.88),
                ),
                padding: EdgeInsets.fromLTRB(screenWidth * 0.03, 0, screenWidth * 0.03, 0),
                itemCount: oldPost?.length,
                itemBuilder: (context, index) {
                  return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        width: screenWidth * 0.45,
                        child: Stack(
                          children: [
                            Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed('/product', arguments: oldPost![index].barcode.toString());
                              },
                              child: Image.network('${oldPost?[index].image}',
                                height: screenheight * 0.13,
                                width: screenWidth * 0.40
                                ),
                            ),
                          
                            Container(
                              padding: EdgeInsets.all(screenWidth * 0.01),
                              width: screenWidth * 0.45,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${oldPost?[index].name}',
                                  style: TextStyle(
                                    fontSize: (screenWidth / screenheight) * 40,
                                  ),),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '${oldPost?[index].market[0].price}€',
                                      style: TextStyle(
                                        color: Color(0xffF5A636),
                                        fontWeight: FontWeight.bold,
                                        fontSize: (screenWidth / screenheight) * 40
                                        ),
                                      ),
                                    Stack(
                                      children: [
                                        Visibility(
                                          visible: (oldPost![index].market[0].promo > 0),
                                          child: Text(
                                            '${((oldPost?[index].market[0].price)! + (oldPost![index].market[0].price * (oldPost![index].market[0].promo / 100))).toStringAsFixed(2)}€',
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
                              visible: (oldPost![index].market[0].promo > 0),
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
                                  '${oldPost?[index].market[0].promo}%',
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
                                margin:EdgeInsets.fromLTRB(screenWidth * 0.03, screenheight * 0.01, screenWidth * 0.03, 0),
                                width: screenWidth * 0.38,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Image.network(oldPost![index].market[0].image,
                                          height: screenheight * 0.04,
                                          width: screenWidth * 0.20
                                        ),
                                        Visibility(
                                          visible: (oldPost![index].market.length > 1),
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
                                      onTap: () {
                                        if(_localStorage.get('shop') == null){
                                          _localStorage.put('shop', []);
                                        }
                                        // ignore: no_leading_underscores_for_local_identifiers

                                        List<dynamic> array = _localStorage.get('shop');
                                        array.add({"product": oldPost![index].barcode, "store": oldPost![index].market[0].name});
                                        _localStorage.put('shop', array);
                                        //Navigator.of(context).pushNamed('/product', arguments: null);
                                      },
                                      child: const Icon(Icons.shopping_basket, color: Colors.black,)
                                    ),
                                  ],
                              ),
                              )
                            )
                          ],
                          )
                  );
                },
              ),
            
            ),
      );
  }

}

class _AppSeachBar extends State<AppSeachBar>{
  final _localStorage = Hive.box('localStorage');
  

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return SafeArea(
      top: false,
      child: Container(
        padding: EdgeInsets.fromLTRB(screenWidth * 0.03, 0, screenWidth * 0.03, 0),
        height: screenheight * 0.09,
        width: screenWidth,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(screenWidth * 0.02, 0, screenWidth * 0.02, 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white
              ),
              width: screenWidth * 0.6,
              child: TextField(
              decoration: const InputDecoration(
                border: InputBorder.none, 
                hintText: "Pesquise aqui"
              ),
              onChanged: (text) {
                _localStorage.put('searchStatus', true);
                _localStorage.put('search', {"productRef": text});
              }
            ),
            ),
            // ignore: sized_box_for_whitespace
            Container(
              decoration: BoxDecoration(
                borderRadius:BorderRadius.circular(50),
                color: Colors.white,
                ),
              child: IconButton(
                onPressed: () => {
                  Navigator.of(context).pushNamed('/filter', arguments: null),
                }, 
                icon: const Icon(Icons.filter_list_outlined, color: Colors.black,)
              ),
            ),
            
            Container(
              decoration: BoxDecoration(
                borderRadius:BorderRadius.circular(50),
                color: Colors.white,
                ),
              child: IconButton(
                onPressed: () => {
                  Navigator.of(context).pushNamed('/scan', arguments: null),
                }, 
                icon: const Icon(Icons.barcode_reader, color: Colors.black,)
              ),
            ),
            
            ],
          ),
        )
    );
  }
}
