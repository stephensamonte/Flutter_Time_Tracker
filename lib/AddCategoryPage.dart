
import 'package:flutter/material.dart';

import './DataDetailItemPage.dart' as WorkOutDetailItemPage;

import './Utility/Documents.dart' as Documents;

import './Utility/Variables.dart' as MyVariables;
import './MockData.dart' as MockData;

import './Utility/SharedPrefsStorage.dart' as SharedPrefsStorage;

/// Enum behavior for the bottom navigation bar.
enum AppBarBehavior {normal, pinned, floating, snapping}

/// Detail Page which displays information
class AddCategoryPage extends StatefulWidget {
//  static const String routeName = '/contacts';
// here is a state object now defined in MessengerDetailPage
  AddCategoryPage({Key key, this.currentDate}) : super(key: key);

  final currentDate;

  static const String routeName = '/AddCategoryPage';

  @override
  AddCategoryPageState createState() => new AddCategoryPageState();
}

/// Detail page state.
class AddCategoryPageState extends State<AddCategoryPage> {

// input
  final TextEditingController _textController1 = new TextEditingController();
  final TextEditingController _textController2 = new TextEditingController();
  final TextEditingController _textController3 = new TextEditingController();
  final TextEditingController _textController4 = new TextEditingController();

  String documentId;

  final double _appBarHeight = 190.0;
  AppBarBehavior _appBarBehavior = AppBarBehavior.pinned;

  @override
  void initState() {

      // set initial values of text controllers
//      _textController1.text = widget.dataItem.category;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
//      key: _scaffoldKey,
      body: new CustomScrollView(
        slivers: <Widget>[
          new SliverAppBar(
            expandedHeight: _appBarHeight,
            pinned: _appBarBehavior == AppBarBehavior.pinned,
            floating: _appBarBehavior == AppBarBehavior.floating ||
                _appBarBehavior == AppBarBehavior.snapping,
            snap: _appBarBehavior == AppBarBehavior.snapping,
            actions: <Widget>[
              new IconButton(
                icon: const Icon(Icons.help),
                tooltip: 'Find help',
                onPressed: () {
                  // todo launch help

//                    _scaffoldKey.currentState.showSnackBar(const SnackBar(
//                        content: const Text('This is actually just a demo. Editing isn\'t supported.')
//                    ));
                },
              ),
            ],
            flexibleSpace: new FlexibleSpaceBar(
              title: new Text(
                "Add Category Item",
                overflow: TextOverflow.ellipsis,
              ),

//                ],
//              ),
              background: new Stack(
                fit: StackFit.expand,
                children: <Widget>[
//                  new Image.network(
//                    widget.studentInfoData[MyConstants.chatPhotoUrl2],
////                    width: 250.0,
//                    fit: BoxFit.cover,
//                    height: _appBarHeight,
//                  ),

                  // This gradient ensures that the toolbar icons are distinct
                  // against the background image.
                  const DecoratedBox(
                    decoration: const BoxDecoration(
                      gradient: const LinearGradient(
                        begin: const Alignment(0.0, -1.0),
                        end: const Alignment(0.0, -0.4),
                        colors: const <Color>[
                          const Color(0x60000000),
                          const Color(0x00000000)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          new SliverList(
            delegate: new SliverChildListDelegate(<Widget>[
              new _ListItemCategory(
                icon: Icons.person,
                children: <Widget>[
                  new _itemTextField(
                    title: "Category",
                    hint: "Enter Category.",
                    textfieldController: _textController1,
                  ),
//                  new _itemTextField(
//                    title: "category",
//                    hint: "Enter category.",
//                    textfieldController: _textController2,
//                  ),
//                  new _itemTextField(
//                    title: "details",
//                    hint: "Enter details.",
//                    textfieldController: _textController3,
//                  ),
//                  new _itemTextField(
//                    title: "url",
//                    hint: "Enter url.",
//                    textfieldController: _textController4,
//                  ),
                ],
              ),
            ]),
          ),
        ],
      ),
      floatingActionButton: new FloatingActionButton(
        tooltip: 'Save document', // used by assistive technologies
        child: new Icon(Icons.save),
        onPressed: () {


//          // create item
//          Documents.UserDataItem newItem = new Documents.UserDataItem(
//            category: _textController1.text,
//            duration: new Duration(),
//            dayKey: widget.currentDate,
//            timeModified: new DateTime.now()
//          );
//
//          // todo save data to list
//          MockData.mockSingleDay.add(newItem);

        // add category to default categories
          SharedPrefsStorage.addCategory(_textController1.text);

          // Pop current view
          Navigator.of(context).pop();
        },
      ),
    );
  }
}

// TODO this is a repeat and is found at ContactAvailibilityPage
///Displays the icon the of the corresponding activity category.
class _ListItemCategory extends StatelessWidget {
  const _ListItemCategory({Key key, this.icon, this.children}) : super(key: key);

  final IconData icon;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return new Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        decoration: new BoxDecoration(
            border: new Border(
                bottom: new BorderSide(color: themeData.dividerColor))),
        child: new DefaultTextStyle(
            style: Theme.of(context).textTheme.subhead,
            child: new Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Container(
                      padding: const EdgeInsets.symmetric(vertical: 24.0),
                      width: 72.0,
                      child: new Icon(icon, color: themeData.primaryColor)),
                  new Expanded(child: new Column(children: children))
                ])));
  }
}

// input field widget
class _itemTextField extends StatelessWidget {
  const _itemTextField(
      {Key key, this.title, this.hint, this.textfieldController})
      : super(key: key);

  final String title;
  final String hint;
  final TextEditingController textfieldController;

//  @override
//  _contactFieldPageState createState() => new _contactFieldPageState();
//}
//
///// field state
//class _contactFieldPageState extends State<_contactField> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return new Container(
      margin: const EdgeInsets.only(right: 10.0),
      child: new TextFormField(
        decoration: InputDecoration(
//                      icon: const Icon(Icons.person),
//                    contentPadding: const EdgeInsets.only(right: 40.0, top: 20.0),
          hintText: hint,
          labelText: title,
        ),
        controller: textfieldController,
      ),
    );
  }
}
