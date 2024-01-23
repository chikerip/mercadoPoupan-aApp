// ignore_for_file: file_names, camel_case_types, unnecessary_cast, use_build_context_synchronously, avoid_unnecessary_containers
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mercadopoupanca/components/AppAdvertsBar.dart';
import 'package:mercadopoupanca/pages/settingsPage/services/remote_services.dart';

class settingsPage extends StatefulWidget {
  const settingsPage({super.key});

  @override
  State<settingsPage> createState() => _settingsPage();
}

class _settingsPage extends State<settingsPage> {
  final _localStorage = Hive.box('localStorage');
  bool asc = false;
  bool des = false;
  String oldPassword = '';
  String newPassword = '';
  bool activatedPassword = false;
  bool activatedPassword2 = false;

  @override
  void initState() {
    super.initState();

    if (_localStorage.get('hamburgerDirection') == true) {
      setState(() {
        asc = true;
      });
    } else {
      setState(() {
        des = true;
      });
    }
  }

  postData(body) async {
    final result = await RemoteServicesSettings().postDB(
        'https://mercadopoupanca.azurewebsites.net/user?type=password',
        _localStorage.get('token'),
        body);

    if (result != null) {
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
                content: Text("Sua palavra password foi atualizada"),
              ));
    } else {
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
                content: Text("erro ao atualizar a password"),
              ));
    }
  }

  hamburgerChange() {
    showDialog(
        context: context,
        builder: (context) => const AlertDialog(
              content: Text("Renicie a app para aplicar as alterações"),
            ));
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
                  color: const Color(0xffD9D9D9),
                  height: screenheight * 0.93,
                  width: screenWidth,
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Container(
                              width: screenWidth * 0.92,
                              height: screenheight * 0.1,
                              color: const Color(0xffD9D9D9),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: const Icon(Icons.arrow_back_ios)),
                                  const Text(
                                    'Definições',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: screenWidth * 0.1,
                                    height: screenheight * 0.1,
                                    child: Visibility(
                                      visible: false,
                                      child: IconButton(
                                          onPressed: () => {
                                                Navigator.of(context)
                                                    .pushNamed('/')
                                              },
                                          icon: const Icon(Icons.add)),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(
                                  0, screenheight * 0.01, 0, 0),
                              width: screenWidth * 0.9,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Orientação do Menu'),
                                  GestureDetector(
                                    onTap: () {
                                      if (des == true) {
                                        setState(() {
                                          des = !des;
                                        });
                                      }
                                      if (asc != true) {
                                        setState(() {
                                          _localStorage.put(
                                              'hamburgerDirection', true);
                                          asc = !asc;
                                        });
                                      }
                                    },
                                    child: Container(
                                      margin: EdgeInsets.fromLTRB(
                                          0, screenheight * 0.01, 0, 0),
                                      width: screenWidth * 0.9,
                                      height: screenheight * 0.07,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            spreadRadius: 3,
                                            blurRadius: 3,
                                            offset: const Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            alignment: Alignment.center,
                                            margin: EdgeInsets.fromLTRB(
                                                screenWidth * 0.04,
                                                0,
                                                screenWidth * 0.04,
                                                0),
                                            width: 20,
                                            height: 20,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              border: Border.all(
                                                  color:
                                                      const Color(0xffF5A636),
                                                  width: 3),
                                            ),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: asc
                                                      ? const Color(0xffF5A636)
                                                      : Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50)),
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
                                    onTap: () {
                                      if (asc == true) {
                                        setState(() {
                                          asc = !asc;
                                        });
                                      }
                                      if (des != true) {
                                        setState(() {
                                          _localStorage.put(
                                              'hamburgerDirection', false);
                                          des = !des;
                                        });
                                      }
                                    },
                                    child: Container(
                                      margin: EdgeInsets.fromLTRB(
                                          0, screenheight * 0.02, 0, 0),
                                      width: screenWidth * 0.9,
                                      height: screenheight * 0.07,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            spreadRadius: 3,
                                            blurRadius: 3,
                                            offset: const Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            alignment: Alignment.center,
                                            margin: EdgeInsets.fromLTRB(
                                                screenWidth * 0.04,
                                                0,
                                                screenWidth * 0.04,
                                                0),
                                            width: 20,
                                            height: 20,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              border: Border.all(
                                                  color:
                                                      const Color(0xffF5A636),
                                                  width: 3),
                                            ),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: des
                                                      ? const Color(0xffF5A636)
                                                      : Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50)),
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
                            Container(
                              margin: EdgeInsets.fromLTRB(
                                  0, screenheight * 0.03, 0, 0),
                              width: screenWidth * 0.9,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Alterar password'),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(
                                        0, screenheight * 0.01, 0, 0),
                                    padding: EdgeInsets.fromLTRB(
                                        screenWidth * 0.03, 0, 0, 0),
                                    alignment: Alignment.centerLeft,
                                    width: screenWidth * 0.9,
                                    height: screenheight * 0.07,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.5),
                                          spreadRadius: 3,
                                          blurRadius: 3,
                                          offset: const Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: TextField(
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Password antiga',
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
                                            oldPassword = text;
                                          });
                                        }),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(
                                        0, screenheight * 0.02, 0, 0),
                                    padding: EdgeInsets.fromLTRB(
                                        screenWidth * 0.03, 0, 0, 0),
                                    alignment: Alignment.centerLeft,
                                    width: screenWidth * 0.9,
                                    height: screenheight * 0.07,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.5),
                                          spreadRadius: 3,
                                          blurRadius: 3,
                                          offset: const Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: TextField(
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Password nova',
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              // Based on passwordVisible state choose the icon
                                              activatedPassword2
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              color: Colors.black,
                                            ),
                                            onPressed: () {
                                              // Update the state i.e. toogle the state of passwordVisible variable
                                              setState(() {
                                                activatedPassword2 =
                                                    !activatedPassword2;
                                              });
                                            },
                                          ),
                                        ),
                                        obscureText: !activatedPassword2,
                                        onChanged: (text) {
                                          setState(() {
                                            newPassword = text;
                                          });
                                        }),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                if (oldPassword == '' && newPassword == '') {
                                  Navigator.pop(context);
                                  hamburgerChange();
                                } else {
                                  final obj = {
                                    "password": oldPassword,
                                    "newPassword": newPassword
                                  };
                                  postData(obj);
                                }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.fromLTRB(
                                    0, screenheight * 0.05, 0, 0),
                                width: screenWidth * 0.4,
                                height: screenheight * 0.08,
                                decoration: BoxDecoration(
                                    color: const Color(0xffF5A636),
                                    borderRadius: BorderRadius.circular(50)),
                                child: const Text(
                                  'APLICAR',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ))),
        ],
      ),
    );
  }
}
