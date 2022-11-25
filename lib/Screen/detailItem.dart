//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailItem extends StatefulWidget {
  final int id;
  final String item;
  const DetailItem({Key? key, required this.id, required this.item})
      : super(key: key);

  @override
  _DetailItemState createState() => _DetailItemState();
}

class _DetailItemState extends State<DetailItem> {
  late Future<Item> items;
  @override
  void initState() {
    super.initState();
    items = fetchitems(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text('Item'), backgroundColor: Colors.lightBlue[900]),
      backgroundColor: Colors.grey[400],
      body: Center(
          child: FutureBuilder(
        builder: (context, AsyncSnapshot<Item> snapshot) {
          if (snapshot.hasData) {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: Image.network(
                    snapshot.data!.Gambar,
                    scale: 3,
                  )),
                  Text(" ${snapshot.data!.item ?? ''}",
                      style: const TextStyle(fontSize: 15)),
                  const Text(
                    "Info :",
                    style: TextStyle(color: Colors.black, fontSize: 13),
                  ),
                  Text(" ${snapshot.data!.info ?? ''}"),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Wrap(
                      direction: Axis.horizontal,
                      alignment: WrapAlignment.start,
                      children: [
                        const Text(
                          "Harga :",
                          style: TextStyle(color: Colors.black, fontSize: 13),
                        ),
                        Text(" ${snapshot.data!.harga ?? ''}"),
                      ],
                    ),
                  ),
                ]);
          } else if (snapshot.hasError) {
            print(snapshot.error.toString());
            return const Center(child: Text('Something went wrong :('));
          }
          return const CircularProgressIndicator();
        },
        future: items,
      )),
    );
  }
}

class Item {
  int? iditem;
  String? item;
  String? info;
  String? harga;
  String Gambar;

  Item({
    this.iditem,
    this.item,
    this.info,
    this.harga,
    required this.Gambar,
  });
  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
        iditem: json['id'] as int,
        item: json['item'] as String,
        info: json['Info'] as String,
        harga: json['harga'] as String,
        Gambar: json['Gambar'] as String);
  }
}

Future<Item> fetchitems(id) async {
  print(id);
  final response =
      await http.get(Uri.parse('http://localhost:3000/dotaitem/${id}'));
  if (response.statusCode == 200) {
    print(response.body);

    return Item.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load episodes');
  }
}
