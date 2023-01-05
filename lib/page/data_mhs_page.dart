import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:izbakery/page/item_card.dart';
import 'package:izbakery/util/rounded_button.dart';

late User loggedinUser;

class DataMhs extends StatefulWidget {
  @override
  _DataMhs createState() => _DataMhs();
}

class _DataMhs extends State<DataMhs> {
  final _auth = FirebaseAuth.instance;
  final TextEditingController namaController = TextEditingController();
  final TextEditingController nrpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection('users');
    
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.pushNamed(context, 'home_screen');
//Implement logout functionality
              }),
        ],
        title: Text('Data Mahasiswa'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Center(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                            .map((e) => ItemCard((e.data() as dynamic)['nama'],
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
    );
  }
}
