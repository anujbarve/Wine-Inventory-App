import 'package:flutter/material.dart';
import 'package:wine_shop/models/wine.dart';

class WineTile extends StatelessWidget {

  final Wine wine;

  WineTile({this.wine});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0 , 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.red[wine.strength],
            backgroundImage:
            AssetImage('assests/wineic.png'),
          ),
          title: Text(wine.name),
          subtitle: Text('Takes ${wine.wines} wines'),
        ),
      ),
      );
  }
}