import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final String nama;
  final String jenis;
  final int harga;
  final int stock;
  final String deskripsi;
//// Pointer to Update Function
  final Function? onUpdate;
//// Pointer to Delete Function
  final Function? onDelete;
  ItemCard(this.nama, this.jenis, this.harga, this.stock, this.deskripsi,
      {this.onUpdate, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Color.fromARGB(255, 139, 65, 8))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Text(
                  nama,
                ),
              ),
              Text(
                "Rp.$harga ",
              )
            ],
          ),
          Row(
            children: [
              SizedBox(
                height: 40,
                width: 60,
                child: ElevatedButton(
                    child: Center(
                        child: Icon(Icons.edit,
                            color: Color.fromARGB(255, 255, 255, 255))),
                    onPressed: () {
                      style:
                      ElevatedButton.styleFrom(
                        primary: Color.fromARGB(
                            255, 187, 111, 53), // Background color
                      );
                      if (onUpdate != null) onUpdate!();
                      Navigator.pushNamed(context, 'update_produk');
                    }),
              ),
              SizedBox(
                height: 40,
                width: 60,
                child: ElevatedButton(
                    child: Center(
                        child: Icon(
                      Icons.delete,
                      color: Color.fromARGB(255, 255, 255, 255),
                    )),
                    onPressed: () {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Warning"),
                            content: const Text("Remove this data?"),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('CANCEL'),
                                onPressed: () {
                                  // Close Dialog
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: const Text('REMOVE'),
                                onPressed: () {
                                  if (onDelete != null) onDelete!();
                                  Navigator.of(context).pop();
                                },
                              )
                            ],
                          );
                        },
                      );
                    }),
              )
            ],
          )
        ],
      ),
    );
  }
}
