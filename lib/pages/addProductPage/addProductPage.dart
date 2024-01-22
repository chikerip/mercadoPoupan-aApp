// ignore_for_file: file_names, camel_case_types, unnecessary_cast, use_build_context_synchronously
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mercadopoupanca/components/AppAdvertsBar.dart';
import 'package:mercadopoupanca/pages/addProductPage/services/remote_services.dart';

class addProductPage extends StatefulWidget {
  final String data;
  const addProductPage({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<addProductPage> createState() => _addProductPage();
}

class _addProductPage extends State<addProductPage> {
  final _localStorage = Hive.box('localStorage');
  PlatformFile? imageFile;
  UploadTask? uploadTask;
  String productRef = '';
  double price = 0.00;
  String productName = '';
  String productSize = '';
  String productImage = '';
  int promo = 0;
  bool uploadStatus = false;
  bool uploadImg = false;

  Future uploadImage() async {
    final result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        imageFile = result.files.first;
        uploadStatus = true;
      });

      final path = 'products/${imageFile!.name}';
      final file = File(imageFile!.path!);
      final ref = FirebaseStorage.instance.ref().child(path);
      setState(() {
        uploadTask = ref.putFile(file);
      });

      final snapshot = await uploadTask!.whenComplete(() => {});
      final urlDownload = await snapshot.ref.getDownloadURL();

      setState(() {
        productImage = urlDownload;
        uploadImg = true;
        uploadStatus = false;
        uploadTask = null;
      });
    } else {
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
                content: Text("Nenhum ficheiro selecionado"),
              ));
    }
  }

  postData(body) async {
    final result = await RemoteServicesAddProduct().postDB(
        'https://mercadopoupanca.azurewebsites.net/product',
        _localStorage.get('token'),
        body);

    if (result != null) {
      _localStorage.put('backProduct', true);
      Navigator.of(context)
          .pushReplacementNamed('/product', arguments: productRef.toString());
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
                content: Text("Produto criado"),
              ));
    } else {
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
                content: Text("erro ao criar produto"),
              ));
    }
  }

  invalidParams() {
    showDialog(
        context: context,
        builder: (context) => const AlertDialog(
              content: Text("Algum parametro foi mal preenchido"),
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
                      Column(
                        children: [
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
                                  'Adicionar produto',
                                  style: TextStyle(fontWeight: FontWeight.bold),
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
                            alignment: Alignment.center,
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                    color: const Color(0xffF5A636), width: 5)),
                            child: Visibility(
                              visible: uploadImg,
                              replacement: Visibility(
                                visible: uploadStatus,
                                replacement: GestureDetector(
                                  onTap: () {
                                    uploadImage();
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 150,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: const Color(0xffF5A636),
                                    ),
                                    child: const Icon(
                                      Icons.camera_alt,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                child: StreamBuilder<TaskSnapshot>(
                                    stream: uploadTask?.snapshotEvents,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        final data = snapshot.data!;
                                        double progress =
                                            data.bytesTransferred /
                                                data.totalBytes;

                                        return Container(
                                          alignment: Alignment.center,
                                          width: 150,
                                          height: 150,
                                          child: CircularProgressIndicator(
                                            value: progress,
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
                              child: Stack(
                                children: [
                                  CircleAvatar(
                                    radius: 100,
                                    backgroundColor: Colors.white,
                                    child: ClipOval(
                                      child: Image.network(
                                        productImage,
                                        fit: BoxFit.cover,
                                        width: 150,
                                        height: 150,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: GestureDetector(
                                        onTap: () {
                                          uploadImage();
                                        },
                                        child: Container(
                                          width: 35,
                                          height: 35,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: const Color(0xffF5A636),
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              border: Border.all(
                                                  color:
                                                      const Color(0xffF5A636),
                                                  width: 3)),
                                          child: const Icon(
                                            Icons.photo_camera,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(
                                0, screenheight * 0.03, 0, 0),
                            width: screenWidth * 0.9,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Codigo de barras'),
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
                                        offset: const Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: TextField(
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: widget.data,
                                      ),
                                      onChanged: (text) {
                                        setState(() {
                                          if (text == '') {
                                            productRef = widget.data;
                                          } else {
                                            productRef = text;
                                          }
                                        });
                                      }),
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
                                const Text('Nome do produto'),
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
                                        offset: const Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: TextField(
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Insira o nome',
                                      ),
                                      onChanged: (text) {
                                        setState(() {
                                          productName = text;
                                        });
                                      }),
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
                                const Text('Tamanho do produto'),
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
                                        offset: const Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: TextField(
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText:
                                            'Insira o tamanho(xl/ml/kg/g)',
                                      ),
                                      onChanged: (text) {
                                        setState(() {
                                          productSize = text;
                                        });
                                      }),
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
                                const Text('Preço do produto'),
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
                                        offset: const Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: TextField(
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'x.xx',
                                      ),
                                      onChanged: (text) {
                                        setState(() {
                                          price = double.parse(text);
                                        });
                                      }),
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
                                const Text('Promoção do produto'),
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
                                        offset: const Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: TextField(
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText:
                                            'Insira caso tenha (numero inteiro sem %)',
                                      ),
                                      onChanged: (text) {
                                        setState(() {
                                          if (text == '') {
                                            promo = 0;
                                          } else {
                                            promo = int.parse(text);
                                          }
                                        });
                                      }),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (productRef == '') {
                                setState(() {
                                  productRef = widget.data;
                                });
                              }

                              if (productImage == '' ||
                                  productName == '' ||
                                  price == 0.00) {
                                invalidParams();
                              } else {
                                final obj = {
                                  "productRef": productRef,
                                  "productImage": productImage,
                                  "productName": productName,
                                  "productSize": productSize,
                                  "price": price,
                                  "promo": promo
                                };

                                postData(obj);
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.fromLTRB(0,
                                  screenheight * 0.05, 0, screenheight * 0.05),
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
                    ],
                  ))),
        ],
      ),
    );
  }
}
