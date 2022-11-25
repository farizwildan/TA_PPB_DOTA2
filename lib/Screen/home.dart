import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ta_PPB/Screen/Heroes.dart';
import 'package:ta_PPB/Screen/detail.dart';
import 'package:ta_PPB/Screen/Items.dart';
import 'package:ta_PPB/Screen/detailItem.dart';
import 'package:ta_PPB/Screen/profile.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Show>> shows;

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Person',
      style: optionStyle,
    ),
  ];
  @override
  void initState() {
    super.initState();
    //shows = fetchShows();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DOTA 2 INFORMATION'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.grey[800],
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: GridView(
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => new HeroList())),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'Hero/logohero.png',
                        scale: 2.5,
                      ),
                      Padding(
                        padding: new EdgeInsets.all(10),
                      ),
                      Text(
                        "Heroes",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => new ItemList())),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'Item/Logoitem.jpg',
                        scale: 3.5,
                      ),
                      Padding(
                        padding: new EdgeInsets.all(10),
                      ),
                      Text(
                        "Items",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      )
                    ],
                  ),
                ),
              ),
              // Container (decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.black,),
              // child: Column(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [

              //   Image.asset('Item/Logoitem.jpg',scale: 3.5,),
              //   Padding(padding: new EdgeInsets.all(10),),
              //   Text("Items",style: TextStyle(color: Colors.white,fontSize: 30),)
              // ],
              // ),
              // ),
            ],
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 20),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.indigo,
        onTap: (int index) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfilePage(),
            ),
          );
        },
      ),
    );
  }
}

class Show {
  final int malId;
  final String title;
  final String imageUrl;
  final double score;

  Show({
    required this.malId,
    required this.title,
    required this.imageUrl,
    required this.score,
  });

  factory Show.fromJson(Map<String, dynamic> json) {
    return Show(
      malId: json['mal_id'],
      title: json['title'],
      imageUrl: json['image_url'],
      score: json['score'],
    );
  }
}
 
// Future<List<Show>> fetchShows() async {
//   final response =
//       await http.get(Uri.parse('https://api.jikan.moe/v3/top/anime/1'));
 
//   if (response.statusCode == 200) {
//     var topShowsJson = jsonDecode(response.body)['top'] as List;
//     return topShowsJson.map((show) => Show.fromJson(show)).toList();
//   } else {
//     throw Exception('Failed to load shows');
//   }
//}
