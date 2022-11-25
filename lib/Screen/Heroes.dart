// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'home.dart';
import 'detail.dart';

class HeroList extends StatefulWidget {
  const HeroList({Key? key}) : super(key: key);

  @override
  _HeroListState createState() => _HeroListState();
}

class _HeroListState extends State<HeroList> {
  late Future<List<Hero>> heroes;
  @override
  void initState() {
    super.initState();
    heroes = fetchHeroes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Heroes'),
        backgroundColor: Colors.blue[900],
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: FutureBuilder(
          builder: (context, AsyncSnapshot<List<Hero>> snapshot) {
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
                        builder: (context) => DetailPage(
                          id: snapshot.data![index].id,
                          hero: snapshot.data![index].hero,
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
                        color: Colors.blue,
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
                              child: Image.network(
                                  snapshot.data![index].Gambarhero,
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
                                snapshot.data![index].hero,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
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
          future: heroes,
        ),
      ),
    );
  }
}

class Hero {
  final int id;
  final String hero;
  final String Gambarhero;
  Hero({
    required this.id,
    required this.hero,
    required this.Gambarhero,
  });

  factory Hero.fromJson(Map<String, dynamic> json) {
    return Hero(
        id: json['id'], hero: json['hero'], Gambarhero: json['Gambarhero']);
  }
}

Future<List<Hero>> fetchHeroes() async {
  final response = await http.get(Uri.parse('http://localhost:3000/dota'));

  if (response.statusCode == 200) {
    var topShowsJson = jsonDecode(response.body) as List;
    return topShowsJson.map((hero) => Hero.fromJson(hero)).toList();
  } else {
    throw Exception('Failed to load shows');
  }
}
