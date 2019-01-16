import './Utility/Documents.dart' as Documents;

Documents.UserDataItem item1 = new Documents.UserDataItem(
    category: "Work",
    duration: new Duration(),
    dayKey: new DateTime.now().toString(),
    timeModified: new DateTime.now());

Documents.UserDataItem item2 = new Documents.UserDataItem(
    category: "Sleep",
    duration: new Duration(),
    dayKey: new DateTime.now().toString(),
    timeModified: new DateTime.now());

// Mock data that represents a single day.
// It is a list of category data
List<Documents.UserDataItem> mockSingleDay = [item1, item2];

List<String> categories = [
  "Work",
  "Product",
  "Business",
  "Sleep",
  "Socializing",
  "Higene",
  "House-keeping",
  "Enrichment",
  "Exercise"
];
