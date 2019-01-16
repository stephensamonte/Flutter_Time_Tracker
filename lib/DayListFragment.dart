import 'package:flutter/material.dart';
import 'package:flutter_calendar/flutter_calendar.dart';
import './Utility/Documents.dart' as Documents;
import './DayItemDetailPage.dart' as DayItemDetailPage;

import './Utility/Variables.dart' as Variables;
import './Utility/SQLlocalStorage.dart' as SQLlocalStorage;
import './Utility/Utility.dart' as Utility;

import './Utility/SharedPrefsStorage.dart' as SharedPrefsStorage;

/// Checklist List Fragment which displays a checklist collection
class DayListFragment extends StatefulWidget {
  DayListFragment({Key key}) : super(key: key);

  // chat screen
  @override
  State createState() => new DayListFragmentState();
}

/// State
class DayListFragmentState extends State<DayListFragment> {

  // default categories
  List<String> defaultCategories;

  // editable day data
  List<Documents.UserDataItem> dayData;

  // Selected day
  DateTime selectedDate;

  // Day Key to retrieve data from storage
  String dayKey;

  @override
  void initState() {
    super.initState();

    defaultCategories = new List();

    selectedDate = Utility.extractDay(DateTime.now());
    print("Now " + selectedDate.toString());

    // determine key to retrieve data
    dayKey = SQLlocalStorage.getDayKey(selectedDate);

    dayData = new List();

    // get day data
    getDayData();
  }

  getDayData() async {

    // remove old data
    dayData.clear();

    // get day data
    dayData = await SQLlocalStorage.getDayData(dayKey);

    await addDefaultCategories();

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
          child: new Flexible(
//          child: new DatalistList(),
//            new ListView(children: _buildChatsList(),)
              child: ListView.builder(
            itemCount: dayData.length,
            itemBuilder: (context, index) {
              return new _DataListListItem(dayData[index]);
//            return ListTile(
//              title: Text('${dayData[index].category}'),
//            );
            },
          )),
        )
      ]),
    );
  }
}

/// This is one contact list item.
class _DataListListItem extends StatelessWidget {
  _DataListListItem(this.item);

  final Documents.UserDataItem item;

  @override
  Widget build(BuildContext context) {
    return new Card(
        child: new FlatButton(
            onPressed: () {
              // todo navigateto detail page

              // Set the item data to be opened by the list view
              Variables.dataItemDetailDocument = item;

              // navigate to checklistAddItemDetailPage
              Navigator.of(context)
                  .pushNamed(DayItemDetailPage.DayItemDetailPage.routeName);

//                if(document[MyConstants.url2] != ""){
//                  // launch url in browser
//                  Utility.launchURL(document[MyConstants.url2]);
//                } else {
//                  // notify user that there is no video
//
//                  // remove current snack bar
//                  Scaffold.of(context).removeCurrentSnackBar();
//
//                  // display snackbar message
//                  Scaffold.of(context).showSnackBar(new SnackBar(content: new Text("There is no url.")));
//                }
            },
            child: new Container(
                // could just return container
                //modified
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                child: new Row(
                  children: <Widget>[
//                new GestureDetector(
//                  onTap: () {
//                    // set variable to pass to contact page
////                    MyVariables.personInformationDocument = chatDocument;
//
//                    // navigate to contact page
////                    Navigator.of(context).pushNamed("/ContactAvailibilityPage");
//                  },
//                  child: new Container(
//                    margin: const EdgeInsets.only(right: 16.0),
//                    child: (chatDocument[MyConstants.name2] != null)
//                        ? new CircleAvatar(
//                        backgroundImage: new NetworkImage(chatDocument[
//                        MyConstants.name2]) // display userphoto from Firebase Database
////                    new NetworkImage(googleSignIn.currentUser.photoUrl) // get google profile photo
//                    )
//                        : new CircleAvatar(
//                        child: new Text(chatDocument[MyConstants.name2]
//                        [0])), // old avatar
//                  ),
//                ),
                    new Expanded(
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Text(item.category),
                          // Display userListItem from Firebase Database
                          new Text(item.duration.toString(),
                              style: new TextStyle(
                                  color: (item.duration != "")
                                      ? Colors.green
                                      : Colors.black)),
                          new Text(item.dayKey.toString()),
                          new Text(item.timeModified.toString()),
                        ],
                      ),
                    ),
                  ],
                ))));
  }
}
