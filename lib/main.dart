import 'package:flutter/material.dart';

import './HomePage.dart' as HomePage;
import './DayItemDetailPage.dart' as DayItemDetailPage;
import './AddCategoryPage.dart' as AddCategoryPage;
import './DayChartsPage.dart' as DayChartsPage;

import './Utility/Variables.dart' as Variables;
import './Utility/TimerService.dart' as TimerService;


import './CategoriesPage.dart' as CategoriesPage;

//void main() => runApp(MyApp());

void main() {
  final timerService = TimerService.TimerService();
  runApp(
    TimerService.TimerServiceProvider( // provide timer service to all widgets of your app
      service: timerService,
      child: MyApp(),
    ),
  );
}
//-----------------------------------------

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: new HomePage.HomePage(),
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {

//            case '/':
//              return new MyCustomRoute(
//                builder: (_) => new HomePage.HomePage(),
//                settings: settings,
//              );

//            case HomePage.HomePage.routeName:
//              return new MyCustomRoute(
//                builder: (_) =>
//                new HomePage.HomePage(),
//                settings: settings,
//              );

            case DayItemDetailPage.DayItemDetailPage.routeName:
              return new MyCustomRoute(
                builder: (_) =>
                new DayItemDetailPage.DayItemDetailPage(dataItem: Variables.dataItemDetailDocument,),
                settings: settings,
              );

            case AddCategoryPage.AddCategoryPage.routeName:
              return new MyCustomRoute(
                builder: (_) =>
                new AddCategoryPage.AddCategoryPage(currentDate: Variables.dataDateAddItem,),
                settings: settings,
              );
            case CategoriesPage.CategoriesPage.routeName:
              return new MyCustomRoute(
                builder: (_) =>
                new CategoriesPage.CategoriesPage(),
                settings: settings,
              );
            case DayChartsPage.DayChartsPage.routeName:
              return new MyCustomRoute(
                builder: (_) =>
                new DayChartsPage.DayChartsPage(),
                settings: settings,
              );


          }

          assert(false);
        }
        );
  }
}

/// Generates transitions for page routes.
class MyCustomRoute<T> extends MaterialPageRoute<T> {
  MyCustomRoute({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // if it is the first route to open then just appear
    if (settings.name == '/') return child;

    switch (settings.name) {
//      case ('/'):
//        return child;
//          new FadeTransition(
////          opacity: animation,
//          opacity: new CurvedAnimation(
//            parent: animation,
//            curve: Curves.easeIn,
//          ),
//          child: child,
//        );

//      case (StartScreens.EmailPasswordLoginPage.routeName):
//        return new FadeTransition(
////          opacity: animation,
//          opacity: new CurvedAnimation(
//            parent: animation,
//            curve: Curves.easeIn,
//          ),
//          child: child,
//        );


      case (DayItemDetailPage.DayItemDetailPage.routeName):
        return new FadeTransition(
//          opacity: animation,
            opacity:
//          animation,
            new CurvedAnimation(
              parent: animation,
              curve: Curves.easeIn,
            ),
            child: new SlideTransition(
              position: new Tween<Offset>(
                begin: const Offset(0.0, 0.2),
                end: Offset.zero,
              ).animate(//animation),
                  new CurvedAnimation(parent: animation, curve: Curves.easeIn)),
              child: child,
            ));

      case (AddCategoryPage.AddCategoryPage.routeName):
        return new FadeTransition(
//          opacity: animation,
            opacity:
//          animation,
            new CurvedAnimation(
              parent: animation,
              curve: Curves.easeIn,
            ),
            child: new SlideTransition(
              position: new Tween<Offset>(
                begin: const Offset(0.0, 0.2),
                end: Offset.zero,
              ).animate(//animation),
                  new CurvedAnimation(parent: animation, curve: Curves.easeIn)),
              child: child,
            ));

      case (CategoriesPage.CategoriesPage.routeName):
        return new FadeTransition(
//          opacity: animation,
            opacity:
//          animation,
            new CurvedAnimation(
              parent: animation,
              curve: Curves.easeIn,
            ),
            child: new SlideTransition(
              position: new Tween<Offset>(
                begin: const Offset(0.0, 0.2),
                end: Offset.zero,
              ).animate(//animation),
                  new CurvedAnimation(parent: animation, curve: Curves.easeIn)),
              child: child,
            ));

      case (DayChartsPage.DayChartsPage.routeName):
        return new FadeTransition(
//          opacity: animation,
            opacity:
//          animation,
            new CurvedAnimation(
              parent: animation,
              curve: Curves.easeIn,
            ),
            child: new SlideTransition(
              position: new Tween<Offset>(
                begin: const Offset(0.0, 0.2),
                end: Offset.zero,
              ).animate(//animation),
                  new CurvedAnimation(parent: animation, curve: Curves.easeIn)),
              child: child,
            ));

//      case (SettingsPage.SettingsPage.routeName):
//        return new FadeTransition(
////          opacity: animation,
//            opacity:
////          animation,
//
//            new CurvedAnimation(
//              parent: animation,
//              curve: Curves.easeIn,
//            ),
//            child: new SlideTransition(
//              position: new Tween<Offset>(
//                begin: const Offset(0.0, 0.2),
//                end: Offset.zero,
//              ).animate(//animation),
//                  new CurvedAnimation(parent: animation, curve: Curves.easeIn)),
//              child: child,
//            ));
    }

    return child; // new FadeTransition(opacity: animation, child: child);
  }
}


