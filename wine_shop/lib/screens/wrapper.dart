import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wine_shop/models/user.dart';
import 'package:wine_shop/screens/authenticate/authenticate.dart';
import 'package:wine_shop/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
      final user = Provider.of<User>(context);
      print(user);

      // return either home or autheticate widget
      if (user == null) {
        return Authenticate();
      } else {
        return Home();
      }
  }
}