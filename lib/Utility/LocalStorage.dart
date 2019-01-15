// For Date Formatter to determine Date Key for storage
import 'package:intl/intl.dart';
import './Documents.dart' as Documents;

import '../MockData.dart' as MockData;

// Determines key to store data
String getDayKey(DateTime selectedDate) {

  // Format example: 2019-01-15
  return new DateFormat(('yyyy-MM-dd')).format(selectedDate);
}

// Retrieve day data to display to user
List<Documents.UserDataItem> getDayData(String storageKey){

  return MockData.mockSingleDay;

}