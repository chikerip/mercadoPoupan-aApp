// ignore_for_file: file_names

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HamburgerMenu extends StatefulWidget {
  const HamburgerMenu({super.key});

  @override
  State<HamburgerMenu> createState() => _HamburgerMenu();
}

class _HamburgerMenu extends State<HamburgerMenu> {
  bool hamburgerOn = false;
  bool iconsHamburgerOn = true;
  final _localStorage = Hive.box('localStorage');
  bool hamburgerDirection = true;

  void initState(){
    super.initState();
    
    if(_localStorage.get('hamburgerDirection') == null){
      _localStorage.put('hamburgerDirection', true);
    }

    setState(() {
      hamburgerDirection = _localStorage.get('hamburgerDirection');
    });
  }

  @override
  Widget build(BuildContext context){
    double screenWidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Row(
      mainAxisAlignment: hamburgerDirection ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 5, 5),
          child: GestureDetector(
            onTap: () {
              setState(() {
                if(hamburgerOn == false){
                  iconsHamburgerOn = !iconsHamburgerOn;
                }
              });

              Timer(const Duration(milliseconds: 100), () {
                setState(() {
                  if(hamburgerOn == false){
                    hamburgerOn = !hamburgerOn;
                  }
                });
              });
            },
            onHorizontalDragEnd:(details) {
              setState(() {
                if(hamburgerOn == true){
                  iconsHamburgerOn = !iconsHamburgerOn;
                }
              });

              Timer(const Duration(milliseconds: 100), () {
                setState(() {
                  if(hamburgerOn == true){
                    hamburgerOn = !hamburgerOn;
                  }
                });
              });
            },
            child: AnimatedContainer(
              onEnd: () {
                setState(() {
                  iconsHamburgerOn = !iconsHamburgerOn;
                });
              },
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              height: screenheight * 0.1,
              width: hamburgerOn ? screenWidth * 0.95 : screenWidth * 0.22,
              decoration: BoxDecoration(
                color: const Color(0xffF5A636),
                border: Border.all(
                  color: const Color(0xffF5A636),
                ),
                borderRadius: const BorderRadius.all(Radius.circular(50))
              ),
              child: SafeArea(
                top: false,
                  child: Visibility(
                  visible: hamburgerOn,
                  replacement: AnimatedOpacity(
                    duration: const Duration(milliseconds: 100),
                    curve: Curves.easeOut,
                    opacity: iconsHamburgerOn ? 1 : 0,
                    child: const Icon(
                      Icons.list,
                      color: Colors.white,
                    )
                  ),
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 100),
                    curve: Curves.easeOut,
                    opacity: iconsHamburgerOn ? 1 : 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushReplacementNamed('/');
                          },
                          child: const Icon(
                            Icons.home,
                            color: Colors.white,
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            _localStorage.put('searchStatus', 'cancel');
                            Navigator.of(context).pushReplacementNamed('/catalog');
                          },
                          child: const Icon(
                            Icons.list,
                            color: Colors.white,
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            _localStorage.put('searchStatus', 'cancel');
                            Navigator.of(context).pushReplacementNamed('/cart');
                          },
                          child: const Icon(
                            Icons.shopping_bag,
                            color: Colors.white,
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            _localStorage.put('searchStatus', 'cancel');
                            if(_localStorage.get('token') == null){
                              Navigator.of(context).pushNamed('/login');
                            } else {
                              Navigator.of(context).pushReplacementNamed('/account');
                            }
                          },
                          child: const Icon(
                            Icons.account_circle,
                            color: Colors.white,
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
