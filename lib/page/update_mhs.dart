import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:izbakery/util/rounded_button.dart';

late User loggedinUser;

class UpdateMhs extends StatefulWidget {
  const UpdateMhs({super.key});
  @override
  State<UpdateMhs> createState() => _UpdateMhsState();
}

class _UpdateMhsState extends State<UpdateMhs> {
  final _auth = FirebaseAuth.instance;
  final textNamaController = new TextEditingController();
  final textNrpController = new TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection('users');
          return Scaffold(
              appBar: AppBar(
                actions: <Widget>[
                ],
                title: Text('Update Data Mahasiswa'),
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
                            "Data Mahasiswa",
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                          TextFormField(
                            controller: textNamaController,
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
                            controller: textNrpController,
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