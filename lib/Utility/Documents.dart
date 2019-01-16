

/// User Data Item. This is one item
class UserDataItem {
  // fields
  int id;
  String dayKey;
  String category;
  Duration duration;
  DateTime timeModified;

  // constructor if manually adding
  UserDataItem({
    this.dayKey,
    this.category,
    this.duration,
    this.timeModified,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'dayKey': this.dayKey,
      'category': this.category,
      'duration': this.duration.inMilliseconds,
      'timeModified': this.timeModified.toString(),
    };
  }

  UserDataItem.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.dayKey = map['dayKey'];
    this.category = map['category'];
    this.duration = new Duration(milliseconds: map['duration']);
    this.timeModified = DateTime.parse(map['timeModified']);
  }
}