import 'package:flutter/material.dart';
import './DataListFragment.dart' as WorkoutListFragment;
import './DataAddItemPage.dart' as DataAddItemPage;
import './Utility/Variables.dart' as Variables;

import './MockData.dart' as MockData;

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  static const String routeName = "/HomePage";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String title;

  @override
  void initState() {
    title = "Time Tracker";
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
        onPressed: (){

          // pass date as parameter
          Variables.dataDateAddItem = DateTime.now();

          // Open add new category
          Navigator.of(context).pushNamed(DataAddItemPage.DataAddItemPage.routeName);

        },
        tooltip: 'Add Category',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
