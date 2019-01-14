import 'package:flutter/material.dart';
import './DataListFragment.dart' as WorkoutListFragment;

import './MockData.dart' as MockData;

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  static const String routeName = "/HomePage";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  String title;


  @override
  void initState() {
    title = "Time Tracker";
  }

  void _incrementCounter() {
    setState(() {


      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(title),
      ),
      body: new WorkoutListFragment.ListFragment(
        dayData: MockData.mockSingleDay,
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}