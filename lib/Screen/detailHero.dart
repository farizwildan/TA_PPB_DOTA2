import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailPage extends StatefulWidget {
  final int item;
  final String title;
  const DetailPage({Key? key, required this.item, required this.title})
      : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late Future<List<Episode>> episodes;

  @override
  void initState() {
    super.initState();
    episodes = fetchEpisodes(widget.item);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text('Heroes'), backgroundColor: Colors.lightBlue[900]),
      body: Center(
          child: FutureBuilder(
        builder: (context, AsyncSnapshot<List<Episode>> snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: CircleAvatar(
                        child: Text('${snapshot.data![index].episodeId}')),
                    title: Text(snapshot.data![index].title),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
              ),
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong :('));
          }
          return const CircularProgressIndicator();
        },
        future: episodes,
      )),
    );
  }
}

class Episode {
  final int episodeId;
  final String title;

  Episode({required this.episodeId, required this.title});

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(episodeId: json['episode_id'], title: json['title']);
  }
}

Future<List<Episode>> fetchEpisodes(id) async {
  final response = await http
      .get(Uri.parse('https://api.jikan.moe/v3/anime/$id/episodes/1'));

  if (response.statusCode == 200) {
    var episodesJson = jsonDecode(response.body)['episodes'] as List;
    return episodesJson.map((episode) => Episode.fromJson(episode)).toList();
  } else {
    throw Exception('Failed to load episodes');
  }
}


 // ignore_for_file: file_names

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';


// class DetailHeroes extends StatefulWidget {
//   final Stack ability1;
//   final String ability2;
//   const DetailHeroes({Key? key, required this.ability1, required this.ability2})
//       : super(key: key);
 
//   @override
//   _DetailHeroesState createState() => _DetailHeroesState();
// }
 
// class _DetailHeroesState extends State<DetailHeroes> {
//   late Future<List<Hero>> heroes;
 
//   @override
//   void initState() {
//     super.initState();
//     heroes = fetchheroes(widget.ability1);
//   }

//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }
 
// }

// class DetailHero {
//   final int? id;
//   final String? hero;
//   final String? primary;
//   final String? ability1;
//   final String? ability_cd1;
//   final String? manacosts_ability1;
//   final String? bio_ability1;
//   final String? ability2;
//   final String? ability_cd2;
//   final String? manacosts_ability2;
//   final String? bio_ability2;
//   final String? bio;
  

// DetailHero({
//   this.id,
//   this.hero,
//   this.primary,
//   this.ability1,
//   this.ability_cd1,
//   this.manacosts_ability1,
//   this.bio_ability1,
//   this.ability2,
//   this.ability_cd2,
//   this.manacosts_ability2,
//   this.bio_ability2,
//   this.bio

//   });
// }
// Future<List<Hero>> fetchheroes(id) async {
//   final response = await http
//       .get(Uri.parse('https://my-json-server.typicode.com/saydss/Apidota2/db'));
 
//   if (response.statusCode == 200) {
//     Iterable it = jsonDecode(response.body)['dotaitem'] as List;
//     return it.map((primary) => Hero.fromJson(primary)).toList();
//   } else {
//     throw Exception('Failed to load items');
//   }
// }