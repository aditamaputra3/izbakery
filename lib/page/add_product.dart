import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:izbakery/page/data_produk_page.dart';
import 'package:izbakery/page/home_page.dart';
import 'package:izbakery/util/rounded_button.dart';

late User loggedinUser;

class AddProduk extends StatefulWidget {
  const AddProduk({super.key});
  @override
  State<AddProduk> createState() => _AddProdukState();
}

class _AddProdukState extends State<AddProduk> {
  String? _nama;
  String? _nrp;

  final _auth = FirebaseAuth.instance;
  var _textNamaController = new TextEditingController();
  var _textNrpController = new TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection('users');

    return Scaffold(
        appBar: AppBar(
          title: Text('Tambah Data Mahasiswa'),
          backgroundColor: Colors.lightBlueAccent,
        ),
        body: Center(
          child: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Welcome Mahasiswa",
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    TextFormField(
                      controller: _textNamaController,
                      decoration: InputDecoration(hintText: "NAMA"),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Namar dibutuhkan';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    TextFormField(
                      controller: _textNrpController,
                      decoration: InputDecoration(hintText: "NRP"),
                      keyboardType: TextInputType.number,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'NRP dibutuhkan';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 100),
                    RoundedButton(
                        colour: Colors.lightBlueAccent,
                        title: 'Submit',
                        onPressed: () async {
                          final field = _formKey.currentState;

                          if (field != null && !field.validate()) {
                            return;
                          } else {
                            users.add({
                              'nama': _textNamaController.text,
                              'nrp': int.tryParse(_textNrpController.text),
                            });
                            _textNamaController.text = '';
                            _textNrpController.text = '';
                          }
                          AlertDialog alert = AlertDialog(
                            title: Text("Alert"),
                            content: Container(
                              child: Text("Selamat Data Berhasil Dimasukan"),
                            ),
                            actions: [
                              TextButton(
                                child: Text('Ok'),
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                            ],
                          );
                          showDialog(
                              context: context, builder: (context) => alert);
                          return;
                        }),
                  ],
                ),
              )),
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
