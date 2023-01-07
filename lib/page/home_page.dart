import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:izbakery/page/add_product.dart';
import 'package:izbakery/page/data_produk_page.dart';
import 'package:izbakery/page/item_card.dart';
import 'package:izbakery/page/welcome_page.dart';
import 'package:izbakery/util/rounded_button.dart';
import 'package:carousel_slider/carousel_slider.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1555507036-ab1f4038808a?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=726&q=80',
  'https://images.unsplash.com/photo-1558961363-fa8fdf82db35?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=465&q=80',
  'https://images.unsplash.com/photo-1506459225024-1428097a7e18?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
  'https://images.unsplash.com/photo-1579697096985-41fe1430e5df?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=872&q=80',
  'https://images.unsplash.com/photo-1511018556340-d16986a1c194?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
  'https://images.unsplash.com/photo-1534432182912-63863115e106?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80'
];

final themeMode = ValueNotifier(2);

late User loggedinUser;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;
  void initState() {
    super.initState();
    getCurrentUser();
  }

//using this function you can use the credentials of the user
  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedinUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection('users');

    final List<Widget> imageSliders = imgList
        .map((item) => Container(
              child: Container(
                margin: EdgeInsets.all(5.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Stack(
                      children: <Widget>[
                        Image.network(item, fit: BoxFit.cover, width: 1000.0),
                        Positioned(
                          bottom: 0.0,
                          left: 0.0,
                          right: 0.0,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(200, 0, 0, 0),
                                  Color.fromARGB(0, 0, 0, 0)
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                            child: Text(
                              'iz*bakery',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('IZBAKERY'),
        backgroundColor: Color.fromARGB(255, 139, 65, 8),
        leading: null,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                _auth.signOut();
                Navigator.pop(context, 'login_page');
              },
              child: const Icon(
                Icons.power_settings_new,
                size: 26.0,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 30),
          CarouselSlider(
            options: CarouselOptions(
              height: 200,
              autoPlay: true,
              aspectRatio: 2.0,
              enlargeCenterPage: true,
            ),
            items: imageSliders,
          ),
          SizedBox(height: 50),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[],
            ),
          ),
        ],
      ),
      drawer: Drawer(
// Add a ListView to the drawer. This ensures the user can scroll
// through the options in the drawer if there isn't enough vertical
// space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              //membuat gambar profil
              currentAccountPicture: Image(
                  image: NetworkImage(
                      "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png")),
              //membuat nama akun
              accountName: Text("admin"),
              //membuat nama email
              accountEmail: Text("admin@gmail.com"),
              //memberikan background
              decoration: BoxDecoration(color: Color.fromARGB(255, 139, 65, 8)),
            ),
            //membuat list menu
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Beranda"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: Text("Tambah Produk"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddProduk(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.list_alt),
              title: Text("List Produk"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DataProduk(),
                  ),
                );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.info),
              title: Text("Tentang"),
              onTap: () {
                AlertDialog alert = AlertDialog(
                  title: Text("Kelompok 1 - IZBAKERY"),
                  content: Container(
                    child: Text(
                        "162020019 Aditama Putra, 162020004 Meissy Arrahma, 162020009 Agil Rasyid, 162020021 Rafi Ramdhan"),
                  ),
                  actions: [
                    TextButton(
                      child: Text('Close'),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                );
                showDialog(context: context, builder: (context) => alert);
                return;
              },
            ),
          ],
        ),
      ),
    );
  }
}
