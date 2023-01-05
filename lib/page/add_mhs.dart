import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:izbakery/util/rounded_button.dart';

late User loggedinUser;

class AddMhs extends StatefulWidget {
  const AddMhs({super.key});
  @override
  State<AddMhs> createState() => _AddMhsState();
}

class _AddMhsState extends State<AddMhs> {
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
                          return 'Nama dibutuhkan';
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
        ));
  }
}
