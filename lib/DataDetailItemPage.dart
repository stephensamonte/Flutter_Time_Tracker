import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './Utility/Documents.dart' as Documents;
import './Utility/TimerService.dart' as TimerService;

import 'package:flutter_duration_picker/flutter_duration_picker.dart';

import './MockData.dart' as MockData;

import './Utility/LocalStorage.dart' as LocalStorage;

// Page
class ItemDetailItemPage extends StatefulWidget {
  ItemDetailItemPage({Key key, this.dataItem, this.DBHelper}) : super(key: key);

  static const routeName = "/DataDetailItemPage";

  // data of the item that was selected
  final Documents.UserDataItem dataItem;
  final LocalStorage.DatabaseHelper DBHelper;

  // chat screen
  @override
  State createState() => new ItemDetailPageState();
}

// Page State
class ItemDetailPageState extends State<ItemDetailItemPage> {
  Documents.UserDataItem dataItem;

  @override
  void initState() {
    super.initState();

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

                                      // save data to database
                                      saveItemToDB();
                                    },
                              child: Text(
                                  !timerService.isRunning ? 'Start' : 'Stop'),
                            ),
                            RaisedButton(
                              child: Text('Add Duration'),
                              onPressed: () async {
                                // Use it as a dialog, passing in an optional initial time
                                // and returning a promise that resolves to the duration
                                // chosen when the dialog is accepted. Null when cancelled.
                                Duration resultingDuration =
                                    await showDurationPicker(
                                  context: context,
                                  initialTime: new Duration(minutes: 30),
                                );

                                // add selected duration
                                addDurationData(resultingDuration);

                                // display update
                                setState(() {});

                                // Notify user of change
                                Scaffold.of(context).showSnackBar(new SnackBar(
                                    content: new Text(
                                        "Chose duration: $resultingDuration")));

                                // save data to database
                                saveItemToDB();
                              },
                            ),
                            RaisedButton(
                              child: Text('Set Duration'),
                              onPressed: () async {
                                // Use it as a dialog, passing in an optional initial time
                                // and returning a promise that resolves to the duration
                                // chosen when the dialog is accepted. Null when cancelled.
                                Duration resultingDuration =
                                    await showDurationPicker(
                                  context: context,
                                  initialTime: new Duration(minutes: 30),
                                );

                                // set selected duration
                                setDurationData(resultingDuration);

                                // display update
                                setState(() {});

                                // Notify user of change
                                Scaffold.of(context).showSnackBar(new SnackBar(
                                    content: new Text(
                                        "Chose duration: $resultingDuration")));

                                // save data to database
                                saveItemToDB();
                              },
                            )
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
                    new Text(dataItem.dayKey.toString()),
                    new Text(dataItem.timeModified.toString()),
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

        MockData.mockSingleDay.remove(widget.dataItem);

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

  void setDurationData(Duration setDuration) {
    if (setDuration != null) {
      // save new duration
      dataItem.duration = setDuration;
    }
  }

  // Save data
  void addDurationData(Duration addDuration) {
    if (addDuration != null) {
      // save new duration
      dataItem.duration = dataItem.duration + addDuration;
    }
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

  // Save data to database
  void saveItemToDB() async {

    int result = await LocalStorage.saveItemToDB(dataItem);

    print("result: " + result.toString());
  }
}
