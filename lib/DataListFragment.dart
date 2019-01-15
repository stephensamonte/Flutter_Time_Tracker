// This is for dart async used to run google sign in in the background
import 'dart:async';

import 'package:flutter/material.dart';
import './Utility/Documents.dart' as Documents;
import './DataDetailItemPage.dart' as DataDetailItemPage;
import 'package:flutter_calendar/flutter_calendar.dart';

import './Utility/Variables.dart' as Variables;

import './Utility/LocalStorage.dart' as LocalStorage;



// My own created imports
//import './Data/MyAuthentication.dart' as MyAuthentication;

/// Checklist List Fragment which displays a checklist collection
class ListFragment extends StatefulWidget {
  ListFragment({Key key}) : super(key: key);

  // chat screen
  @override
  State createState() => new ListFragmentScreenState();
}

/// State
class ListFragmentScreenState extends State<ListFragment> {
  // editable day data
  List<Documents.UserDataItem> dayData;

  // Selected day
  DateTime selectedDate;

  // Day Key to retrieve data from storage
  String dayKey;

  @override
  void initState() {
    super.initState();

    selectedDate = extractDay(DateTime.now());
    print("Now " + selectedDate.toString());

    // determine key to retrieve data
    dayKey = LocalStorage.getDayKey(selectedDate);

    // get day data
    dayData = LocalStorage.getDayData(dayKey);
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
              return new _dataListListItem(dayData[index]);
//            return ListTile(
//              title: Text('${dayData[index].category}'),
//            );
            },
          )),
        )
      ]),
    );
  }

  // Determines the current day
  DateTime extractDay(DateTime input){
    DateTime day = new DateTime.utc(input.year, input.month, input.day, 12);
    return day;
  }
}

/// This is one contact list item.
class _dataListListItem extends StatelessWidget {
  _dataListListItem(this.item);

  Documents.UserDataItem item;

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
                  .pushNamed(DataDetailItemPage.DataDetailItemPage.routeName);

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
                          new Text(item.timestampDay.toString()),
                          new Text(item.timestampModified.toString()),
                        ],
                      ),
                    ),
                  ],
                ))));
  }
}
