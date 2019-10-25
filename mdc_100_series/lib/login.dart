import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(height: 80.0),
            Column(
              children: <Widget>[
                Image.asset('assets/diamond.png'),
                SizedBox(height: 16.0),
                Text('SHRINE'),
              ],
            ),
            SizedBox(height: 120.0),
            // TODO: Wrap Username with AccentColorOverride (103)
            // TODO: Remove filled: true values (103)
            // TODO: Wrap Password with AccentColorOverride (103)
            TextField(
              decoration: InputDecoration(
                filled: true,
                labelText: "Username",
              ),
              controller: _usernameController,
            ),
            SizedBox(height: 20.0),
            TextField(
              decoration: InputDecoration(
                filled: true,
                labelText: "Password",
              ),
              controller: _passwordController,
              obscureText: true,
            ),
            ButtonBar(
              children: <Widget>[
                FlatButton(
                  onPressed: clearText,
                  textColor: Colors.black,
                  child: Text("CLEAR"),
                ),
                RaisedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  textColor: Colors.black,
                  child: Text("SUBMIT"),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void clearText() {
    _usernameController.clear();
    _passwordController.clear();
  }
}

// TODO: Add AccentColorOverride (103)
