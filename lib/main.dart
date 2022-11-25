import 'package:flutter/material.dart';
import 'package:ta_PPB/Screen/detailItem.dart';
import 'package:ta_PPB/screen/home.dart';
import 'package:ta_PPB/Screen/detail.dart';

void main() async {
  runApp(const DotaInfo());
}

class DotaInfo extends StatelessWidget {
  const DotaInfo({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dota2 Information',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/detail': (context) => const DetailPage(id: 1, hero: ''),
        '/detailItem': (context) => const DetailItem(id: 1, item: ''),
      },
    );
  }
}
