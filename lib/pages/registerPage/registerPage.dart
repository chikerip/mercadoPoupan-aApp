// ignore_for_file: file_names, camel_case_types, unnecessary_cast
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mercadopoupanca/components/AppAdvertsBar.dart';
import 'package:mercadopoupanca/pages/registerPage/models/post.dart';
import 'package:mercadopoupanca/pages/registerPage/services/remote_services.dart';

class registerPage extends StatefulWidget {
  const registerPage({super.key});

  @override
  State<registerPage> createState() => _registerPage();
}

class _registerPage extends State<registerPage> {
  final _localStorage = Hive.box('localStorage');
  List<Post>? posts;
  String username = '';
  String email = '';
  String password = '';
  bool send = false;

  getData(body)async{
    posts = await RemoteServicesRegister().getPosts('${_localStorage.get('urlApi')}/user', body);
      

    if(posts != null){
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushNamed('/login');
    } else {
      setState(() {
        send = false;
      });
        // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
              content: Text("Falha ao registar utilizador"),
      ));
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
                              'Registar',
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
                      
                      SizedBox(
                        child: Column(
                          children: [

                            Container(
                              margin: EdgeInsets.fromLTRB(0, screenheight * 0.03, 0, 0),
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
                              child: TextField(
                                decoration: const InputDecoration(
                                  border: InputBorder.none, 
                                  hintText: "Username"
                                ),
                                onChanged: (text) {
                                  setState(() {
                                    username = text;
                                  });
                                },
                              ),
                            ),

                            Container(
                              margin: EdgeInsets.fromLTRB(0, screenheight * 0.03, 0, 0),
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
                              child: TextField(
                                decoration: const InputDecoration(
                                  border: InputBorder.none, 
                                  hintText: "Endereço de email"
                                ),
                                onChanged: (text) {
                                  setState(() {
                                    email = text;
                                  });
                                },
                              ),
                            ),

                            Container(
                              margin: EdgeInsets.fromLTRB(0, screenheight * 0.03, 0, 0),
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
                              child: TextField(
                                decoration: const InputDecoration(
                                  border: InputBorder.none, 
                                  hintText: "Password"
                                ),
                                onChanged: (text) {
                                  setState(() {
                                    password = text;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        width: screenWidth * 0.88,
                        margin: EdgeInsets.fromLTRB(0, screenheight * 0.02, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Text('Já tens uma conta? ',
                            style: TextStyle(
                              color: Colors.grey,
                            ),),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed('/login');
                              },
                              child: const Text('Inicia sessão',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline
                                ),
                              ),
                            )
                          ],
                        ),
                      ),

                      Visibility(
                        visible: send,
                        replacement: GestureDetector(
                          onTap: () {
                            //Navigator.of(context).pushNamed('/login');
                            setState(() {
                              send = true;
                            });
                            getData({"name": username, "email": email, "password": password});
                          },
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.fromLTRB(0, screenheight * 0.08, 0, 0),
                            width: screenWidth * 0.4,
                            height: screenheight * 0.08,
                            decoration: BoxDecoration(
                              color: const Color(0xffF5A636),
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
                            child: const Text('REGISTAR',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                            ),),
                          ),
                        ),
                        child: const Center(child: CircularProgressIndicator(),)
                      )
                    ]
                  )
                )
              )         
            )
          ],
        ),
    );
  }
}
