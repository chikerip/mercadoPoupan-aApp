// ignore_for_file: file_names, camel_case_types, unnecessary_cast, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mercadopoupanca/components/AppAdvertsBar.dart';
import 'package:mercadopoupanca/pages/loginPage/models/post.dart';
import 'package:mercadopoupanca/pages/loginPage/services/remote_services.dart';

class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPage();
}

class _loginPage extends State<loginPage> {
  final _localStorage = Hive.box('localStorage');
  String email = '';
  String password = '';
  List<Post>? posts;
  bool send = false;
  bool activatedPassword = false;

  getData(body) async {
    posts = await RemoteServicesLogin().getPosts(
        'https://mercadopoupanca.azurewebsites.net/user?type=login', body);

    if (posts != null) {
      _localStorage.put('token', posts![0].token);
      _localStorage.put('admin', posts![0].admin);
      Navigator.of(context).pushNamed('/account');
    } else {
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
                content: Text("Falha ao dar login"),
              ));
      setState(() {
        send = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
        body: SafeArea(
      top: false,
      child: Column(
        children: [
          const AppAdvertsBar(),
          Expanded(
              child: Container(
                  color: const Color(0xffD9D9D9),
                  height: screenheight * 0.9,
                  width: screenWidth,
                  child: Container(
                      alignment: Alignment.topCenter,
                      child: Column(children: [
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
                                  icon: const Icon(Icons.arrow_back_ios)),
                              const Text(
                                'Login',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: screenWidth * 0.1,
                                height: screenheight * 0.1,
                                child: Visibility(
                                  visible: false,
                                  child: IconButton(
                                      onPressed: () => {
                                            Navigator.of(context).pushNamed('/')
                                          },
                                      icon: const Icon(Icons.add)),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(
                                    0, screenheight * 0.03, 0, 0),
                                padding: EdgeInsets.fromLTRB(
                                    screenWidth * 0.05, 0, 0, 0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.grey,
                                      spreadRadius: 5,
                                      blurRadius: 6,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                width: screenWidth * 0.85,
                                child: TextField(
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Endereço de email"),
                                  onChanged: (text) {
                                    setState(() {
                                      email = text;
                                    });
                                  },
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(
                                    0, screenheight * 0.03, 0, 0),
                                padding: EdgeInsets.fromLTRB(
                                    screenWidth * 0.05, 0, 0, 0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.grey,
                                      spreadRadius: 5,
                                      blurRadius: 6,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                width: screenWidth * 0.85,
                                child: TextField(
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Password",
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        // Based on passwordVisible state choose the icon
                                        activatedPassword
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.black,
                                      ),
                                      onPressed: () {
                                        // Update the state i.e. toogle the state of passwordVisible variable
                                        setState(() {
                                          activatedPassword =
                                              !activatedPassword;
                                        });
                                      },
                                    ),
                                  ),
                                  obscureText: !activatedPassword,
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
                          margin:
                              EdgeInsets.fromLTRB(0, screenheight * 0.02, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Text(
                                'Ainda não tens uma conta? ',
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamed('/register');
                                },
                                child: const Text(
                                  'Regista-te',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline),
                                ),
                              )
                            ],
                          ),
                        ),
                        Visibility(
                            visible: send,
                            replacement: GestureDetector(
                              onTap: () {
                                setState(() {
                                  send = true;
                                });
                                getData({"email": email, "password": password});
                              },
                              child: Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.fromLTRB(
                                    0, screenheight * 0.08, 0, 0),
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
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: const Text(
                                  'LOGIN',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ))
                      ]))))
        ],
      ),
    ));
  }
}
