

// Determines the current day
DateTime extractDay(DateTime input){
  DateTime day = new DateTime.utc(input.year, input.month, input.day, 12);
  return day;
}