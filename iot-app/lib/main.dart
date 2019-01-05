import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IOT',
      theme: ThemeData(primaryColor: Colors.white
          // primarySwatch: Colors.white,
          ),
      home: MyHomePage(title: 'IOT'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double k = 1;
  int i;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
        leading: Icon(Icons.settings),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                load_sub(255);
              },
              child: Container(
                  height: 100,
                  width: 100,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      boxShadow: [
                        new BoxShadow(
                          color: Colors.black,
                          blurRadius: 3.0,
                        ),
                      ],
                      //boxShadow:
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.blueAccent),
                  child: Center(
                    child: Text(
                      'On',
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
            ),
            GestureDetector(
              onTap: () {
                load_sub(0);
              },
              child: Container(
                  height: 100,
                  width: 100,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      boxShadow: [
                        new BoxShadow(
                          color: Colors.black,
                          blurRadius: 3.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.redAccent),
                  child: Center(
                    child: Text(
                      'Off',
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
            ),
            new Container(
              margin: EdgeInsets.all(10),
              child: new Slider(
                onChangeEnd: (double value){
                     setState(() {
                    k = value;
                    double z = value * 100*2.55;
                    i = z.toInt();
                    load_sub(i);
                    z=z/2.55;
                    i=z.toInt();
                  });
                },
                activeColor: Colors.blue,
                value: k,
                onChanged: (double value) {
                  print(value);
                  setState(() {
                    k = value;
                    double z = value * 100;
                    i = z.toInt();
                  });
                },
              ),
            ),
            Text(
              'Intensity $i%',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  void load_sub(int state) async {
    String s = state.toString();
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: Text('turning led $state')));
    var result = await http.post("https://shielded-sierra-72155.herokuapp.com",
        body: {"state": s});
    var res = json.decode(result.body);
    String r = res.toString();
    // res.forEach((k) {
    setState(() {
      if (r == "success") {
        _scaffoldKey.currentState.showSnackBar(
            new SnackBar(content: Text('led turned $state successfully')));
        print('led turned $state successfully');
      } else {
        _scaffoldKey.currentState.showSnackBar(
            new SnackBar(content: Text('led turned $state successfully')));
        print('error occured');
      }
    });
    // });
  }
}
