// ignore_for_file: file_names, no_leading_underscores_for_local_identifiers

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mercadopoupanca/pages/splashPage/model/adsModel.dart';
import 'package:url_launcher/url_launcher.dart';

class AppAdvertsBar extends StatefulWidget {
  const AppAdvertsBar({super.key});

  @override
  State<AppAdvertsBar> createState() => _AppAdvertsBar();
}

class _AppAdvertsBar extends State<AppAdvertsBar> {
  final _localStorage = Hive.box('localStorage');
  String url = '';
  List<Ads>? ads;
  late Map<int, String> colors;
  String img = '';
  int i = 0;
  bool imgOpacity = true;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    super.initState();
    setState(() {
      ads = adsFromJson(_localStorage.get('ads'));
      img = ads![i].image;
      final split = (ads![i].color).split(',');
      colors = {for (int i = 0; i < split.length; i++) i: split[i]};
      i++;
    });

    Timer.periodic(const Duration(seconds: 10), (timer) {
      setState(() {
        if (i == ads!.length) {
          i = 0;
          imgOpacity = !imgOpacity;
          img = ads![i].image;
          url = ads![i].link;
          final split = (ads![i].color).split(',');
          colors = {for (int i = 0; i < split.length; i++) i: split[i]};
          i++;
        } else {
          imgOpacity = !imgOpacity;
          img = ads![i].image;
          url = ads![i].link;
          final split = (ads![i].color).split(',');
          colors = {for (int i = 0; i < split.length; i++) i: split[i]};
          i++;
        }
      });
    });
  }

  Future<void> _launchUrl() async {
    final Uri _url = Uri.parse(url);
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
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
              imgOpacity = !imgOpacity;
            });
          },
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOut,
          color: Color.fromRGBO(int.parse(colors[0]!), int.parse(colors[1]!),
              int.parse(colors[2]!), 1.0),
          width: screenWidth,
          height: screenheight * 0.07,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
            opacity: imgOpacity ? 1.0 : 0.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Image.network(
                  img,
                  width: 150,
                  height: 50,
                ),
                Padding(
                    padding: EdgeInsets.only(right: screenWidth * 0.05),
                    child: GestureDetector(
                      onTap: () {
                        _launchUrl();
                      },
                      child: Text(
                        'Saiba mais',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: (screenheight / screenWidth) * 8,
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
