// ignore_for_file: file_names

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppAdvertsBar extends StatefulWidget {
  const AppAdvertsBar({super.key});

  @override
  State<AppAdvertsBar> createState() => _AppAdvertsBar();
}

class _AppAdvertsBar extends State<AppAdvertsBar> {
   String img = 'lib/img/NovoProjeto.png';
  int i = 0;
  bool color = true;
  bool imgOpacity = true;

  @override
  void initState () {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
  ]);
    super.initState();

    Timer.periodic(const Duration(seconds: 10), (timer) {
      setState(() {
        if(i == 0){
          imgOpacity = !imgOpacity;
          color = !color;
          i = i + 1;
        } else {
          imgOpacity = !imgOpacity;
          color = !color;
          i = i - 1;
        }
      });
    });
  }
  
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Row(
        children: [
          AnimatedContainer(
            onEnd: () {
              setState(() {
                if(i == 0){
                  img = 'lib/img/NovoProjeto.png';
                } else {
                  img = 'lib/img/sddefault.jpg';
                }
                imgOpacity = !imgOpacity;
              });
            },
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOut,
            color: color ? const Color(0xFF508932): Colors.black,
            width: screenWidth,
            height: screenheight * 0.07,
            child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                  opacity:  imgOpacity ? 1.0 : 0.0,
                  child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Image.asset(
                    img,
                    width: 150,
                    height: 50,
                ),
                 Padding(
                  padding: EdgeInsets.only(right: screenWidth * 0.05),
                  child: Text(
                  'Saiba mais',
                  style: TextStyle(
                    color: Colors.white, 
                    fontSize: (screenheight / screenWidth) * 8,
                  ),
                ),
                ),
              ],
            ), 
            ),
          ),
        ],
    );
  }
}
