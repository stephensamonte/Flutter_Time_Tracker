

/// User Data Item. This is one item
class UserDataItem {
  // fields
  String category;
  Duration duration;
  DateTime timestampDay;
  DateTime timestampModified;

  // constructor if manually adding
  UserDataItem({
    this.category,
    this.duration,
    this.timestampDay,
    this.timestampModified,
  });

  // constructor to map new item from json
//  UserPersonItem.fromDocumentSnapshot(DocumentSnapshot snapshot) {
//    // if no value or field does not exist then set field to ""
//    this.displayName = snapshot['displayName'] ?? null;
//    this.email = snapshot['email'] ?? null;
//    this.photoUrl = snapshot['photoUrl'] ?? null;
//    this.timestampCreated = snapshot['timestampCreated'] ?? null;
//    this.timestampModified = snapshot['timestampModified'] ?? null;
//    this.uid = snapshot['uid'] ?? null;
//  }

  // constructor to map new item from userCredential class
//  UserPersonItem.fromUserCredentials(
//      MyAuthentication.UserCredentials userCredential) {
//    // if no value or field does not exist then set field to ""
//    this.displayName = userCredential.displayName ?? null;
//    this.email = userCredential.email ?? null;
//    this.photoUrl = userCredential.photoURL ?? null;
//    this.timestampCreated = null;
//    this.timestampModified = null;
//    this.uid = userCredential.uid ?? null;
//  }

  // constructor to map new item from friendrequest class
//  UserPersonItem.fromFriendRequestItem(FriendRequestItem item) {
//    // if no value or field does not exist then set field to ""
//    this.displayName = item.displayName1 ?? null;
//    this.email = item.email1 ?? null;
//    this.photoUrl = item.photoUrl1 ?? null;
//    this.timestampCreated = null;
//    this.timestampModified = null;
//    this.uid = item.uid1 ?? null;
//  }

//  // search via name, id, school, grade, program,
//  // determines if string is a partial match to the data
//  bool partialMatch(String objString) {
//    if (this.name.contains(objString) || identical(this.name, objString)) {
//      // If name contains a substring of objString or is itentical to objString
//      return true;
//    } else if (this.details.contains(objString) ||
//        identical(this.details, objString)) {
//      // If name contains a substring of objString or is itentical to objString
//      return true;
//    } else {
//      // not a match
//      return false;
//    }
//  }

  Map<String, dynamic> toMapString() {
    return {
      'category': this.category,
      'duration': this.duration,
      'timestampDay': this.timestampDay,
      'timestampModified': this.timestampModified,
    };
  }
}