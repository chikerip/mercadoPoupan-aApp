// ignore_for_file: file_names, camel_case_types, unnecessary_cast
import 'package:flutter/material.dart';
import 'package:mercadopoupanca/components/AppAdvertsBar.dart';
import 'package:mercadopoupanca/components/bottomAppBar.dart';

class accountPage extends StatefulWidget {
  const accountPage({super.key});

  @override
  State<accountPage> createState() => _accountPage();
}

class _accountPage extends State<accountPage> {
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                const AppAdvertsBar(),
                
                Expanded(
                  child: Container(
                    color: Color(0xffD9D9D9),
                    height: screenheight * 0.9,
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
                                  'Perfil',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold
                                  ),
                                  ),

                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushNamed('/settings');
                                  },
                                  child: SizedBox(
                                    width: screenWidth * 0.1,
                                    height: screenheight * 0.1,
                                    child: const Icon(Icons.settings)
                                  ),
                                )
                              ],
                            ),
                          ),
                          
                          Container(
                                  margin: EdgeInsets.fromLTRB(0, screenheight * 0.01, 0, screenheight * 0.01),
                                  width: 125,
                                  height: 125,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                      color: const Color(0xffF5A636),
                                      width: 3
                                    )
                                  ),
                                  child: Image.network('https://firebasestorage.googleapis.com/v0/b/mercadopoupanca-2aac2.appspot.com/o/users%2FuserDefault.png?alt=media&token=b3c57dca-0714-41ca-b69c-509d5b4de5dd',
                                      width: 150,
                                      height: 150,),
                                ),

                          SizedBox(
                            child: Column(
                              children: [

                                Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      margin: EdgeInsets.fromLTRB(0, screenheight * 0.02, 0, 0),
                                      padding: EdgeInsets.fromLTRB(screenWidth * 0.05, 0, 0, 0),
                                      width: screenWidth * 0.95,
                                      height: screenheight * 0.02,
                                      child: Text('Nome:')
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      margin: EdgeInsets.fromLTRB(0, screenheight * 0.01, 0, 0),
                                      padding: EdgeInsets.fromLTRB(screenWidth * 0.05, 0, 0, 0),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.grey,
                                            spreadRadius: 5,
                                            blurRadius: 6,
                                            offset: Offset(0, 3), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      width: screenWidth * 0.85,
                                      height: screenheight * 0.06,
                                      child: Text('Data')
                                    ),

                                  ],
                                ),
                                
                                Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      margin: EdgeInsets.fromLTRB(0, screenheight * 0.02, 0, 0),
                                      padding: EdgeInsets.fromLTRB(screenWidth * 0.05, 0, 0, 0),
                                      width: screenWidth * 0.95,
                                      height: screenheight * 0.02,
                                      child: Text('Morada:')
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      margin: EdgeInsets.fromLTRB(0, screenheight * 0.01, 0, 0),
                                      padding: EdgeInsets.fromLTRB(screenWidth * 0.05, 0, 0, 0),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.grey,
                                            spreadRadius: 5,
                                            blurRadius: 6,
                                            offset: Offset(0, 3), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      width: screenWidth * 0.85,
                                      height: screenheight * 0.06,
                                      child: Text('Data')
                                    ),

                                  ],
                                ),
                                
                                Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      margin: EdgeInsets.fromLTRB(0, screenheight * 0.02, 0, 0),
                                      padding: EdgeInsets.fromLTRB(screenWidth * 0.05, 0, 0, 0),
                                      width: screenWidth * 0.95,
                                      height: screenheight * 0.02,
                                      child: Text('Telemovel:')
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      margin: EdgeInsets.fromLTRB(0, screenheight * 0.01, 0, 0),
                                      padding: EdgeInsets.fromLTRB(screenWidth * 0.05, 0, 0, 0),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.grey,
                                            spreadRadius: 5,
                                            blurRadius: 6,
                                            offset: Offset(0, 3), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      width: screenWidth * 0.85,
                                      height: screenheight * 0.06,
                                      child: Text('Data')
                                    ),

                                  ],
                                ),
                                
                                Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      margin: EdgeInsets.fromLTRB(0, screenheight * 0.02, 0, 0),
                                      padding: EdgeInsets.fromLTRB(screenWidth * 0.05, 0, 0, 0),
                                      width: screenWidth * 0.95,
                                      height: screenheight * 0.02,
                                      child: Text('Nif:')
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      margin: EdgeInsets.fromLTRB(0, screenheight * 0.01, 0, 0),
                                      padding: EdgeInsets.fromLTRB(screenWidth * 0.05, 0, 0, 0),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.grey,
                                            spreadRadius: 5,
                                            blurRadius: 6,
                                            offset: Offset(0, 3), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      width: screenWidth * 0.85,
                                      height: screenheight * 0.06,
                                      child: Text('Data')
                                    ),

                                  ],
                                ),
                                
                              ],
                            ),
                          ),

                          SizedBox(
                            width: screenWidth * 0.85,
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushNamed('/account');
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.fromLTRB(0, screenheight * 0.02, 0, 0),
                                    width: screenWidth * 0.35,
                                    height: screenheight * 0.06,
                                    decoration: BoxDecoration(
                                      color: const Color(0xffD30606),
                                      borderRadius: BorderRadius.circular(50),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.grey,
                                              spreadRadius: 5,
                                              blurRadius: 6,
                                              offset: Offset(0, 3), // changes position of shadow
                                            ),
                                          ],
                                    ),
                                    child: const Text('LOGOUT',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold
                                    ),),
                                  ),
                                ),
                              
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushNamed('/account');
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.fromLTRB(screenWidth * 0.05, screenheight * 0.02, 0, 0),
                                    width: screenWidth * 0.45,
                                    height: screenheight * 0.06,
                                    decoration: BoxDecoration(
                                      color: const Color(0xff1E81AC),
                                      borderRadius: BorderRadius.circular(50),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.grey,
                                              spreadRadius: 5,
                                              blurRadius: 6,
                                              offset: Offset(0, 3), // changes position of shadow
                                            ),
                                          ],
                                    ),
                                    child: const Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.edit,color: Colors.white,),
                                        Text('LOGOUT',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold
                                            ),
                                          ),
                                      ],
                                    )
                                  ),
                                ),
                              ],
                            ),
                          )
                        ]
                      )
                    )
                  )         
                ),
                
                Positioned(
                  left: 0, 
                  bottom: 0, 
                  child: Container(
                    width: screenWidth,
                    height: screenheight * 0.11,
                    color: const Color(0xffD9D9D9),
                    child: const HamburgerMenu(),
                  )
                )
              ],
            ),
          ],
        )
      )
    );
  }
}