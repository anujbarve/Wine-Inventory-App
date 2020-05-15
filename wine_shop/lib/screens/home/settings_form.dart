import 'package:flutter/material.dart';
import 'package:wine_shop/services/database.dart';
import 'package:wine_shop/shared/constants.dart';
import 'package:wine_shop/models/user.dart';
import 'package:provider/provider.dart';
import 'package:wine_shop/shared/loading.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  
  final _formKey = GlobalKey<FormState>();
  final List<String> wines = ['0','1','2','3','4'];

  // form values
  String _currentName;
  String _currentWine;
  int _currentStrength;
  
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context , snapshot){
        if(snapshot.hasData){
          UserData userData = snapshot.data;

            return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text('Update your wine settings.',
                style: TextStyle(fontSize:18.0),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  initialValue: userData.name,
                  decoration: textInputDecoration,
                  validator: (val) => val.isEmpty ? 'Please Enter Your Name' : null,
                  onChanged: (val) => setState(() => _currentName = val),
                ),
                  SizedBox(height: 20.0),
                  // dropdown
                  DropdownButtonFormField(
                  decoration: textInputDecoration,
                    value: _currentWine ?? userData.wine,
                    items: wines.map((wine){
                      return DropdownMenuItem(
                        value: wine,
                        child: Text('$wine wines'),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => _currentWine = val),
                    ),
                    //slider
                    Slider(
                      value: (_currentStrength ?? userData.strength).toDouble(),
                      activeColor: Colors.red[_currentStrength ?? userData.strength],
                      inactiveColor: Colors.red[_currentStrength ?? userData.strength],
                      min: 100.0,
                      max: 900.0,
                      divisions: 8,
                      onChanged: (val) => setState(() => _currentStrength = val.round()),
                    ),
                  RaisedButton(
                    color: Colors.redAccent,
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.white ),
                      ),
                    onPressed: ()async{
                      // print(_currentName);
                      // print(_currentWine);
                      // print(_currentStrength);
                      if (_formKey.currentState.validate()) {
                        await DatabaseService(uid: user.uid).updateUserData(
                          _currentWine ?? userData.wine,
                          _currentName ?? userData.name,
                          _currentStrength ?? userData.strength
                        );
                        Navigator.pop(context); 
                      }
                    }
                    )
                
              ],
            )
            );
        }else{
          return Loading(); 
        }
           }
    );
  }
}