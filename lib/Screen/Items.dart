// ignore: file_names
// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'detailItem.dart';

class ItemList extends StatefulWidget {
  const ItemList({Key? key}) : super(key: key);

  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  late Future<List<Item>> items;
  @override
  void initState() {
    super.initState();
    items = fetchitems(widget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Items'),
        backgroundColor: Colors.blue[900],
      ),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: FutureBuilder(
          builder: (context, AsyncSnapshot<List<Item>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) =>
                    GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailItem(
                          id: snapshot.data![index].id,
                          item: snapshot.data![index].item,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                        top: 20, bottom: 10, right: 200, left: 200),
                    height: 300,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 0, 0, 0),
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                              ),
                              child: Image.network(snapshot.data![index].Gambar,
                                  scale: 6),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                snapshot.data![index].item,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromARGB(255, 253, 253, 253),
                                    fontSize: 14,
                                    letterSpacing: 0.2),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong :('));
            }
            return const CircularProgressIndicator();
          },
          future: items,
        ),
      ),
    );
  }
}

class Item {
  final int id;
  final String item;
  final String info;
  final String harga;
  final String Gambar;
  Item(
      {required this.id,
      required this.item,
      required this.info,
      required this.harga,
      required this.Gambar});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
        id: json['id'],
        item: json['item'],
        info: json['Info'],
        harga: json['harga'],
        Gambar: json['Gambar']);
  }
}

Future<List<Item>> fetchitems(id) async {
  final response = await http.get(Uri.parse('http://localhost:3000/dotaitem'));

  if (response.statusCode == 200) {
    // Iterable it = jsonDecode(response.body)['dotaitem'] as List;
    Iterable topShowsJson = jsonDecode(response.body) as List;
    return topShowsJson.map((item) => Item.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load items');
  }
}
// class RepositoryItems{
//   final _baseUrl = 'https://my-json-server.typicode.com/saydss/APIDotaItem/db/';

//   Future getData() async{
//     try {
//       final response = await http.get(Uri.parse(_baseUrl));
//        if (response.statusCode == 200) {
//         Iterable it = jsonDecode(response.body);
//         List<Item> detailitem = it.map((e) => Item.fromJson(e)).toList();
//         return detailitem;
//       }
//     } catch (e) {
//       // ignore: avoid_print
//       print(e.toString());
//     }
//   }
// }
// List<Item> listItem = [];
// RepositoryItems repositoryItems = RepositoryItems();