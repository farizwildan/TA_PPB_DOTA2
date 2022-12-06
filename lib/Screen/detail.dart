import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailPage extends StatefulWidget {
  final int id;
  final String hero;
  const DetailPage({Key? key, required this.id, required this.hero})
      : super(key: key);
  
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late Future<DetailHero> detailheroes;

  @override
  void initState() {
    super.initState();
    detailheroes = fetchdetailheroes(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text('Heroes'), backgroundColor: Colors.lightBlue[900]),
      backgroundColor: Colors.grey[400],
      body: Center(
          child: FutureBuilder(
        builder: (context, AsyncSnapshot<DetailHero> snapshot) {
          if (snapshot.hasData) {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: Image.network(
                    snapshot.data!.Gambarhero,
                    scale: 3,
                  )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Image.network(
                            snapshot.data!.Gambarability1,
                            scale: 2,
                          ),
                          Text(" ${snapshot.data!.ability1 ?? ''}"),
                        ],
                      ),
                      Padding(
                        padding: new EdgeInsets.all(20),
                      ),
                      Column(
                        children: [
                          Image.network(
                            snapshot.data!.Gambarability2,
                            scale: 2,
                          ),
                          Text(" ${snapshot.data!.ability2 ?? ''}"),
                        ],
                      ),
                    ],
                  ),
                  Text(" ${snapshot.data!.hero ?? ''}",
                      style: TextStyle(fontSize: 15)),
                  Text(
                    "Primary",
                    style: TextStyle(color: Colors.black, fontSize: 13),
                  ),
                  Text(" ${snapshot.data!.primary ?? ''}"),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Wrap(
                      direction: Axis.horizontal,
                      alignment: WrapAlignment.start,
                      children: [
                        Text(
                          "Bio :",
                          style: TextStyle(color: Colors.black, fontSize: 13),
                        ),
                        Text(" ${snapshot.data!.bio ?? ''}"),
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
        future: detailheroes,
      )),
    );
  }
}

class DetailHero {
  int? id;
  String? hero;
  String? primary;
  String? ability1;
  String? ability_cd1;
  String? manacosts_ability1;
  String? bio_ability1;
  String? ability2;
  String? ability_cd2;
  String? manacosts_ability2;
  String? bio_ability2;
  String? bio;
  String Gambarhero;
  String Gambarability1;
  String Gambarability2;

  DetailHero(
      {this.id,
      this.hero,
      this.primary,
      this.ability1,
      this.ability_cd1,
      this.manacosts_ability1,
      this.bio_ability1,
      this.ability2,
      this.ability_cd2,
      this.manacosts_ability2,
      this.bio_ability2,
      this.bio,
      required this.Gambarhero,
      required this.Gambarability1,
      required this.Gambarability2});

  factory DetailHero.fromJson(Map<String, dynamic> json) {
    return DetailHero(
        id: json['id'] as int,
        hero: json['hero'] as String,
        primary: json['primary'] as String,
        ability1: json['ability1'] as String,
        ability_cd1: json['ability_cd1'] as String,
        manacosts_ability1: json['manacosts_ability1'] as String,
        bio_ability1: json['bio_ability1'] as String,
        ability2: json['ability2'] as String,
        manacosts_ability2: json['manacosts_ability2'] as String,
        bio_ability2: json['bio_ability2'] as String,
        bio: json['bio'] as String,
        Gambarhero: json['Gambarhero'] as String,
        Gambarability1: json['Gambarability1'] as String,
        Gambarability2: json['Gambarability2'] as String);
  }
}

Future<DetailHero> fetchdetailheroes(id) async {
  print(id);
  final response =
      await http.get(Uri.parse('http://localhost:3000/dota/${id}/'));
  if (response.statusCode == 200) {
    print(response.body);

    return DetailHero.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load episodes');
  }
}
