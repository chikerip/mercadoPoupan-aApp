import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mercadopoupanca/routeGenerate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  await Hive.initFlutter();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // ignore: unused_local_variable
  var box = await Hive.openBox('localStorage');
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final _localStorage = Hive.box('localStorage');
  _localStorage.put('urlApi', 'http://192.168.1.215:8080');
  //_localStorage.put('shop', null);

  runApp(const MyApp());
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: GoogleFonts.montserrat().fontFamily,
      ),
      title: 'Mercado Poupança',
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}