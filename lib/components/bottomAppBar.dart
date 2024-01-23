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

  @override
  void initState() {
    super.initState();

    if (_localStorage.get('hamburgerDirection') == null) {
      _localStorage.put('hamburgerDirection', true);
    }

    setState(() {
      hamburgerDirection = _localStorage.get('hamburgerDirection');
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Row(
      mainAxisAlignment:
          hamburgerDirection ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 5, 5),
          child: GestureDetector(
            onTap: () {
              setState(() {
                if (hamburgerOn == false) {
                  iconsHamburgerOn = !iconsHamburgerOn;
                }
              });

              Timer(const Duration(milliseconds: 100), () {
                setState(() {
                  if (hamburgerOn == false) {
                    hamburgerOn = !hamburgerOn;
                  }
                });
              });
            },
            onHorizontalDragEnd: (details) {
              setState(() {
                if (hamburgerOn == true) {
                  iconsHamburgerOn = !iconsHamburgerOn;
                }
              });

              Timer(const Duration(milliseconds: 100), () {
                setState(() {
                  if (hamburgerOn == true) {
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
                  borderRadius: const BorderRadius.all(Radius.circular(50))),
              child: SafeArea(
                top: false,
                child: Visibility(
                  visible: hamburgerOn,
                  replacement: AnimatedOpacity(
                      duration: const Duration(milliseconds: 100),
                      curve: Curves.easeOut,
                      opacity: iconsHamburgerOn ? 1 : 0,
                      child: SizedBox(
                        width: screenWidth * 0.2,
                        height: screenWidth * 0.2,
                        child: Image.asset(
                          'assets/icons/menu.png',
                          fit: BoxFit.cover,
                          width: screenWidth * 0.01,
                        ),
                      )),
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 100),
                    curve: Curves.easeOut,
                    opacity: iconsHamburgerOn ? 1 : 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _localStorage.put('searchStatus', 0);
                            _localStorage.put('catalogStatus', 'cancel');
                            Navigator.of(context).pushReplacementNamed('/');
                          },
                          child: Icon(
                            Icons.home_rounded,
                            color: Colors.white,
                            size: (screenWidth / screenheight) * 100,
                          ),
                        ),
                        GestureDetector(
                            onTap: () {
                              _localStorage.put('searchStatus', 'cancel');
                              _localStorage.put('catalogStatus', 'cancel');
                              Navigator.of(context)
                                  .pushReplacementNamed('/catalog');
                            },
                            child: Image.asset(
                              'assets/icons/file.png',
                              width: screenWidth * 0.07,
                            )),
                        GestureDetector(
                          onTap: () {
                            _localStorage.put('searchStatus', 'cancel');
                            _localStorage.put('catalogStatus', 'cancel');
                            Navigator.of(context).pushNamed('/cart');
                          },
                          child: Image.asset(
                            'assets/icons/bagwhite.png',
                            width: screenWidth * 0.08,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _localStorage.put('searchStatus', 'cancel');
                            _localStorage.put('catalogStatus', 'cancel');
                            if (_localStorage.get('token') == null) {
                              Navigator.of(context).pushNamed('/login');
                            } else {
                              Navigator.of(context)
                                  .pushReplacementNamed('/account');
                            }
                          },
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                            size: (screenWidth / screenheight) * 100,
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
