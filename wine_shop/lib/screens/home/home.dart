import 'package:flutter/material.dart';
import 'package:wine_shop/models/wine.dart';
import 'package:wine_shop/screens/home/settings_form.dart';
import 'package:wine_shop/services/auth.dart';
import 'package:wine_shop/services/database.dart';
import 'package:provider/provider.dart';
import 'package:wine_shop/screens/home/wine_list.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel(){
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 60.0),
          child: SettingsForm(),
        );
      });
    }

    return StreamProvider<List<Wine>>.value(
      value: DatabaseService().wines,
        child: Scaffold(
        backgroundColor: Colors.red[50],
        appBar: AppBar(
          title: Text('Fine Wine'),
          backgroundColor: Colors.red[900],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
            onPressed: ()async{
              await _auth.signout();
            },
            icon: Icon(Icons.person),
            label: Text('Log out'),
            ),
            FlatButton.icon(
              icon: Icon(Icons.settings),
              label: Text(''),
              onPressed: () => _showSettingsPanel(),
            )
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
            image: AssetImage('assests/WineBg.jpg'),
            fit: BoxFit.cover,
            ),
          ),
          
          child: WineList()
          ),
      ),
    );
  }
}