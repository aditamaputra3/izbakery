import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:izbakery/page/item_card.dart';
import 'package:izbakery/page/welcome_page.dart';
import 'package:izbakery/util/rounded_button.dart';

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

    return Scaffold(
        appBar: AppBar(
          leading: null,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  //
                  Navigator.pushNamed(context, 'add_mhs');
                },
                child: const Icon(
                  Icons.add,
                  size: 26.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context,'');
                },
                child: const Icon(
                  Icons.search,
                  size: 26.0,
                ),
              ),
            ),
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
          title: Text('Data Mahasiswa'),
          backgroundColor: Colors.lightBlueAccent,
        ),
        body: SingleChildScrollView(
          child: Center(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: [
//// VIEW DATA HERE
                  StreamBuilder(
                      stream: users.snapshots(),
                      builder: (_, snapshot) {
                        if (snapshot.hasData) {
                          return Column(
                            children: snapshot.data!.docs
                                .map((e) => ItemCard(
                                        (e.data() as dynamic)['nama'],
                                        (e.data() as dynamic)['nrp'],
                                        onDelete: () {
                                      users.doc(e.id).delete();
                                    }))
                                .toList() as List<Widget>,
                          );
                        } else {
                          return Text('Loading');
                        }
                        throw '';
                      })
                ],
              ),
            ]),
          )),
        ));
  }
}
