import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wine_shop/models/wine.dart';
import 'package:wine_shop/screens/home/wine_tile.dart';

class WineList extends StatefulWidget {
  @override
  _WineListState createState() => _WineListState();
}

class _WineListState extends State<WineList> {
  @override
  Widget build(BuildContext context) {

    final wines = Provider.of<List<Wine>>(context) ?? [];
    
    return ListView.builder(
      itemCount: wines.length,
      itemBuilder: (context, index) {
         return WineTile(wine: wines[index]);
      },
    );
  }
}
