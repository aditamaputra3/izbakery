import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:izbakery/page/data_produk_page.dart';
import 'package:izbakery/page/home_page.dart';
import 'package:izbakery/util/rounded_button.dart';

const kTextFieldDecoration = InputDecoration(
    hintText: 'Enter a value',
    hintStyle: TextStyle(color: Colors.grey),
    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(15.0)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide:
          BorderSide(color: Color.fromARGB(255, 187, 111, 53), width: 1.0),
      borderRadius: BorderRadius.all(Radius.circular(15.0)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide:
          BorderSide(color: Color.fromARGB(255, 187, 111, 53), width: 2.0),
      borderRadius: BorderRadius.all(Radius.circular(15.0)),
    ));

late User loggedinUser;

class AddProduk extends StatefulWidget {
  const AddProduk({super.key});
  @override
  State<AddProduk> createState() => _AddProdukState();
}

class _AddProdukState extends State<AddProduk> {
  String? _nama;
  String? _jenis;
  String? _harga;
  String? _stock;
  String? _deskripsi;

  final _auth = FirebaseAuth.instance;
  var _textNamaController = new TextEditingController();
  var _textJenisController = new TextEditingController();
  var _textHargaController = new TextEditingController();
  var _textStockController = new TextEditingController();
  var _textDeskripsiController = new TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference produk = firestore.collection('produk');

    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Data Produk'),
        backgroundColor: Color.fromARGB(255, 139, 65, 8),
      ),
      body: Center(
        child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    'Masukan Data Produk',
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _textNamaController,
                    decoration:
                        kTextFieldDecoration.copyWith(hintText: "Nama Produk"),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Nama dibutuhkan';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextFormField(
                    controller: _textJenisController,
                    decoration:
                        kTextFieldDecoration.copyWith(hintText: "Jenis Produk"),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Jenis Produk dibutuhkan';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextFormField(
                    controller: _textHargaController,
                    decoration:
                        kTextFieldDecoration.copyWith(hintText: "Harga Produk"),
                    keyboardType: TextInputType.number,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Harga Produk dibutuhkan';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextFormField(
                    controller: _textStockController,
                    decoration:
                        kTextFieldDecoration.copyWith(hintText: "Stok Produk"),
                    keyboardType: TextInputType.number,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Stock Produk dibutuhkan';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextFormField(
                    controller: _textDeskripsiController,
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: "Deskripsi Produk"),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Deskripsi Produk dibutuhkan';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  RoundedButton(
                      colour: Color.fromARGB(255, 187, 111, 53),
                      title: 'Simpan',
                      onPressed: () async {
                        final field = _formKey.currentState;

                        if (field != null && !field.validate()) {
                          return;
                        } else {
                          produk.add({
                            'nama': _textNamaController.text,
                            'jenis': _textJenisController.text,
                            'harga': int.tryParse(_textHargaController.text),
                            'stock': int.tryParse(_textStockController.text),
                            'deskripsi': _textDeskripsiController.text,
                          });
                          _textNamaController.text = '';
                          _textJenisController.text = '';
                          _textHargaController.text = '';
                          _textStockController.text = '';
                          _textDeskripsiController.text = '';
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
