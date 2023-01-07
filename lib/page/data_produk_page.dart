import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:izbakery/page/add_product.dart';
import 'package:izbakery/page/home_page.dart';
import 'package:izbakery/page/item_card.dart';
import 'package:izbakery/util/rounded_button.dart';

late User loggedinUser;

class DataProduk extends StatefulWidget {
  @override
  _DataProduk createState() => _DataProduk();
}

class _DataProduk extends State<DataProduk> {
  final _auth = FirebaseAuth.instance;
  final TextEditingController namaController = TextEditingController();
  final TextEditingController jenisController = TextEditingController();
  final TextEditingController hargaController = TextEditingController();
  final TextEditingController stokController = TextEditingController();
  final TextEditingController deskripsiController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference produk = firestore.collection('produk');

    return Scaffold(
      appBar: AppBar(
        leading: null,
        backgroundColor: Color.fromARGB(255, 139, 65, 8),
        title: Text('Data Produk'),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, 'add_produk');
              },
              child: const Icon(
                Icons.add,
                size: 26.0,
              ),
            ),
          ),
        ],
      ),
      body: Center(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: [
              StreamBuilder(
                  stream: produk.snapshots(),
                  builder: (_, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: snapshot.data!.docs
                            .map((e) => ItemCard(
                                    (e.data() as dynamic)['nama'],
                                    (e.data() as dynamic)['jenis'], 
                                    (e.data() as dynamic)['harga'],
                                    (e.data() as dynamic)['stock'],
                                    (e.data() as dynamic)['deskripsi'], 
                                    onDelete: () {
                                  produk.doc(e.id).delete();
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
      drawer: Drawer(
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
