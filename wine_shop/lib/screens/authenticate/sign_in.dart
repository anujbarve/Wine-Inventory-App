import 'package:flutter/material.dart';
import 'package:wine_shop/services/auth.dart';
import 'package:wine_shop/shared/constants.dart';
import 'package:wine_shop/shared/loading.dart';


class SignIn extends StatefulWidget {

  final Function toggleView;

  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field state

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() :Scaffold(
      backgroundColor: Colors.red[100],
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        elevation: 0.0,
        title: Text('Sign In To Fine Wine'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person,color: Colors.white),
            label: Text('Register',style: TextStyle(color: Colors.white),),
            onPressed: (){
              widget.toggleView();
            },
            )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
        child: Form(
          key: _formKey,
        child: Column(
          children: <Widget>[
            SizedBox(height: 20.0),
            TextFormField(
              decoration: textInputDecoration.copyWith(hintText:'Email'),
              autocorrect: false,
              validator: (val) => val.isEmpty ? 'Enter an Email':null,
              onChanged: (val){
                setState(() => email = val);
              },
            ),
            SizedBox(height: 20.0),
            TextFormField(
              decoration: textInputDecoration.copyWith(hintText:'Password'),
              obscureText: true,
              autocorrect: false,
              validator: (val) => val.length < 6 ? 'Enter a Password 6+ Characters':null,
              onChanged: (val){
                setState(() => password = val);
              },
            ),
            SizedBox(height: 20.0),
            RaisedButton(
              color: Colors.red,
              child: Text(
                'Sign In',
                style: TextStyle(color: Colors.white),
                ),
              onPressed: () async{
                 if (_formKey.currentState.validate()) {
                   setState(() => loading = true);
                  dynamic result = await _auth.signInWithEmailandPassword(email, password);
                  if (result == null) {
                    setState(() {
                    error = 'Could not sign in with those credentials';
                    loading = false;
                  });
                  }
                 }
              },
              ),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red,fontSize: 16.0),
              ),
          ],
        ),
        ),
      ),
    );
  }
}

// child: RaisedButton(onPressed: () async{
        //   dynamic result = await _auth.signInAnon();
        //   if (result == null) {
        //     print('Error Signing In');
        //   } else {
        //     print('Signed in');
        //     print(result.uid);
        //   }
        // },
        // child: Text('Sign In anon'),),