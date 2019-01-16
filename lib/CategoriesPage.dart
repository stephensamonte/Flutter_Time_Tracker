import 'package:flutter/material.dart';
import './AddCategoryPage.dart' as AddCategoryPage;
import './Utility/Variables.dart' as Variables;
import './Utility/SQLlocalStorage.dart' as SQLlocalStorage;

import './Utility/SharedPrefsStorage.dart' as SharedPrefsStorage;



List<String> defaultCategories;

class CategoriesPage extends StatefulWidget {
  CategoriesPage({Key key}) : super(key: key);

  static const String routeName = "/CategoriesPage";

  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  String title;



  @override
  void initState() {
    title = "Default Categories";

    defaultCategories = new List();

    getDisplayCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          new PopupMenuButton<String>(
              padding: EdgeInsets.zero,
              onSelected: showMenuSelection,
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                        value: 'ResetDB',
                        child: const ListTile(
                            leading: const Icon(Icons.warning),
                            title: const Text('Reset Database'))),
                    const PopupMenuItem<String>(
                        value: 'ResetCategories',
                        child: const ListTile(
                            leading: const Icon(Icons.refresh),
                            title: const Text('Reset Categories')))
                    //              new IconButton(
//                icon: new Icon(Icons.calendar_today),
//                tooltip: 'Calendar',
//                onPressed: () {
//                  Navigator.of(context).pushNamed(CalMainNavigationDrawer
//                      .CalMainNavigationDrawer.routeName);
//                }, //
//              ),
//                    const PopupMenuItem<String>(
//                        value: 'Settings',
//                        child: const ListTile(
//                            leading: const Icon(Icons.settings),
//                            title: const Text('Settings'))),
//                const PopupMenuItem<String>(
//                    value: 'Feedback',
//                    child: const ListTile(
//                        leading: const Icon(Icons.feedback),
//                        title: const Text('Feedback')))
                  ]),
        ],
      ),
      body:
//          child: new DatalistList(),
//            new ListView(children: _buildChatsList(),)
          ListView.builder(
        itemCount: defaultCategories.length,
        itemBuilder: (context, index) {
          return new _CategoryListItem(defaultCategories[index]);

        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // pass date as parameter
          Variables.dataDateAddItem = DateTime.now();

          // Open add new category
          Navigator.of(context)
              .pushNamed(AddCategoryPage.AddCategoryPage.routeName);
        },
        tooltip: 'Add Category',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  /// App bar action selection.
  showMenuSelection(String value) {
    switch (value) {
      case "ResetDB":
        // reset the database
        SQLlocalStorage.resetDatabase();
        break;

      case "ResetCategories":
        // add mock data categories to shared preferences

      SharedPrefsStorage.addStarterCategories();

//        Navigator.of(context).pushNamed("/SettingsPage");
        break;
      case "Settings":
//        Navigator.of(context).pushNamed("/SettingsPage");
        break;
      case "Feedback":
        // open feedback url
//        MyUtility.launchURL("https://goo.gl/forms/MLEthJSxgQGgiYQJ2");
        break;
      default:
      // todo notify user that there was an error
    }
//    showInSnackBar('You selected: $value');
  }

  Future getDisplayCategories() async {

    defaultCategories = await SharedPrefsStorage.getCategories();

    setState(() {

    });
  }
}

/// This is one contact list item.
class _CategoryListItem extends StatelessWidget {
  _CategoryListItem(this.item);

  final String item;



  @override
  Widget build(BuildContext context) {
    return new Card(
        child: new FlatButton(
            onPressed: () {
              // todo allow to edit item
            },
            child: new Container(
                // could just return container
                //modified
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                child: new Row(
                  children: <Widget>[
                    new Expanded(
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[

                          new Text(item),
                          new IconButton(
                              icon: new Icon(Icons.delete),
                              onPressed: removeCategoryItem
                          )

                        ],
                      ),
                    ),
                  ],
                ))));
  }

  void removeCategoryItem() {
    SharedPrefsStorage.removeCategory(item);
  }
}
