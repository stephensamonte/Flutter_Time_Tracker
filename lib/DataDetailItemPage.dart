import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './DataAddItemPage.dart' as WorkoutAddItemPage;
import './Utility/Documents.dart' as Documents;

import './Utility/Variables.dart' as MyVariables;
import './Utility/TimerService.dart' as TimerService;

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

  @override
  void initState() {
    dataItem = widget.dataItem;
  }

  @override
  Widget build(BuildContext context) {
    // Timer Service provider
    var timerService = TimerService.TimerService.of(context);

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
                new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    AnimatedBuilder(
                      animation: timerService, // listen to ChangeNotifier
                      builder: (context, child) {
                        // this part is rebuilt whenever notifyListeners() is called
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                                formatDuration(timerService.currentDuration +
                                    dataItem.duration),
                                style: TextStyle(
                                    fontSize: 60.0, fontFamily: "Open Sans")),

                            RaisedButton(
                              onPressed: !timerService.isRunning
                                  ? timerService.start
                                  : () {
                                      // Stop the timer
                                      timerService.stop();

                                      // saveData
                                      addDurationData(
                                          timerService.currentDuration);

                                      // reset the timer
                                      timerService.reset();
                                    },
                              child: Text(
                                  !timerService.isRunning ? 'Start' : 'Stop'),
                            ),
//                            RaisedButton(
//                              onPressed: timerService.reset,
//                              child: Text('Reset'),
//                            )
                          ],
                        );
                      },
                    ),
                    new Text(dataItem.category),
                    // Display userListItem from Firebase Database
                    new Text(dataItem.duration.toString(),
                        style: new TextStyle(
                            color: (dataItem.duration != "")
                                ? Colors.green
                                : Colors.black)),
                    new Text(dataItem.timestampDay.toString()),
                    new Text(dataItem.timestampModified.toString()),
                  ],
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

  // Save data
  void addDurationData(Duration addDuration) {

    // save new duration
    dataItem.duration = dataItem.duration + addDuration;
  }

  /// Modified from: http://bizz84.github.io/2018/03/18/How-Fast-Is-Flutter.html
  String formatDuration(Duration input) {
    int milliseconds = input.inMilliseconds;

    int hundreds = (milliseconds / 10).truncate();
    int seconds = (hundreds / 100).truncate();
    int minutes = (seconds / 60).truncate();
    int hour = (minutes / 60).truncate();

    String hourStr = (hour % 100).toString().padLeft(2, '0');
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');
//    String hundredsStr = (hundreds % 100).toString().padLeft(2, '0');

    return "$hourStr:$minutesStr:$secondsStr";
  }
}
