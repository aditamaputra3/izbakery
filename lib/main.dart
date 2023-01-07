import 'dart:async';

import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:izbakery/page/home_page.dart';
import 'package:izbakery/page/login_page.dart';
import 'package:izbakery/page/register_page.dart';
import 'package:izbakery/page/update_product..dart';
import 'package:izbakery/page/welcome_page.dart';
import 'package:izbakery/page/add_product.dart';
import 'package:izbakery/page/data_produk_page.dart';
import 'firebase_options.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 4),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 94, 52, 24),
    child: Column(
            children: <Widget>[
              SvgPicture.asset(
                'lib/assets/Baker-rafiki.svg',
              ),
              //const SizedBox(height: 20.0),
              Text(
                'IZ*BAKERY',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),   
            ],
    ));
  }
}

class MyApp extends StatelessWidget {
// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
	    debugShowCheckedModeBanner: false,
      //initialRoute: 'welcome_screen',
      routes: {
        'welcome_screen': (context) => WelcomeScreen(),
        'registration_screen': (context) => RegistrationScreen(),
        'login_screen': (context) => LoginScreen(),
        'home_screen': (context) => HomeScreen(),
        'add_produk': (context) => AddProduk(),
        'data_produk': (context) => DataProduk(),
        'update_produk': (context) => UpdateProduk(),
      },
    );
  }
}