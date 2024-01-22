// ignore_for_file: file_names, camel_case_types, unnecessary_cast, unused_element, dead_code, use_build_context_synchronously, unnecessary_string_interpolations
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mercadopoupanca/components/AppAdvertsBar.dart';
import 'package:mercadopoupanca/components/bottomAppBar.dart';
import 'package:mercadopoupanca/pages/accountPage/models/post.dart';
import 'package:mercadopoupanca/pages/accountPage/services/remote_services.dart';

class accountPage extends StatefulWidget {
  const accountPage({super.key});

  @override
  State<accountPage> createState() => _accountPage();
}

class _accountPage extends State<accountPage> {
  final _localStorage = Hive.box('localStorage');
  PlatformFile? imageFile;
  UploadTask? uploadTask;
  bool imageLoding = false;
  bool newImage = false;
  bool isLoaded = false;
  bool edit = false;
  List<Post>? posts;
  List<Post>? apiPost;
  String image = '';
  String name = '';
  String adress = '';
  String phoneNumber = '';
  String nif = '';

  Future uploadImage() async {
    setState(() {
      imageLoding = true;
    });
    final result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        imageFile = result.files.first;
      });

      final path = 'users/${imageFile!.name}';
      final file = File(imageFile!.path!);
      final ref = FirebaseStorage.instance.ref().child(path);
      setState(() {
        uploadTask = ref.putFile(file);
      });

      final snapshot = await uploadTask!.whenComplete(() => {});
      final urlDownload = await snapshot.ref.getDownloadURL();

      setState(() {
        imageLoding = false;
        image = urlDownload;
        newImage = true;
        uploadTask = null;
      });
    } else {
      setState(() {
        imageLoding = false;
      });
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
                content: Text("Nenhum ficheiro selecionado"),
              ));
    }
  }

  @override
  void initState() {
    _localStorage.put('lastPage', '/account');
    super.initState();

    getData(_localStorage.get("token"));
  }

  getData(token) async {
    apiPost = await RemoteServicesAccount().getPosts(
        'https://mercadopoupanca.azurewebsites.net/user?type=userInfo', token);

    if (apiPost != null) {
      setState(() {
        isLoaded = true;
        posts = apiPost;
      });
    } else {
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
                content: Text("Login expirado"),
              ));
      _localStorage.put("token", null);
      Navigator.of(context).pushNamed('/login');
    }
  }

  postData(body) async {
    final result = await RemoteServicesAccount().postData(
        'https://mercadopoupanca.azurewebsites.net/user?type=adress',
        _localStorage.get('token'),
        body);

    if (result != null) {
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
                content: Text("dados atualizados"),
              ));
      getData(_localStorage.get('token'));
    } else {
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
                content: Text("erro ao enviar os dados"),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Container(
            color: const Color(0xffD9D9D9),
            height: screenheight,
            width: screenWidth,
            child: Stack(
              children: [
                Column(
                  children: [
                    const AppAdvertsBar(),
                    Expanded(
                        child: Visibility(
                            replacement: const Center(
                              child: CircularProgressIndicator(),
                            ),
                            visible: isLoaded,
                            child: ListView.builder(
                                itemCount: 1,
                                itemBuilder: (context, index) {
                                  return Container(
                                      color: const Color(0xffD9D9D9),
                                      height: screenheight * 0.9,
                                      width: screenWidth,
                                      child: Container(
                                          alignment: Alignment.topCenter,
                                          child: Column(children: [
                                            Container(
                                              width: screenWidth * 0.92,
                                              height: screenheight * 0.05,
                                              color: const Color(0xffD9D9D9),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  IconButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pushReplacementNamed(
                                                                '/');
                                                      },
                                                      icon: const Icon(Icons
                                                          .arrow_back_ios)),
                                                  const Text(
                                                    'Perfil',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.of(context)
                                                          .pushNamed(
                                                              '/settings');
                                                    },
                                                    child: SizedBox(
                                                        width:
                                                            screenWidth * 0.1,
                                                        height:
                                                            screenheight * 0.1,
                                                        child: const Icon(
                                                            Icons.settings)),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                                alignment: Alignment.center,
                                                margin: EdgeInsets.fromLTRB(
                                                    0,
                                                    screenheight * 0.01,
                                                    0,
                                                    screenheight * 0.01),
                                                width: 125,
                                                height: 125,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                    border: Border.all(
                                                        color: const Color(
                                                            0xffF5A636),
                                                        width: 3)),
                                                child: Stack(
                                                  children: [
                                                    Visibility(
                                                      visible: imageLoding,
                                                      replacement: CircleAvatar(
                                                        radius: 100,
                                                        backgroundColor:
                                                            Colors.white,
                                                        child: ClipOval(
                                                          child: Image.network(
                                                            newImage
                                                                ? '$image'
                                                                : '${posts![0].image}',
                                                            fit: BoxFit.cover,
                                                            width: 150,
                                                            height: 150,
                                                          ),
                                                        ),
                                                      ),
                                                      child: StreamBuilder<
                                                              TaskSnapshot>(
                                                          stream: uploadTask
                                                              ?.snapshotEvents,
                                                          builder: (context,
                                                              snapshot) {
                                                            if (snapshot
                                                                .hasData) {
                                                              final data =
                                                                  snapshot
                                                                      .data!;
                                                              double progress =
                                                                  data.bytesTransferred /
                                                                      data.totalBytes;

                                                              return Container(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                width: 150,
                                                                height: 150,
                                                                child:
                                                                    CircularProgressIndicator(
                                                                  value:
                                                                      progress,
                                                                ),
                                                              );
                                                            } else {
                                                              return const SizedBox(
                                                                width: 150,
                                                                height: 150,
                                                              );
                                                            }
                                                          }),
                                                    ),
                                                    Visibility(
                                                      visible: edit,
                                                      child: Positioned(
                                                          bottom: 0,
                                                          right: 0,
                                                          child:
                                                              GestureDetector(
                                                            onTap: () {
                                                              uploadImage();
                                                            },
                                                            child: Container(
                                                              width: 35,
                                                              height: 35,
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              decoration: BoxDecoration(
                                                                  color: const Color(
                                                                      0xffF5A636),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              100),
                                                                  border: Border.all(
                                                                      color: const Color(
                                                                          0xffF5A636),
                                                                      width:
                                                                          3)),
                                                              child: const Icon(
                                                                Icons
                                                                    .photo_camera,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          )),
                                                    ),
                                                  ],
                                                )),
                                            SizedBox(
                                              child: Column(
                                                children: [
                                                  Column(
                                                    children: [
                                                      Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  0,
                                                                  screenheight *
                                                                      0.02,
                                                                  0,
                                                                  0),
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  screenWidth *
                                                                      0.05,
                                                                  0,
                                                                  0,
                                                                  0),
                                                          width:
                                                              screenWidth *
                                                                  0.95,
                                                          height: screenheight *
                                                              0.02,
                                                          child: const Text(
                                                              'Nome:')),
                                                      Container(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        margin:
                                                            EdgeInsets.fromLTRB(
                                                                0,
                                                                screenheight *
                                                                    0.01,
                                                                0,
                                                                0),
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                screenWidth *
                                                                    0.05,
                                                                0,
                                                                0,
                                                                0),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          boxShadow: const [
                                                            BoxShadow(
                                                              color:
                                                                  Colors.grey,
                                                              spreadRadius: 5,
                                                              blurRadius: 6,
                                                              offset: Offset(0,
                                                                  3), // changes position of shadow
                                                            ),
                                                          ],
                                                        ),
                                                        width:
                                                            screenWidth * 0.85,
                                                        height:
                                                            screenheight * 0.06,
                                                        child: Visibility(
                                                          visible: edit,
                                                          replacement: Text(
                                                              '${posts![0].name}'),
                                                          child: TextField(
                                                              decoration:
                                                                  InputDecoration(
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                                hintText:
                                                                    '${posts![0].name}',
                                                              ),
                                                              onChanged:
                                                                  (text) {
                                                                if (text ==
                                                                    '') {
                                                                  setState(() {
                                                                    name = posts![
                                                                            0]
                                                                        .name;
                                                                  });
                                                                } else {
                                                                  setState(() {
                                                                    name = text;
                                                                  });
                                                                }
                                                              }),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  0,
                                                                  screenheight *
                                                                      0.02,
                                                                  0,
                                                                  0),
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  screenWidth *
                                                                      0.05,
                                                                  0,
                                                                  0,
                                                                  0),
                                                          width:
                                                              screenWidth *
                                                                  0.95,
                                                          height: screenheight *
                                                              0.02,
                                                          child: const Text(
                                                              'Morada:')),
                                                      Container(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        margin:
                                                            EdgeInsets.fromLTRB(
                                                                0,
                                                                screenheight *
                                                                    0.01,
                                                                0,
                                                                0),
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                screenWidth *
                                                                    0.05,
                                                                0,
                                                                0,
                                                                0),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          boxShadow: const [
                                                            BoxShadow(
                                                              color:
                                                                  Colors.grey,
                                                              spreadRadius: 5,
                                                              blurRadius: 6,
                                                              offset: Offset(0,
                                                                  3), // changes position of shadow
                                                            ),
                                                          ],
                                                        ),
                                                        width:
                                                            screenWidth * 0.85,
                                                        height:
                                                            screenheight * 0.06,
                                                        child: Visibility(
                                                          visible: edit,
                                                          replacement: Text(
                                                              '${posts![0].adress}'),
                                                          child: TextField(
                                                              decoration:
                                                                  InputDecoration(
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                                hintText:
                                                                    '${posts![0].adress}',
                                                              ),
                                                              onChanged:
                                                                  (text) {
                                                                if (text ==
                                                                    '') {
                                                                  setState(() {
                                                                    adress = posts![
                                                                            0]
                                                                        .adress;
                                                                  });
                                                                } else {
                                                                  setState(() {
                                                                    adress =
                                                                        text;
                                                                  });
                                                                }
                                                              }),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  0,
                                                                  screenheight *
                                                                      0.02,
                                                                  0,
                                                                  0),
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  screenWidth *
                                                                      0.05,
                                                                  0,
                                                                  0,
                                                                  0),
                                                          width:
                                                              screenWidth *
                                                                  0.95,
                                                          height: screenheight *
                                                              0.02,
                                                          child: const Text(
                                                              'Telemovel:')),
                                                      Container(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        margin:
                                                            EdgeInsets.fromLTRB(
                                                                0,
                                                                screenheight *
                                                                    0.01,
                                                                0,
                                                                0),
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                screenWidth *
                                                                    0.05,
                                                                0,
                                                                0,
                                                                0),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          boxShadow: const [
                                                            BoxShadow(
                                                              color:
                                                                  Colors.grey,
                                                              spreadRadius: 5,
                                                              blurRadius: 6,
                                                              offset: Offset(0,
                                                                  3), // changes position of shadow
                                                            ),
                                                          ],
                                                        ),
                                                        width:
                                                            screenWidth * 0.85,
                                                        height:
                                                            screenheight * 0.06,
                                                        child: Visibility(
                                                          visible: edit,
                                                          replacement: Text(
                                                              '${posts![0].phoneNumber}'),
                                                          child: TextField(
                                                              decoration:
                                                                  InputDecoration(
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                                hintText:
                                                                    '${posts![0].phoneNumber}',
                                                              ),
                                                              onChanged:
                                                                  (text) {
                                                                if (text ==
                                                                    '') {
                                                                  setState(() {
                                                                    phoneNumber =
                                                                        posts![0]
                                                                            .phoneNumber;
                                                                  });
                                                                } else {
                                                                  setState(() {
                                                                    phoneNumber =
                                                                        text;
                                                                  });
                                                                }
                                                              }),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  0,
                                                                  screenheight *
                                                                      0.02,
                                                                  0,
                                                                  0),
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  screenWidth *
                                                                      0.05,
                                                                  0,
                                                                  0,
                                                                  0),
                                                          width:
                                                              screenWidth *
                                                                  0.95,
                                                          height: screenheight *
                                                              0.02,
                                                          child: const Text(
                                                              'Nif:')),
                                                      Container(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        margin:
                                                            EdgeInsets.fromLTRB(
                                                                0,
                                                                screenheight *
                                                                    0.01,
                                                                0,
                                                                0),
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                screenWidth *
                                                                    0.05,
                                                                0,
                                                                0,
                                                                0),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          boxShadow: const [
                                                            BoxShadow(
                                                              color:
                                                                  Colors.grey,
                                                              spreadRadius: 5,
                                                              blurRadius: 6,
                                                              offset: Offset(0,
                                                                  3), // changes position of shadow
                                                            ),
                                                          ],
                                                        ),
                                                        width:
                                                            screenWidth * 0.85,
                                                        height:
                                                            screenheight * 0.06,
                                                        child: Visibility(
                                                          visible: edit,
                                                          replacement: Text(
                                                              '${posts![0].nif}'),
                                                          child: TextField(
                                                              decoration:
                                                                  InputDecoration(
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                                hintText:
                                                                    '${posts![0].nif}',
                                                              ),
                                                              onChanged:
                                                                  (text) {
                                                                if (text ==
                                                                    '') {
                                                                  setState(() {
                                                                    nif = posts![
                                                                            0]
                                                                        .nif;
                                                                  });
                                                                } else {
                                                                  setState(() {
                                                                    nif = text;
                                                                  });
                                                                }
                                                              }),
                                                        ),
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
                                                      _localStorage.put(
                                                          "token", null);
                                                      _localStorage.put(
                                                          "admin", null);
                                                      Navigator.of(context)
                                                          .pushNamed('/');
                                                    },
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              0,
                                                              screenheight *
                                                                  0.02,
                                                              0,
                                                              0),
                                                      width: screenWidth * 0.35,
                                                      height:
                                                          screenheight * 0.06,
                                                      decoration: BoxDecoration(
                                                        color: const Color(
                                                            0xffD30606),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                        boxShadow: const [
                                                          BoxShadow(
                                                            color: Colors.grey,
                                                            spreadRadius: 5,
                                                            blurRadius: 6,
                                                            offset: Offset(0,
                                                                3), // changes position of shadow
                                                          ),
                                                        ],
                                                      ),
                                                      child: const Text(
                                                        'LOGOUT',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        if (edit == false) {
                                                          edit = !edit;
                                                        } else {
                                                          edit = !edit;
                                                          setState(() {
                                                            if (image == '') {
                                                              image = posts![0]
                                                                  .image;
                                                            }
                                                            if (name == '') {
                                                              name = posts![0]
                                                                  .name;
                                                            }
                                                            if (adress == '') {
                                                              adress = posts![0]
                                                                  .adress;
                                                            }
                                                            if (phoneNumber ==
                                                                '') {
                                                              phoneNumber =
                                                                  posts![0]
                                                                      .phoneNumber;
                                                            }
                                                            if (nif == '') {
                                                              nif =
                                                                  posts![0].nif;
                                                            }
                                                          });

                                                          var obj = {
                                                            "image": image,
                                                            "name": name,
                                                            "adress": adress,
                                                            "phoneNumber":
                                                                phoneNumber,
                                                            "nif": nif
                                                          };

                                                          postData(obj);
                                                        }
                                                      });
                                                    },
                                                    child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        margin:
                                                            EdgeInsets.fromLTRB(
                                                                screenWidth *
                                                                    0.05,
                                                                screenheight *
                                                                    0.02,
                                                                0,
                                                                0),
                                                        width:
                                                            screenWidth * 0.45,
                                                        height:
                                                            screenheight * 0.06,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: const Color(
                                                              0xff1E81AC),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                          boxShadow: const [
                                                            BoxShadow(
                                                              color:
                                                                  Colors.grey,
                                                              spreadRadius: 5,
                                                              blurRadius: 6,
                                                              offset: Offset(0,
                                                                  3), // changes position of shadow
                                                            ),
                                                          ],
                                                        ),
                                                        child: const Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Icon(
                                                              Icons.edit,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            Text(
                                                              'EDITAR',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ],
                                                        )),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ])));
                                }))),
                  ],
                ),
                Positioned(
                    left: 0,
                    bottom: 0,
                    child: Visibility(
                        visible: !edit,
                        child: SizedBox(
                          width: screenWidth,
                          height: screenheight * 0.11,
                          child: const HamburgerMenu(),
                        )))
              ],
            )));
  }
}
