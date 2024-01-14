// ignore_for_file: file_names, prefer_const_constructors, camel_case_types
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mercadopoupanca/components/AppAdvertsBar.dart';
import 'package:mercadopoupanca/components/bottomAppBar.dart';
import 'package:mercadopoupanca/pages/catalogPage/models/post.dart';
import 'package:mercadopoupanca/pages/catalogPage/services/remote_services.dart';

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
  final _localStorage = Hive.box('localStorage');

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return SafeArea(
      top: false,
      right: false,
      child: Container(
        margin: EdgeInsets.fromLTRB(screenWidth * 0.02, screenheight * 0.03, screenWidth * 0.02, screenheight * 0.03),
        height: screenheight * 0.07,
        child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                GestureDetector(
                  onTap: (){
                    _localStorage.put('catalogStatus', 'pingoDoce');
                  },
                  child: Container(
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
                ),

                GestureDetector(
                  onTap: (){
                    _localStorage.put('catalogStatus', 'mercadona');
                  },
                  child: Container(
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
                ),

                GestureDetector(
                  onTap: () {
                    _localStorage.put('catalogStatus', 'lidl');
                  },
                  child: Container(
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
                ),
                
                GestureDetector(
                  onTap: () {
                    _localStorage.put('catalogStatus', 'continente');
                  },
                  child: Container(
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
                ),
                
                GestureDetector(
                  onTap: (){
                    _localStorage.put('catalogStatus', 'aldi');
                  },
                  child: Container(
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
                ),
              ],
          ),
      ),
    );
  }
}

class _AppBuilderContainer extends State<AppBuilderContainer>{
  final _localStorage = Hive.box('localStorage');
  List<Post>? posts;
  List<Post>? oldPost;
  bool isLoaded = false;
  int count = 0;

  @override
  
  void initState(){

    super.initState();
    _localStorage.put('catalogStatus', 'all');
    Timer.periodic(const Duration(seconds: 1), (timer) {
      switch(_localStorage.get('catalogStatus')){
        case 'all':
          getData('${_localStorage.get('urlApi')}/catalog?market=all', null);
          _localStorage.put('catalogStatus', null);
        case 'pingoDoce':
          getData('${_localStorage.get('urlApi')}/catalog?market=Pingo Doce', null);
          _localStorage.put('catalogStatus', null);
        case 'mercadona':
          getData('${_localStorage.get('urlApi')}/catalog?market=Mercadona', null);
          _localStorage.put('catalogStatus', null);
        case 'lidl':
          getData('${_localStorage.get('urlApi')}/catalog?market=Lidl', null);
          _localStorage.put('catalogStatus', null);
        case 'continente':
          getData('${_localStorage.get('urlApi')}/catalog?market=Continente', null);
          _localStorage.put('catalogStatus', null);
        case 'aldi':
          getData('${_localStorage.get('urlApi')}/catalog?market=Aldi', null);
          _localStorage.put('catalogStatus', null);
        case 'cancel':
          timer.cancel();
      }
    });
  }

  getData(url, body) async{
      setState(() {
        isLoaded = false;
      });
      posts = await RemoteServicesCatalog().getPosts(url, body);
      

      if(posts != null){
        setState(() {
          oldPost = posts;
          isLoaded = true;
        });
      } else {
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
                content: Text("Mercado sem promoções"),
        ));
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
                                    Visibility(
                                      visible: (oldPost![index].market[0].promo > 0),
                                      child: Stack(
                                        children: [
                                          Text(
                                              '${((oldPost?[index].market[0].price)! + (oldPost![index].market[0].price * (oldPost![index].market[0].promo / 100))).toStringAsFixed(2)}€',
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: (screenWidth / screenheight) * 25
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
                                    ),
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
                                        array.add({"product": oldPost![index].barcode, "store": oldPost![index].market[0].market});
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
