
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './DataAddItemPage.dart' as WorkoutAddItemPage;
import './Utility/Documents.dart' as Documents;

import './Utility/Variables.dart' as MyVariables;
import './Utility/TimerText.dart' as TimerText;

// Page
class DataDetailItemPage extends StatefulWidget {
  DataDetailItemPage({Key key, this.dataItem}) : super(key: key);

  static const routeName = "/DataDetailItemPage";

  // data of the item that was selected
  final Documents.UserDataItem dataItem;

  // chat screen
  @override
  State createState() => new WorkoutDetailPageScreenState();
}

// Page State
class WorkoutDetailPageScreenState extends State<DataDetailItemPage> {

  Documents.UserDataItem dataItem;

  // Stopwatch to get a time duration
  Stopwatch stopwatch = new Stopwatch();

  String stopwatchText;

  @override
  void initState() {

    dataItem = widget.dataItem;

    stopwatchText = stopwatch.isRunning ? "stop" : "start";
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(dataItem.category),
          actions: <Widget>[

            new PopupMenuButton<String>(
                padding: EdgeInsets.zero,
                onSelected: _showMenuSelection,
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
//                const PopupMenuItem<String>(
//                    value: 'Share',
//                    child: const ListTile(
//                        leading: const Icon(Icons.share),
//                        title: const Text('Share')
//                    )
//                ),
//                const PopupMenuDivider(), // ignore: list_element_type_not_assignable, https://github.com/flutter/flutter/issues/5771
                      const PopupMenuItem<String>(
                          value: 'Delete',
                          child: const ListTile(
                              leading: const Icon(Icons.delete),
                              title: const Text('Delete'))),

                      const PopupMenuItem<String>(
                          value: 'Edit',
                          child: const ListTile(
                              leading: const Icon(Icons.edit),
                              title: const Text('Edit'))),
                    ]),
          ],
        ),
        body: //new SettingsFragment.SettingsFragment()
            new Container(
          child: new Center(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Container(height: 200.0,
                    child: new Center(
                      child: new TimerText.TimerText(stopwatch: stopwatch),
                    )),
                new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text(dataItem.category),
                    // Display userListItem from Firebase Database
                    new Text(dataItem.duration.toString(),
                        style: new TextStyle(
                            color: (dataItem.duration != "") ?
                            Colors.green :
                            Colors.black
                        )
                    ),
                    new Text(dataItem.timestampDay.toString()),
                    new Text(dataItem.timestampModified.toString()),
                  ],
                ),
                new RaisedButton(
                    child: Text(stopwatchText),
                    onPressed: () {
                      stopwatchStartStop();
                    } // signs out the userm
                    ),
              ],
            ),
          ),
        ));
  }

  /// App bar action selection.
  void _showMenuSelection(String value) {
    switch (value) {
      case "Delete":
        // delete the document in the database



        // Pop current view
        Navigator.of(context).pop();

        break;
      case "Edit":
        // todo launch add workout item page with data

//      // set item for add item page to open
//        MyVariables.workoutAddItemSnapshot = widget.snapshotDocumentData;
//
//      // navigate to checklistAddItemDetailPage
//        Navigator.of(context).pushNamed(WorkoutAddItemPage
//            .WorkoutAddItemPage.routeName);

        break;
      default:
      // todo notify user that there was an error
    }
//    showInSnackBar('You selected: $value');
  }

  void stopwatchStartStop() {
    setState(() {
      if (stopwatch.isRunning) {
        stopwatch.stop();
      } else {
        stopwatch.start();
      }
    });
  }

}


