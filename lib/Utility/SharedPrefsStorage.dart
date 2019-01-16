

// Shared Preferences to save user preferred categories
import 'package:shared_preferences/shared_preferences.dart';

import '../MockData.dart' as MockData;

// Keys used in shared preferences
final String categoriesKey = 'categories';

SharedPreferences prefs;


// get categories
Future<List<String>> getCategories() async {

  // get shared preference instance
  if(prefs == null){
    prefs = await SharedPreferences.getInstance();
  }

  // get categories
  List<String> categories = (prefs.getStringList(categoriesKey) ?? new List());

  return categories;
}

// remove a default category
Future<bool> addCategory(String value) async {

  // get shared preference instance
  if(prefs == null){
    prefs = await SharedPreferences.getInstance();
  }

  // get categories
  List<String> categories = (prefs.getStringList(categoriesKey) ?? new List());

  // add new item to category
  categories.add(value);

  return await prefs.setStringList(categoriesKey, categories);
}

// remove a default category
Future<bool> removeCategory(String value) async {

  // get shared preference instance
  if(prefs == null){
    prefs = await SharedPreferences.getInstance();
  }

  // get categories
  List<String> categories = (prefs.getStringList(categoriesKey) ?? new List());

  // add new item to category
  categories.remove(value);

  return await prefs.setStringList(categoriesKey, categories);
}

// add starter categories to shared preferences
Future addStarterCategories() async {

  // get shared preference instance
  if(prefs == null){
    prefs = await SharedPreferences.getInstance();
  }

  // get categories
  List<String> categories = (prefs.getStringList(categoriesKey) ?? new List());

  // add categories that are not there yet
  for (String item in MockData.categories){
    if (!categories.contains(item)){
      addCategory(item);
    }
  }
}