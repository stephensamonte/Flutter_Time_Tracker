import './Utility/Documents.dart' as Documents;

Documents.UserDataItem item1 = new Documents.UserDataItem(
    category: "Work",
    duration: new Duration(hours: 1, minutes: 23),
    timestampDay: new DateTime.now(),
    timestampModified: new DateTime.now()
);


Documents.UserDataItem item2 = new Documents.UserDataItem(
    category: "Sleep",
    duration: new Duration(hours: 8),
    timestampDay: new DateTime.now(),
    timestampModified: new DateTime.now()
);

// Mock data that represents a single day.
// It is a list of category data
List<Documents.UserDataItem> mockSingleDay = [item1, item2];