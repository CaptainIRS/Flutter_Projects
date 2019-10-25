import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: HomePage(title: 'Home Page'),
    );
  }
}

class HomePage extends StatefulWidget {

  final String title;

  HomePage({Key key, this.title}) : super(key : key);

  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          CloseButton(),
          IconButton(
            icon: Icon(Icons.title),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Hi"),
                    actions: <Widget>[Text("OK")],
                  );
                },
              );
            },
          )
        ],
        title: Text(widget.title),
      ),
      body: Center(
        child: Center(
          child: Text("Hello World!"),
        )
      ),
    );
  }

}
