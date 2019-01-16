import 'package:flutter/material.dart';
import 'package:flutter_calendar/flutter_calendar.dart';
import './Utility/Documents.dart' as Documents;
import 'package:charts_flutter/flutter.dart' as charts;

import './PieChart.dart' as PieChart;

import './Utility/Variables.dart' as Variables;
import './Utility/SQLlocalStorage.dart' as SQLlocalStorage;
import './Utility/Utility.dart' as Utility;

import './Utility/SharedPrefsStorage.dart' as SharedPrefsStorage;

/// Checklist List Fragment which displays a checklist collection
class DayChartsFragment extends StatefulWidget {
  DayChartsFragment({Key key}) : super(key: key);

  // chat screen
  @override
  State createState() => new DayChartsFragmentState();
}

/// State
class DayChartsFragmentState extends State<DayChartsFragment> {

  // default categories
  List<String> defaultCategories;

  // editable day data
  List<Documents.UserDataItem> dayData;

  // Selected day
  DateTime selectedDate;

  // Day Key to retrieve data from storage
  String dayKey;

  bool noSavedData;

  List<charts.Series> chartData;

  @override
  void initState() {
    super.initState();

    defaultCategories = new List();

    chartData = new List<charts.Series>();

    selectedDate = Utility.extractDay(DateTime.now());
    print("Now " + selectedDate.toString());

    // determine key to retrieve data
    dayKey = SQLlocalStorage.getDayKey(selectedDate);

    dayData = new List();

    noSavedData = true;

    // get day data
    getDayData();
  }

  getDayData() async {

    // remove old data
    dayData.clear();

    // get day data
    dayData = await SQLlocalStorage.getDayData(dayKey);

    noSavedData = dayData.length == 0;

    await addDefaultCategories();

    chartData = getSeriesListDayData();

    // update view with data
    setState(() {

    });
  }

  addDefaultCategories() async {

//    if (defaultCategories == null){
    defaultCategories = await SharedPrefsStorage.getCategories();
//    }
    List<String> usedCategories = new List();

    // Create a list of categories already in database
    for(Documents.UserDataItem item in dayData){
      usedCategories.add(item.category);
    }

    for(String value in defaultCategories){
      if ( !usedCategories.contains(value)){
        // add item that has that category
        Documents.UserDataItem item = new Documents.UserDataItem();

        item.dayKey = dayKey;
        item.category = value;
        item.duration = new Duration();
        item.timeModified = new DateTime.now();

        // add item to dayData and display
        setState(() {
          dayData.add(item);
        });
      }
    }

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Column(children: <Widget>[
        new Container(
          child: new Calendar(
            showTodayAction: true,
//          showChevronsToChangeRange: false,
            onSelectedRangeChange: (range) =>
                print("Range is ${range.item1}, ${range.item2}"),
            onDateSelected: (clickedDate) {
              // Update selected date
              selectedDate = clickedDate;

              dayKey = SQLlocalStorage.getDayKey(selectedDate);

              // update data in view
              getDayData();

              print(selectedDate.toString());
            },
            isExpandable: false,
          ),
        ),
        new Container(
          child:
          new Expanded(
              child: noSavedData ?
              new Container(
                child: null,
              ):
              new PieChart.DonutAutoLabelChart(chartData, animate: true,)
//              child: new PieChart.DonutAutoLabelChart.withSampleData()
          ),
        )
      ]),
    );
  }

  // converts dayData to a series list for chart
  List<charts.Series> getSeriesListDayData(){

    chartData.clear();

    return [
      new charts.Series<Documents.UserDataItem, dynamic>(
        id: 'Sales',
        domainFn: (Documents.UserDataItem item, _) => item.category,
        measureFn: (Documents.UserDataItem item, _) => item.duration.inMilliseconds ?? 0,
        data: dayData,
        // Set a label accessor to control the text of the arc label.
        labelAccessorFn: (Documents.UserDataItem row, _) => '${row.category}: ${row.duration}',
      )
    ];
  }
}
